import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TestScreen extends StatefulWidget {
  final String code;

  // const TableScreen({required Key key, required this.code}) : super(key: key);

  const TestScreen ({required this.code});


  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {

  List _matches = [];
  List _teams = [];
  var _teamWins = Map<String, int>();

  Future<bool> getMatches() async {
    print (">> Getting matches in competition..."+ widget.code);

    String now = DateFormat("yyyy-MM-dd").format(DateTime.now());
    String thirtyDaysAgo = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 30)));

    var uri = Uri.https('api.football-data.org',
        '/v2/competitions/${widget.code}/matches',
        {'q': 'dateFrom=${thirtyDaysAgo}&dateTo=${now}'});
    var matchesResponse = await http.get(uri,
        headers: {'X-Auth-Token': 'e4c06911610d4282969921e96479154a'});
    String body = matchesResponse.body;
    Map matchesData = jsonDecode(body);
    List matches = matchesData['matches'];

    // print("Matches "+ matches.toString());

    // _matches = matches;

    setState(() {
      _matches = matches;
    });
    return true;
  }

  getTeams() async {
    print (">> Getting teams in competition...");
    var uri = Uri.https('api.football-data.org',
        '/v2/competitions/${widget.code}/teams');
    var teamsResponse = await http.get(uri,
        headers: {'X-Auth-Token': 'e4c06911610d4282969921e96479154a'});
    String teamsBody = teamsResponse.body;
    Map teamsData = jsonDecode(teamsBody);
    List teams = teamsData['teams'];
    for (var team in teams){
      _teamWins[team['name']]= 0;
    }
    // _teams = teams;
    setState(() {
      _teams = teams;
    });
  }

  getWinningTeam() async {
    print (">> Getting winning team in competition...");
    bool hasData = await getMatches();

    for (var match in _matches){

      String result = match['score']['winner'];
      String winningTeamID;

      if (result == 'HOME_TEAM'){
        winningTeamID = match['homeTeam']['name'];
      }
      else if (result == 'AWAY_TEAM'){
        winningTeamID = match['awayTeam']['name'];
      }
      else break;

      // print ('winning team ID '+ winningTeamID.toString());

      _teamWins.update(winningTeamID, (value) => value + 1);

    }

    // print (_teamWins);
    // _teamWins.forEach((key, value) {
    //   print ( key + ' ' + value.toString());
    // });

  }

  Widget buildTable() {
    List<Widget> teams = [];
    for (var team in _matches) {
      teams.add(
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    team['position'].toString().length > 1
                        ? Text(team['position'].toString() + ' - ')
                        : Text(" " + team['position'].toString() + ' - '),
                    Row(
                      children: [
                        SvgPicture.network(
                          team['team']['crestUrl'],
                          height: 30,
                          width: 30,
                        ),
                        team['team']['name'].toString().length > 11
                            ? Text(team['team']['name']
                            .toString()
                            .substring(0, 11) +
                            '...')
                            : Text(team['team']['name'].toString()),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(team['playedGames'].toString()),
                    Text(team['won'].toString()),
                    Text(team['draw'].toString()),
                    Text(team['lost'].toString()),
                    Text(team['goalDifference'].toString()),
                    Text(team['points'].toString()),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Column(
      children: teams,
    );
  }

  Widget showTeams(){
    List<Widget> teams = [];
    // for (var team in _teamWins){

    _teamWins.forEach((clubName, value) {
      teams.add(
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Expanded(
                  child: Row(
                    children: [
                      Text(clubName),

                ],
              )
              ),
              SizedBox(
                width: 1,
              ),
              Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text(value.toString())
              ]

                ),
              )
            ],
          ),
        )
      );
    });

    return Column(
      children: teams,
    );
  }

  @override
  void initState() {
    super.initState();
    print ("Initiating");
    getMatches();
    getTeams();
    getWinningTeam();
  }

  @override
  Widget build(BuildContext context) {
    return _matches == null
        ? Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Color(0xFFe70066),
          ),
        ),
      ),
    )
        : Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xffe84860),
                const Color(0xffe70066),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            )),
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Club',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Wins',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),

            // buildTable(),
            showTeams(),
          ],
        ),
      ),
    );
  }
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(IterableProperty<>('_table', _table));
  // }
}
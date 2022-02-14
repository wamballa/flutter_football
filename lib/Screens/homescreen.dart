import 'package:flutter/material.dart';
import 'package:flutter_football_api/Screens/testscreen.dart';
import 'package:flutter_football_api/Widgets/LeagueContainer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffe84860),
                  Color(0xffe70066),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Competitions',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: [
                    GestureDetector(
                      child: LeagueContainer(image: 'assets/pl.png'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TestScreen(code: 'PL'),
                            ));
                      },
                    ),
                    GestureDetector(
                      child: LeagueContainer(image: 'assets/laliga.png'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TestScreen(code: 'PD'),
                            ));
                      },
                    ),
                    GestureDetector(
                      child: LeagueContainer(image: 'assets/bundesliga.png'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TestScreen(code: 'BL1'),
                            ));
                      },
                    ),
                    GestureDetector(
                      child: LeagueContainer(image: 'assets/seria.png'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TestScreen(code: 'SA'),
                            ));
                      },
                    ),
                    GestureDetector(
                      child: LeagueContainer(image: 'assets/ligue1.png'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TestScreen(code: 'FL1'),
                            ));
                      },
                    ),
                    GestureDetector(
                      child: LeagueContainer(image: 'assets/nos.png'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TestScreen(code: 'PPL'),
                            ));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
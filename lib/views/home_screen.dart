import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacexplorer/blocs/mission/mission.dart';
import 'package:spacexplorer/blocs/profile/profile.dart';
import 'package:spacexplorer/blocs/leaderboard/leaderboard.dart';
import 'package:spacexplorer/graphQl/Queries.dart';
import 'package:spacexplorer/views/main_screen.dart';
import 'package:spacexplorer/views/mission_screen.dart';
import 'package:spacexplorer/views/leader_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key,  this.token}) : super(key: key);

  final String token;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = <Widget>[
      BlocProvider<ProfileBloc>(
        create: (BuildContext context) => ProfileBloc()..add(FetchProfileData(getProfile, widget.token)),
        child: MainScreen(token : widget.token),
      ),
      BlocProvider<MissionBloc>(
        create: (BuildContext context) => MissionBloc()..add(FetchMissionData(getPlane, widget.token)),
        child: MissionScreen(token : widget.token),
      ),
      BlocProvider<LeaderBloc>(
        create: (BuildContext context) => LeaderBloc()..add(FetchLeaderData(getLeaderBoard, widget.token)),
        child: LeaderScreen(token : widget.token),
      )
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF2E3192),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: const Text('Maison',
                style: TextStyle(
                  color: Colors.white,
                )),
            icon: Image.asset('assets/img/page.png', width: 40),
          ),
          BottomNavigationBarItem(
            title: const Text('Lancement',
                style: TextStyle(
                  color: Colors.white,
                )),
            icon: Image.asset('assets/img/rocket.png', width: 40),
          ),
          BottomNavigationBarItem(
            title: const Text('Leaderboard',
                style: TextStyle(
                  color: Colors.white,
                )),
            icon: Image.asset('assets/img/Historique.png', width: 40),
          )
        ],
      ),
      body: _children[_currentIndex],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacexplorer/blocs/mission/mission.dart';
import 'package:spacexplorer/blocs/profile/profile.dart';
import 'package:spacexplorer/blocs/trip/trip.dart';
import 'package:spacexplorer/graphQl/Queries.dart';
import 'package:spacexplorer/views/main_screen.dart';
import 'package:spacexplorer/views/trip_screen.dart';
import 'package:spacexplorer/views/mission_screen.dart';

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
      BlocProvider<TripBloc>(
        create: (BuildContext context) => TripBloc()..add(FetchTripData(getTrip, widget.token)),
        child: TripScreen(token : widget.token),
      ),
      Container(color: Colors.white),
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
            title: const Text('Historique',
                style: TextStyle(
                  color: Colors.white,
                )),
            icon: Image.asset('assets/img/Historique.png', width: 40),
          ),
          BottomNavigationBarItem(
            title: const Text('Profile',
                style: TextStyle(
                  color: Colors.white,
                )),
            icon: Image.asset('assets/img/home.png', width: 40),
          ),
          const BottomNavigationBarItem(
            title: Text('Signout',
                style: TextStyle(
                  color: Colors.white,
                )),
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: _children[_currentIndex],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacexplorer/blocs/profile/profile.dart';
import 'package:spacexplorer/models/spaceXFactory.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key, this.token}) : super(key: key);

  final String token;

  @override
  _MainScreenState createState() => _MainScreenState();
}


class _MainScreenState extends State<MainScreen> {
  ProfileList profile;
  Widget _displayHomePage() {
    return SizedBox.expand(
      child: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            image: const DecorationImage(
              image: AssetImage('assets/img/homePage.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height / 1.5,
                left: MediaQuery.of(context).size.width / 3,
                bottom: MediaQuery.of(context).size.height / 3.90,
                child: Image.asset(
                  'assets/img/cosmonautes.png',
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width / 6.4,
                height: MediaQuery.of(context).size.height / 6.4,
                left: MediaQuery.of(context).size.width / 2.23,
                bottom: MediaQuery.of(context).size.height / 1.86,
                child: CircleAvatar(
                  radius: 75,
                  backgroundImage: NetworkImage((() {
                    if (profile.profileItem[0].avatar != null) {
                      return profile.profileItem[0].avatar;
                    } else {
                      return 'https://lunar-typhoon-spear.glitch.me/img/default-image.png';
                    }
                  })()),
                ),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileStates>(
        builder: (BuildContext context, ProfileStates state) {
      if (state is LoadDataSuccess)
        {
          profile = ProfileList.fromJson(state.data['user'] as List<dynamic>);
          return _displayHomePage();
        }
      else if (state is LoadDataFail)
        return Container();
      else
        return Container(
          child: Center(
            child: Text('loading'),
          ),
        );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacexplorer/blocs/leaderboard/leaderboard.dart';
import 'package:spacexplorer/models/spaceXFactory.dart';

class LeaderScreen extends StatefulWidget {
  const LeaderScreen({Key key,  this.token}) : super(key: key);
  final String token;
  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<LeaderScreen> {
  LeaderList user;
  Widget _displayLeader() {
    return ListView.builder(
        itemCount: user.leaderItem.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final Leader userItem = user.leaderItem[index];
          return GestureDetector(
              child: Card(
                  child: ListTile(
                    title: Text(userItem.user.username),
                  )
              )
          );
        });
  }

  @override

  Widget build(BuildContext context) {
    return BlocBuilder<LeaderBloc, LeaderStates>(
        builder: (BuildContext context, LeaderStates state) {
          if (state is LoadDataSuccess)
          {
            print(state.data);
            user = LeaderList.fromJson(state.data['leaderboard'] as List<dynamic>);
            return _displayLeader();
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

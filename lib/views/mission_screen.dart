import 'package:flutter/material.dart';
import 'package:spacexplorer/blocs/mission/mission.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacexplorer/graphQl/Mutation.dart';
import 'package:spacexplorer/graphQl/Queries.dart';
import 'package:spacexplorer/models/spaceXFactory.dart';

class MissionScreen extends StatefulWidget {
  const MissionScreen({Key key, this.title, this.token}) : super(key: key);

  final String title;
  final String token;

  @override
  _MissionScreenState createState() => _MissionScreenState();
}

class _MissionScreenState extends State<MissionScreen> {
  MissionBloc bloc;
  LaunchList launches;

  Widget _displayPlane() {
    return ListView.builder(
        itemCount: launches.launchList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final LaunchItem launch = launches.launchList[index];
          return GestureDetector(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Image.network((() {
                      if (launch.mission.missionPatch != null) {
                        return launch.mission.missionPatch;
                      } else {
                        return 'https://lunar-typhoon-spear.glitch.me/img/default-image.png';
                      }
                    })()),
                    title: Text(launch.mission.name),
                    subtitle: Text(launch.rocket.name),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(width: 8),
                      RaisedButton(
                        child: const Text('Partir en voyage'),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) => new AlertDialog(
                                  title: new Text("Loading", style: TextStyle(color: Colors.white)),
                                  content: new Container(
                                      child: new SizedBox(
                                        width: 40,
                                        height: 40,
                                      ))));
                          super.setState(() {
                            bloc.add(BookTrip(bookATrip, widget.token,
                                variables: <String, dynamic>{
                                  'launch_id': launch.missionID
                                }));
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MissionBloc, MissionStates>(
      builder: (BuildContext context, MissionStates state) {
        bloc = BlocProvider.of<MissionBloc>(context);
        if (state is LoadDataFail) {
          return _displayPlane();
        } else if (state is LoadDataSuccess) {
          print(state.data);
          launches = LaunchList.fromJson(
              state.data['launches']['launches'] as List<dynamic>);
          return _displayPlane();
        } else if (state is LoadBookTripSuccess) {
          Navigator.pop(context);
          bloc.add(FetchMissionData(getPlane, widget.token));
          return _displayPlane();
        } else
          return Container(
            child: Center(
              child: Text('loading'),
            ),
          );
      },
    );
  }
}

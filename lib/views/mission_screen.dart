import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
  MissionList launches;
  final String date = DateFormat('MM-dd').format(DateTime.now());
  final String day = DateFormat('EEEE').format(DateTime.now());
  final DateTime time = DateTime.now();

  Widget _displayPlane() {
    return ListView.builder(
        itemCount: launches.missionItem.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final MissionItem launch = launches.missionItem[index];
          print(time.hour + 2);
          print(launch.launchDate);
          if (date == launch.launchDate || day == launch.launchDate) {
            if (time.hour + 2 >= launch.startHour &&
                time.hour + 2 <= launch.endHour) {
              return GestureDetector(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Image.network((() {
                          if (launch.planet.picture != null) {
                            return launch.picture;
                          } else {
                            return 'https://lunar-typhoon-spear.glitch.me/img/default-image.png';
                          }
                        })()),
                        title: Text(launch.planet.name),
                        subtitle: Text(launch.rocketName),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          const SizedBox(width: 8),
                          RaisedButton(
                            child: const Text('Partir en voyage'),
                            onPressed: () {
                              EasyLoading.show(status: 'loading...');

                              super.setState(() {
                                bloc.add(BookTrip(bookATrip, widget.token,
                                    variables: <String, dynamic>{
                                      'launch_id': launch.id
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
            } else
              return Container();
          } else
            return Container();
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
          print(state.data['my_trips']);
          launches =
              MissionList.fromJson(state.data['my_trips'] as List<dynamic>);
          print(launches);
          return _displayPlane();
        } else if (state is LoadBookTripSuccess) {
          EasyLoading.dismiss();
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

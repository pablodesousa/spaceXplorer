import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacexplorer/blocs/trip/trip.dart';
import 'package:spacexplorer/models/spaceXFactory.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({Key key,  this.token}) : super(key: key);
  final String token;
  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  SpaceList trips;
  Widget _displayPlane() {
    return ListView.builder(
        itemCount: trips.spaceList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final SpaceXItem trip = trips.spaceList[index];
          return GestureDetector(
              child: Card(
                  child: ListTile(
                    title: Text(trip.spaceX.mission.name),
                  )
              )
          );
        });
  }

  @override

  Widget build(BuildContext context) {
    return BlocBuilder<TripBloc, TripStates>(
        builder: (BuildContext context, TripStates state) {
          if (state is LoadDataSuccess)
          {
            print(state.data);
            trips = SpaceList.fromJson(state.data['trips'] as List<dynamic>);
            return _displayPlane();
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

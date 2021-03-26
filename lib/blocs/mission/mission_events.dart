import 'package:equatable/equatable.dart';

abstract class MissionEvents extends Equatable {
  MissionEvents();

  @override
  List<Object> get props => null;
}

class FetchMissionData extends MissionEvents {
  final String query;
  final String token;
  final Map<String, dynamic> variables;

  FetchMissionData(this.query, this.token, {this.variables}) : super();

  @override
  List<Object> get props => [query, variables];
}

class BookTrip extends MissionEvents {
  final String query;
  final String token;
  final Map<String, dynamic> variables;

  BookTrip(this.query, this.token, {this.variables}) : super();

  @override
  List<Object> get props => [query, variables];
}
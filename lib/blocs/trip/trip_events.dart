import 'package:equatable/equatable.dart';

abstract class TripEvents extends Equatable {
  TripEvents();

  @override
  List<Object> get props => null;
}

class FetchTripData extends TripEvents {
  final String query;
  final String token;
  final Map<String, dynamic> variables;

  FetchTripData(this.query, this.token, {this.variables}) : super();

  @override
  List<Object> get props => [query, variables];
}
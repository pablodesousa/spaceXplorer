import 'package:equatable/equatable.dart';

abstract class LeaderEvents extends Equatable {
  LeaderEvents();

  @override
  List<Object> get props => null;
}

class FetchLeaderData extends LeaderEvents {
  final String query;
  final String token;
  final Map<String, dynamic> variables;

  FetchLeaderData(this.query, this.token, {this.variables}) : super();

  @override
  List<Object> get props => [query, variables];
}
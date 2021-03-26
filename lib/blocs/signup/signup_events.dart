import 'package:equatable/equatable.dart';

abstract class SignupEvents extends Equatable {
  SignupEvents();

  @override
  List<Object> get props => null;
}

class FetchSignupData extends SignupEvents {
  final String query;
  final String token;
  final Map<String, dynamic> variables;

  FetchSignupData(this.query, this.token, {this.variables}) : super();

  @override
  List<Object> get props => [query, variables];
}
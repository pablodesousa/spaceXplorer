import 'package:equatable/equatable.dart';

abstract class LoginEvents extends Equatable {
  LoginEvents();

  @override
  List<Object> get props => null;
}

class FetchLoginData extends LoginEvents {
  final String query;
  final String token;
  final Map<String, dynamic> variables;

  FetchLoginData(this.query, this.token, {this.variables}) : super();

  @override
  List<Object> get props => [query, variables];
}

class SetDefault extends LoginEvents {
  SetDefault() : super();
}
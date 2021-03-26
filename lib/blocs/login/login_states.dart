import 'package:equatable/equatable.dart';

abstract class LoginStates extends Equatable {
  LoginStates();

  @override
  List<Object> get props => null;
}

class Default extends LoginStates {
  Default() : super();
}

class LoadDataSuccess extends LoginStates {
  final dynamic data;
  LoadDataSuccess(this.data) : super();
  @override
  List<Object> get props => data;
}

class LoadDataFail extends LoginStates {
  final dynamic error;

  LoadDataFail(this.error) : super();

  @override
  List<Object> get props => error;
}
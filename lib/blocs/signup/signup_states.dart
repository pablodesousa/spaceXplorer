import 'package:equatable/equatable.dart';

abstract class SignupStates extends Equatable {
  SignupStates();

  @override
  List<Object> get props => null;
}

class Loading extends SignupStates {
  Loading() : super();
}

class LoadDataSuccess extends SignupStates {
  final dynamic data;
  LoadDataSuccess(this.data) : super();
  @override
  List<Object> get props => data;
}

class LoadDataFail extends SignupStates {
  final dynamic error;

  LoadDataFail(this.error) : super();

  @override
  List<Object> get props => error;
}
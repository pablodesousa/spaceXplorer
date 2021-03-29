import 'package:equatable/equatable.dart';

abstract class ProfileStates extends Equatable {
  ProfileStates();

  @override
  List<Object> get props => null;
}

class Loading extends ProfileStates {
  Loading() : super();
}

class Picture extends ProfileStates {
  Picture() : super();
}

class Upload extends ProfileStates {
  Upload() : super();
}

class LoadDataSuccess extends ProfileStates {
  final dynamic data;
  LoadDataSuccess(this.data) : super();
  @override
  List<Object> get props => data;
}

class LoadDataFail extends ProfileStates {
  final dynamic error;

  LoadDataFail(this.error) : super();

  @override
  List<Object> get props => error;
}
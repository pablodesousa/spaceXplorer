import 'package:equatable/equatable.dart';

abstract class MissionStates extends Equatable {
  MissionStates();

  @override
  List<Object> get props => null;
}

class Loading extends MissionStates {
  Loading() : super();
}

class LoadDataSuccess extends MissionStates {
  final dynamic data;
  LoadDataSuccess(this.data) : super();
  @override
  List<Object> get props => data;
}

class LoadDataFail extends MissionStates {
  final dynamic error;

  LoadDataFail(this.error) : super();

  @override
  List<Object> get props => error;
}

class LoadBookTripSuccess extends MissionStates {
  final dynamic data;

  LoadBookTripSuccess(this.data) : super();

  @override
  List<Object> get props => data;
}
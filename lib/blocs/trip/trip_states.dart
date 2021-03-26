import 'package:equatable/equatable.dart';

abstract class TripStates extends Equatable {
  TripStates();

  @override
  List<Object> get props => null;
}

class Loading extends TripStates {
  Loading() : super();
}

class LoadDataSuccess extends TripStates {
  final dynamic data;
  LoadDataSuccess(this.data) : super();
  @override
  List<Object> get props => data;
}

class LoadDataFail extends TripStates {
  final dynamic error;

  LoadDataFail(this.error) : super();

  @override
  List<Object> get props => error;
}
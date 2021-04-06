import 'package:equatable/equatable.dart';

abstract class LeaderStates extends Equatable {
  LeaderStates();

  @override
  List<Object> get props => null;
}

class Loading extends LeaderStates {
  Loading() : super();
}

class LoadDataSuccess extends LeaderStates {
  final dynamic data;
  LoadDataSuccess(this.data) : super();
  @override
  List<Object> get props => data;
}

class LoadDataFail extends LeaderStates {
  final dynamic error;

  LoadDataFail(this.error) : super();

  @override
  List<Object> get props => error;
}
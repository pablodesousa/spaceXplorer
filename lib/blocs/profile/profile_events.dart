import 'package:equatable/equatable.dart';

abstract class ProfileEvents extends Equatable {
  ProfileEvents();

  @override
  List<Object> get props => null;
}

class FetchProfileData extends ProfileEvents {
  final String query;
  final String token;
  final Map<String, dynamic> variables;

  FetchProfileData(this.query, this.token, {this.variables}) : super();

  @override
  List<Object> get props => [query, variables];
}

class SetProfilePicture extends ProfileEvents {
  final String query;
  final String token;
  final Map<String, dynamic> variables;

  SetProfilePicture(this.query, this.token, {this.variables}) : super();

  @override
  List<Object> get props => [query, variables];
}

class SetPicture extends ProfileEvents {
  SetPicture() : super();
}
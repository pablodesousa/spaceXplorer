import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacexplorer/blocs/profile/profile.dart';
import 'package:spacexplorer/services/service.dart';

class ProfileBloc extends Bloc<ProfileEvents, ProfileStates> {
  GraphQLService service;

  ProfileBloc() {
    service = GraphQLService();
  }

  @override
  ProfileStates get initialState => Loading();

  @override
  Stream<ProfileStates> mapEventToState(ProfileEvents event) async* {
    if (event is FetchProfileData) {
      yield* _mapFetchProfileDataToStates(event);
    }
    if (event is SetPicture) {
      yield Picture();
    }
    if (event is SetProfilePicture) {
      yield* _setProfilePicture(event);
    }
  }
  Stream<ProfileStates> _setProfilePicture(SetProfilePicture event) async* {
    final query = event.query;
    final token = event.token;
    final variables = event.variables ?? null;

    try {
      final result = await service.performMutation(query, token, variables: variables);

      if (result.hasException) {
        print('graphQLErrors: ${result.exception.graphqlErrors[0].toString()}');
        print('clientErrors: ${result.exception.clientException.toString()}');
      } else {
        yield Upload();
      }
    } catch (e) {
      print(e);
    }
  }
  Stream<ProfileStates> _mapFetchProfileDataToStates(FetchProfileData event) async* {
    final query = event.query;
    final token = event.token;
    final variables = event.variables ?? null;

    try {
      final result = await service.performQuery(query, token, variables: variables);

      if (result.hasException) {
        print('graphQLErrors: ${result.exception.graphqlErrors[0].toString()}');
        print('clientErrors: ${result.exception.clientException.toString()}');
        yield LoadDataFail(result.exception.graphqlErrors[0].toString());
      } else {
        yield LoadDataSuccess(result.data);
      }
    } catch (e) {
      print(e);
      yield LoadDataFail(e.toString());
    }
  }
}
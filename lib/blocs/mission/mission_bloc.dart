import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacexplorer/blocs/mission/mission.dart';
import 'package:spacexplorer/services/service.dart';

class MissionBloc extends Bloc<MissionEvents, MissionStates> {
  GraphQLService service;

  MissionBloc() {
    service = GraphQLService();
  }

  @override
  MissionStates get initialState => Loading();

  @override
  Stream<MissionStates> mapEventToState(MissionEvents event) async* {
    if (event is FetchMissionData) {
      yield* _mapFetchMissionDataToStates(event);
    }
    if (event is BookTrip) {
      yield* _mapFetchBookTripToStates(event);
    }
  }

  Stream<MissionStates> _mapFetchMissionDataToStates(FetchMissionData event) async* {
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

  Stream<MissionStates> _mapFetchBookTripToStates(BookTrip event) async* {
    final query = event.query;
    final token = event.token;
    final variables = event.variables ?? null;

    try {
      final result = await service.performMutation(query, token, variables: variables);

      if (result.hasException) {
        print('graphQLErrors: ${result.exception.graphqlErrors[0].toString()}');
        print('clientErrors: ${result.exception.clientException.toString()}');
        yield LoadDataFail(result.exception.graphqlErrors[0].toString());
      } else {
        yield LoadBookTripSuccess(result.data);
      }
    } catch (e) {
      print(e);
      yield LoadDataFail(e.toString());
    }
  }
}
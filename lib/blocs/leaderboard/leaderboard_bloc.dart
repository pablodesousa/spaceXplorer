import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacexplorer/blocs/leaderboard/leaderboard.dart';
import 'package:spacexplorer/services/service.dart';

class LeaderBloc extends Bloc<LeaderEvents, LeaderStates> {
  GraphQLService service;

  LeaderBloc() {
    service = GraphQLService();
  }

  @override
  LeaderStates get initialState => Loading();

  @override
  Stream<LeaderStates> mapEventToState(LeaderEvents event) async* {
    if (event is FetchLeaderData) {
      yield* _mapFetchLeaderDataToStates(event);
    }
  }

  Stream<LeaderStates> _mapFetchLeaderDataToStates(FetchLeaderData event) async* {
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
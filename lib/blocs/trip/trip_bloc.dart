import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacexplorer/blocs/trip/trip.dart';
import 'package:spacexplorer/services/service.dart';

class TripBloc extends Bloc<TripEvents, TripStates> {
  GraphQLService service;

  TripBloc() {
    service = GraphQLService();
  }

  @override
  TripStates get initialState => Loading();

  @override
  Stream<TripStates> mapEventToState(TripEvents event) async* {
    if (event is FetchTripData) {
      yield* _mapFetchTripDataToStates(event);
    }
  }

  Stream<TripStates> _mapFetchTripDataToStates(FetchTripData event) async* {
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
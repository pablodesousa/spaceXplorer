import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacexplorer/blocs/login/login.dart';
import 'package:spacexplorer/services/service.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  GraphQLService service;

  LoginBloc() {
    service = GraphQLService();
  }

  @override
  LoginStates get initialState => Default();

  @override
  Stream<LoginStates> mapEventToState(LoginEvents event) async* {
    if (event is FetchLoginData) {
      yield* _mapFetchLoginDataToStates(event);
    }
    if (event is SetDefault) {
      yield Default();
    }
  }

  Stream<LoginStates> _mapFetchLoginDataToStates(FetchLoginData event) async* {
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacexplorer/blocs/signup/signup.dart';
import 'package:spacexplorer/services/service.dart';

class SignupBloc extends Bloc<SignupEvents, SignupStates> {
  GraphQLService service;

  SignupBloc() {
    service = GraphQLService();
  }

  @override
  SignupStates get initialState => Loading();

  @override
  Stream<SignupStates> mapEventToState(SignupEvents event) async* {
    if (event is FetchSignupData) {
      yield* _mapFetchSignupDataToStates(event);
    }
  }

  Stream<SignupStates> _mapFetchSignupDataToStates(FetchSignupData event) async* {
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
        yield LoadDataSuccess(result.data);
      }
    } catch (e) {
      print(e);
      yield LoadDataFail(e.toString());
    }
  }
}
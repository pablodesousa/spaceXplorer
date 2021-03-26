import 'package:graphql/client.dart';
import 'package:spacexplorer/graphQl/Connection.dart';

class GraphQLService {

  Future<QueryResult> performQuery(String query, String token,
      {Map<String, dynamic> variables}) async {
    QueryOptions options =
    QueryOptions(documentNode: gql(query), variables: variables);
    if(token != '')
      return await clientSetup(token).query(options);
    else
      return await clientSetup('').query(options);
  }

  Future<QueryResult> performMutation(String query, String token,
      {Map<String, dynamic> variables}) async {
    MutationOptions options =
    MutationOptions(documentNode: gql(query), variables: variables);
    if(token != '')
      return await clientSetup(token).mutate(options);
    else
     return await clientSetup('').mutate(options);
  }
}


import 'package:graphql_flutter/graphql_flutter.dart';

final Policies policies = Policies(
  fetch: FetchPolicy.networkOnly,
);

final HttpLink httpLink = HttpLink(
  uri: "https://api.graphql.jobs/",
);

GraphQLClient clientSetup(var token) {
  if (token == "")
    return GraphQLClient(
      link: HttpLink(uri: 'https://flutter-spacex.herokuapp.com/v1/graphql'),
      cache: InMemoryCache(),
      defaultPolicies: DefaultPolicies(
        watchQuery: policies,
        query: policies,
        mutate: policies,
      ),
    );
  else
    return GraphQLClient(
      link: HttpLink(uri: 'https://flutter-spacex.herokuapp.com/v1/graphql', headers: <String, String> {
        'Authorization': 'Bearer ' + token,
      }),
      cache: InMemoryCache(),
      defaultPolicies: DefaultPolicies(
        watchQuery: policies,
        query: policies,
        mutate: policies,
      ),
    );
}
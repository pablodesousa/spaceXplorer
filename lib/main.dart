import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacexplorer/blocs/login/login.dart';
import 'package:spacexplorer/blocs/simple_delegate.dart';
import 'package:spacexplorer/graphQl/Queries.dart';
import 'package:spacexplorer/views/login_screen.dart';

void main() {
  BlocSupervisor.delegate = MySimpleBlocDelegate();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF2E3192),
      ),
      home: BlocProvider<LoginBloc>(
        create: (BuildContext context) => LoginBloc(),
        child: LoginScreen(),
      ),

    );
  }
}

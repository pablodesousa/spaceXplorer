import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacexplorer/blocs/login/login.dart';
import 'package:spacexplorer/views/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spacexplorer/graphQl/Queries.dart';
import 'package:spacexplorer/views/signup_screen.dart';
import 'package:spacexplorer/blocs/signup/signup.dart' as signup;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Map<String, dynamic> data;
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  LoginBloc bloc;

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: const Icon(Icons.keyboard_arrow_left, color: Colors.white),
            ),
            const Text('Back',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white))
          ],
        ),
      ),
    );
  }

  Widget _passwordField(String title, {bool isPassword = true}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              controller: password,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  hintText: 'Password',
                  filled: true))
        ],
      ),
    );
  }

  Widget _usernameField(String title, {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              controller: username,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  hintText: 'Username',
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                title: new Text("Loading"),
                content: new Container(
                    child: new SizedBox(
                  width: 40,
                  height: 40,
                ))));
        super.setState(() {
          bloc.add(FetchLoginData(getUserLogin, '',
              variables: <String, dynamic>{
                'username': username.text,
                'password': password.text
              }));
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        child: const Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    BlocProvider<signup.SignupBloc>(
                      create: (BuildContext context) => signup.SignupBloc(),
                      child: SignUpScreen(),
                    )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'SpaceXplorer',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          )),
    );
  }

  Widget login() {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2)
        ],
        image: const DecorationImage(
          image: AssetImage('assets/img/Background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      height: height,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  _title(),
                  const SizedBox(height: 50),
                  _usernameField('username'),
                  const SizedBox(height: 50),
                  _passwordField('password'),
                  const SizedBox(height: 20),
                  _submitButton(),
                  SizedBox(height: height * .055),
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
          Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginStates>(
      builder: (BuildContext context, LoginStates state) {
        bloc = BlocProvider.of<LoginBloc>(context);
        print(state);
        if (state is LoadDataFail) {
          return login();
        } else if (state is LoadDataSuccess) {
          data = state.data;
          print(data);
          Navigator.pop(context);
          return HomeScreen(token: data['Login']['token']);
        } else
          return login();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:spacexplorer/views/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spacexplorer/blocs/signup/signup.dart';
import 'package:spacexplorer/blocs/login/login.dart' as login;
import 'package:spacexplorer/graphQl/Mutation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();
  SignupBloc bloc;

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

  Widget _emailField(String title, {bool isPassword = false}) {
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
              controller: email,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  hintText: 'E-mail',
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return GestureDetector(
        onTap: () {
          super.setState(() {
            bloc.add(FetchSignupData(signUpUser, '', variables: <String, dynamic> {
              'username': username.text, 'password': password.text, 'email': email.text
            }));
          });

    },
    child:
      Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white),
      child: const Text(
        'Register',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    ));
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        print('test');
        Navigator.push(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    BlocProvider<login.LoginBloc>(
                      create: (BuildContext context) => login.LoginBloc(),
                      child: LoginScreen(),
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
              'Already have an account ?',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
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
            textStyle: Theme
                .of(context)
                .textTheme
                .headline4,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          )),
    );
  }

  Widget signup() {
    return Scaffold(
      body: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
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
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: MediaQuery
                          .of(context)
                          .size
                          .height * .2),
                      _title(),
                      const SizedBox(
                        height: 50,
                      ),
                      _emailField('email'),
                      const SizedBox(
                        height: 50,
                      ),
                      _usernameField('username'),
                      const SizedBox(
                        height: 50,
                      ),
                      _passwordField('password'),
                      const SizedBox(
                        height: 20,
                      ),
                      _submitButton(),
                      SizedBox(height: MediaQuery
                          .of(context)
                          .size
                          .height * .14),
                      _loginAccountLabel(),
                    ],
                  ),
                ),
              ),
              Positioned(top: 40, left: 0, child: _backButton()),
            ],
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupStates>(
      builder: (BuildContext context, SignupStates state) {
        bloc = BlocProvider.of<SignupBloc>(context);
        if (state is LoadDataFail) {
          return signup();
        } else if (state is LoadDataSuccess) {

          return BlocProvider<login.LoginBloc>(
            create: (BuildContext context) => login.LoginBloc(),
            child: LoginScreen(),
          );
        } else
          return signup();
      },
    );
  }
}

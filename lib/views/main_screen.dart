import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spacexplorer/blocs/profile/profile.dart';
import 'package:spacexplorer/graphQl/Mutation.dart';
import 'package:spacexplorer/models/spaceXFactory.dart';
import 'package:spacexplorer/graphQl/Queries.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key, this.token}) : super(key: key);

  final String token;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  File _image;
  ImagePicker picker = ImagePicker();
  String image64;
  final String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();
  ProfileBloc bloc;

  String getRandomString(int length) =>
      String.fromCharCodes(Iterable<int>.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  ProfileList profile;

  Future<void> getImage() async {
    final PickedFile pickedFile =
    await picker.getImage(source: ImageSource.camera);

    super.setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        final Uint8List image = File(pickedFile.path).readAsBytesSync();
        image64 = base64Encode(image);
        bloc.add(SetProfilePicture(uploadAvatar, widget.token,
            variables: <String, dynamic>{
              'base64str': image64,
              'name': getRandomString(15) + '.jpg',
              'type': 'image/jpeg'
            }));
      }
    });
  }

  Widget _displayMainPage() {
    return SizedBox.expand(
      child: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            image: const DecorationImage(
              image: AssetImage('assets/img/homePage.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height / 1.5,
                left: MediaQuery.of(context).size.width / 3,
                bottom: MediaQuery.of(context).size.height / 3.90,
                child: Image.asset(
                  'assets/img/cosmonautes.png',
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width / 6.4,
                height: MediaQuery.of(context).size.height / 6.4,
                left: MediaQuery.of(context).size.width / 2.23,
                bottom: MediaQuery.of(context).size.height / 1.86,
                child: CircleAvatar(
                  radius: 75,
                  backgroundImage: NetworkImage((() {
                    if (profile.profileItem[0].avatar != null) {
                      return profile.profileItem[0].avatar;
                    } else {
                      return 'https://lunar-typhoon-spear.glitch.me/img/default-image.png';
                    }
                  })()),
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width / 8,
                height: MediaQuery.of(context).size.height / 8,
                left: MediaQuery.of(context).size.width / 4,
                bottom: MediaQuery.of(context).size.height / 1.80,
                child: GestureDetector(
                  onTap: () {
                    super.setState(() {
                      bloc.add(SetPicture());
                    });
                  },
                  child: const Icon(Icons.add_a_photo, color: Colors.white),
                ),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ProfileBloc>(context);
    return BlocBuilder<ProfileBloc, ProfileStates>(
        builder: (BuildContext context, ProfileStates state) {
          if (state is LoadDataSuccess) {
            profile = ProfileList.fromJson(state.data['user'] as List<dynamic>);
            return _displayMainPage();
          } else if (state is LoadDataFail)
            return Container();
          else if (state is Picture) {
            getImage();

            bloc.add(FetchProfileData(getProfile, widget.token));
            return _displayMainPage();
          } else if (state is Upload) {
            bloc.add(FetchProfileData(getProfile, widget.token));
            return _displayMainPage();
          } else
            return Container(
              child: Center(
                child: Text('loading'),
              ),
            );
        });
  }
}

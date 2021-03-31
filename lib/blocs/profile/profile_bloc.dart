import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacexplorer/blocs/profile/profile.dart';
import 'package:spacexplorer/services/service.dart';

class ProfileBloc extends Bloc<ProfileEvents, ProfileStates> {
  GraphQLService service;

  ProfileBloc() {
    service = GraphQLService();
  }

  @override
  ProfileStates get initialState => Loading();

  @override
  Stream<ProfileStates> mapEventToState(ProfileEvents event) async* {
    if (event is FetchProfileData) {
      yield* _mapFetchProfileDataToStates(event);
    }
    if (event is SetPicture) {
      yield*  _takeProfilePicture();
    }
    if (event is SetProfilePicture) {
      yield* _setProfilePicture(event);
    }
  }

  Stream<ProfileStates> _takeProfilePicture() async* {
    File _image;
    ImagePicker picker = ImagePicker();
    String image64;
    print('test');
    final PickedFile pickedFile =
    await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      final Uint8List image = File(pickedFile.path).readAsBytesSync();
      image64 = base64Encode(image);
      yield PictureSuccess(image64);
    } else
      yield LoadDataFail('problème image');
  }

  Stream<ProfileStates> _setProfilePicture(SetProfilePicture event) async* {
    final query = event.query;
    final token = event.token;
    final variables = event.variables ?? null;

    try {
      final result = await service.performMutation(query, token, variables: variables);

      if (result.hasException) {
        print('graphQLErrors: ${result.exception.graphqlErrors[0].toString()}');
        print('clientErrors: ${result.exception.clientException.toString()}');
      } else {
        yield Upload();
      }
    } catch (e) {
      print(e);
    }
  }
  Stream<ProfileStates> _mapFetchProfileDataToStates(FetchProfileData event) async* {
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
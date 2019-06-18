import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:instagrao/helpers/error.helper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:instagrao/screens/upload/upload.event.dart';
import 'package:instagrao/screens/upload/upload.state.dart';
import 'package:instagrao/widgets/screen/screen.bloc.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final ScreenBloc screenBloc;

  UploadBloc(this.screenBloc);

  UploadState get initialState => UploadState.initial();

  void onUploadButtonPressed({
    String image,
    String title,
    String body,
  }) {
    dispatch(UploadButtonPressed(
      image: image,
      title: title,
      body: body,
    ));
  }

  @override
  Stream<UploadState> mapEventToState(UploadEvent event) async* {
    if (event is UploadButtonPressed) {
      screenBloc.enableLoader();

      try {
        if (event.title.isEmpty || event.body.isEmpty || event.image == null)
          throw ('Complete all required fields!');

        // API Request code here.

        await fakeUpload(event.image, event.title, event.body);

        yield UploadState.success();
      } catch (error) {
        if (error is String) {
          try {
            var validationError = json.decode(error)['validationError'];

            var errorMessage =
                ErrorHelper.formatValidationError(validationError);

            yield UploadState.failure(errorMessage);
          } catch (e) {
            yield UploadState.failure(error);
          }
        } else {
          yield UploadState.failure(error.toString());
        }
      }

      screenBloc.disableLoader();
    }
  }

  Future<List> getPosts() async {
    final storage = new FlutterSecureStorage();

    String postsStr = await storage.read(key: 'posts');

    if (postsStr.isNotEmpty) {
      return json.decode(postsStr);
    } else {
      return [];
    }
  }

  Future fakeUpload(String image, String title, String body) async {
    final storage = new FlutterSecureStorage();

    String username = await storage.read(key: 'username');
    List posts = await getPosts();

    Map post = {
      'username': username,
      'image': image,
      'title': title,
      'body': body,
    };

    posts.add(post);
    
    final postsStr = json.encode(posts);

    await storage.write(key: 'posts', value: postsStr);
  }
}

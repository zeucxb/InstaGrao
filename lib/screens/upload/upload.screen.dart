import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagrao/widgets/primary-button/primary-button.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:instagrao/helpers/validator.helper.dart';

import 'package:instagrao/screens/upload/upload.bloc.dart';
import 'package:instagrao/screens/upload/upload.event.dart';
import 'package:instagrao/screens/upload/upload.state.dart';
import 'package:instagrao/widgets/screen/screen.bloc.dart';
import 'package:instagrao/widgets/screen/screen.widget.dart';
import 'package:instagrao/widgets/view/view.widget.dart';

class UploadScreen extends StatefulWidget {
  @override
  State<UploadScreen> createState() => _UploadScreen();
}

class _UploadScreen extends State<UploadScreen> {
  ScreenBloc screenBloc;
  UploadBloc uploadBloc;

  var _autoValidate = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final titleCtrl = TextEditingController();
  final bodyCtrl = TextEditingController();

  File _image;

  Future getImage() async {
    final File image = await ImagePicker.pickImage(source: ImageSource.camera);

    if (image != null) {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String path = appDocDir.path;

      final String fileName = basename(image.path);
      final File newImage = await image.copy('$path/$fileName');

      setState(() {
        _image = newImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenBloc = ScreenBloc();
    uploadBloc = UploadBloc(screenBloc);

    return BlocBuilder<UploadEvent, UploadState>(
      bloc: uploadBloc,
      builder: (
        BuildContext context,
        UploadState uploadState,
      ) {
        if (uploadState.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(
              context,
            );
          });
        }

        return Screen(
          bloc: screenBloc,
          children: [
            View(
              title: 'Upload',
              error: uploadState.error,
              child: Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: Column(
                  children: <Widget>[
                    _image == null
                        ? IconButton(
                            onPressed: getImage,
                            tooltip: 'Pick Image',
                            icon: Icon(Icons.add_a_photo),
                          )
                        : Image.file(
                            _image,
                            fit: BoxFit.cover,
                          ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Title:'),
                      controller: titleCtrl,
                      validator: ValidatorHelper.notEmpty,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Body:'),
                      controller: bodyCtrl,
                      validator: ValidatorHelper.notEmpty,
                      maxLines: 3,
                    ),
                    PrimaryButton.widget(
                      context,
                      'Upload',
                      uploadState.isUploadButtonEnabled
                          ? _onUploadButtonPressed
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _onUploadButtonPressed() {
    if (_formKey.currentState.validate()) {
      final path = (_image != null) ? _image.path : null;
      uploadBloc.onUploadButtonPressed(
        image: path,
        title: titleCtrl.text,
        body: bodyCtrl.text,
      );
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  void dispose() {
    uploadBloc.dispose();
    super.dispose();
  }
}

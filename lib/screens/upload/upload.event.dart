import 'package:meta/meta.dart';

abstract class UploadEvent {}

class UploadButtonPressed extends UploadEvent {
  final String image;
  final String title;
  final String body;

  UploadButtonPressed({
    @required this.image,
    @required this.title,
    @required this.body,
  });
}
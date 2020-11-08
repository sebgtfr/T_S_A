import 'dart:io';
import 'package:path/path.dart';

import 'package:flutter/material.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatelessWidget {
  PickImage({
    @required this.onPicked,
    @required this.builder,
  });

  final void Function(File file, String filename) onPicked;
  final Widget Function(
          BuildContext context, void Function(ImageSource source) onPressed)
      builder;

  final ImagePicker _imagePicker = ImagePicker();

  void pickImage(ImageSource source) {
    _imagePicker.getImage(source: source).then((PickedFile pickedFile) {
      if (pickedFile != null) {
        final String filename =
            DateTime.now().microsecondsSinceEpoch.toString() +
                '_' +
                basename(pickedFile.path);

        ImageCropper.cropImage(
                sourcePath: pickedFile.path,
                aspectRatioPresets: <CropAspectRatioPreset>[
                  CropAspectRatioPreset.original,
                ],
                androidUiSettings: const AndroidUiSettings(
                  toolbarTitle: 'Cropper',
                  initAspectRatio: CropAspectRatioPreset.original,
                  lockAspectRatio: true,
                ),
                iosUiSettings: const IOSUiSettings(
                  title: 'Cropper',
                  aspectRatioLockEnabled: true,
                ),
                compressQuality: 40)
            .then((File croppedFile) {
          if (croppedFile != null) {
            onPicked(File(croppedFile.path), filename);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return builder(context, pickImage);
  }
}

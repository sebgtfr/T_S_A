import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:tsa_gram/Forms/PostForm.dart';

import 'package:tsa_gram/widgets/PickImage.dart';

class PostImageScreen extends StatefulWidget {
  @override
  _PostImageScreenState createState() => _PostImageScreenState();
}

class _PostImageScreenState extends State<PostImageScreen> {
  File _image;
  String _imageFilename;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: const Text('Select Image'),
        actions: <Widget>[
          PickImage(
            onPicked: (File image, String filename) {
              setState(() {
                _image = image;
                _imageFilename = filename;
              });
            },
            builder:
                (BuildContext context, void Function(ImageSource) pickImage) =>
                    IconButton(
              tooltip: 'Take from camera',
              icon: const Icon(Icons.add_a_photo),
              onPressed: () => pickImage(ImageSource.camera),
            ),
          ),
          PickImage(
            onPicked: (File image, String filename) {
              setState(() {
                _image = image;
                _imageFilename = filename;
              });
            },
            builder:
                (BuildContext context, void Function(ImageSource) pickImage) =>
                    IconButton(
              tooltip: 'Select from photo',
              icon: const Icon(Icons.add_photo_alternate),
              onPressed: () => pickImage(ImageSource.gallery),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: _image != null
              ? Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: Image.file(
                            _image,
                          ),
                        ),
                      ),
                      Expanded(
                        child: PostForm(
                          image: _image,
                          imageFilename: _imageFilename,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}

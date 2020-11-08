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
        title: Text('Select Image'),
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
              icon: Icon(Icons.add_a_photo),
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
              icon: Icon(Icons.add_photo_alternate),
              onPressed: () => pickImage(ImageSource.gallery),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: this._image != null
              ? Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Image.file(
                            this._image,
                          ),
                        ),
                      ),
                      Expanded(
                        child: PostForm(
                          image: this._image,
                          imageFilename: this._imageFilename,
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

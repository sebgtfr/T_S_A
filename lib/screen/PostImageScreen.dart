import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:path/path.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

//import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

import 'package:tsa_gram/models/Posts/PostModel.dart';
import 'package:tsa_gram/models/Posts/PostsProvider.dart';
import 'package:tsa_gram/models/Uploader.dart';
import 'package:tsa_gram/screen/Connected/BaseScreen.dart';
import 'package:tsa_gram/widgets/Button.dart';
import 'package:tsa_gram/widgets/PickImage.dart';
import 'package:tsa_gram/widgets/TextInput.dart';

class PostImageScreen extends StatefulWidget {
  @override
  _PostImageScreenState createState() => _PostImageScreenState();
}

class _PostImageScreenState extends State<PostImageScreen> {
  File _image;
  String _imageFilename;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    final PostsProvider postsProvider = Provider.of<PostsProvider>(context);

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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextInput(
                                controller: _captionController,
                                labelText: 'Caption',
                                obscured: false,
                              ),
                              SizedBox(height: 20),
                              Consumer<Uploader>(
                                builder: (BuildContext context,
                                        final Uploader uploader,
                                        final Widget child) =>
                                    uploader.isUploading
                                        ? LinearProgressIndicator(
                                            value: uploader.progress,
                                            backgroundColor: Colors.grey,
                                          )
                                        : Button(
                                            label: 'Done',
                                            onValidate: () => _formKey
                                                .currentState
                                                .validate(),
                                            onSubmit: () {
                                              uploader.upload(this._image,
                                                  "posts/${user.uid}/${this._imageFilename}",
                                                  (final String pathFile) {
                                                postsProvider
                                                    .addPost(
                                                        PostModel(
                                                            pathFile,
                                                            this
                                                                ._captionController
                                                                .text,
                                                            null),
                                                        user.uid)
                                                    .then((DocumentReference
                                                        docRef) {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                    builder: (context) =>
                                                        BaseScreen(),
                                                  ));
                                                });
                                              });
                                              return null;
                                            },
                                          ),
                              ),
                            ],
                          ),
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

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

import 'package:tsa_gram/models/Auth/Auth.dart';
import 'package:tsa_gram/screen/Connected/BaseScreen.dart';
import 'package:tsa_gram/widgets/Button.dart';
import 'package:tsa_gram/widgets/TextInput.dart';

class PostImageScreen extends StatefulWidget {
  @override
  _PostImageScreenState createState() => _PostImageScreenState();
}

class _PostImageScreenState extends State<PostImageScreen> {
  File _image;
  String _imageFilename;
  bool _isUploading = false;
  double _progressUpload = 0.0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController _captionController = TextEditingController();
  final Auth _auth = Auth();

  void pickImage(ImageSource source) {
    _imagePicker.getImage(source: source).then((PickedFile pickedFile) {
      if (pickedFile != null) {
        final String filename =
            DateTime.now().microsecondsSinceEpoch.toString() +
                '_' +
                basename(pickedFile.path);

        ImageCropper.cropImage(
                sourcePath: pickedFile.path,
                aspectRatioPresets: Platform.isAndroid
                    ? [
                        CropAspectRatioPreset.square,
                        CropAspectRatioPreset.ratio3x2,
                        CropAspectRatioPreset.original,
                        CropAspectRatioPreset.ratio4x3,
                        CropAspectRatioPreset.ratio16x9
                      ]
                    : [
                        CropAspectRatioPreset.original,
                        CropAspectRatioPreset.square,
                        CropAspectRatioPreset.ratio3x2,
                        CropAspectRatioPreset.ratio4x3,
                        CropAspectRatioPreset.ratio5x3,
                        CropAspectRatioPreset.ratio5x4,
                        CropAspectRatioPreset.ratio7x5,
                        CropAspectRatioPreset.ratio16x9
                      ],
                androidUiSettings: AndroidUiSettings(
                  toolbarTitle: 'Cropper',
                  initAspectRatio: CropAspectRatioPreset.original,
                  lockAspectRatio: false,
                ),
                iosUiSettings: IOSUiSettings(
                  title: 'Cropper',
                ),
                compressQuality: 40)
            .then((File croppedFile) {
          if (croppedFile != null) {
            setState(() {
              _image = File(croppedFile.path);
              _imageFilename = filename;
            });
          }
        });
      }
    });
  }

  void takeFromCamera() {
    this.pickImage(ImageSource.camera);
  }

  void selectFromPhoto() {
    this.pickImage(ImageSource.gallery);
  }

  void upload(BuildContext context, final User user) {
    if (this._isUploading) {
      return;
    }

    setState(() {
      this._isUploading = true;
    });

    UploadTask uploadTask = _auth.store
        .ref()
        .child('posts')
        .child(user.uid)
        .child(this._imageFilename)
        .putFile(this._image);

    uploadTask.snapshotEvents.listen((TaskSnapshot event) {
      if (event.state == TaskState.success) {
        event.ref
            .getDownloadURL()
            .then(
              (final String pathPhoto) => _auth.db.collection('posts').add({
                'photoUrl': pathPhoto,
                'caption': this._captionController.text,
                'uploadBy': _auth.db.doc("users/" + user.uid),
                'createAt': DateTime.now(),
              }),
            )
            .then((DocumentReference docRef) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => BaseScreen(),
          ));
        });
      } else {
        final double progress =
            ((event.bytesTransferred * 100) / event.totalBytes) / 100;

        setState(() {
          this._progressUpload = progress;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Select Image'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Take from camera',
            icon: Icon(Icons.add_a_photo),
            onPressed: () {
              this.takeFromCamera();
            },
          ),
          IconButton(
            tooltip: 'Select from photo',
            icon: Icon(Icons.add_photo_alternate),
            onPressed: () {
              this.selectFromPhoto();
            },
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
                              this._isUploading
                                  ? LinearProgressIndicator(
                                      value: this._progressUpload,
                                      backgroundColor: Colors.grey,
                                    )
                                  : Button(
                                      label: 'Done',
                                      onValidate: () =>
                                          _formKey.currentState.validate(),
                                      onSubmit: () {
                                        this.upload(context, user);
                                        return null;
                                      },
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

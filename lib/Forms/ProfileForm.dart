import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tsa_gram/models/Auth/Auth.dart';
import 'package:tsa_gram/models/Uploader.dart';

import 'package:tsa_gram/widgets/Button.dart';
import 'package:tsa_gram/widgets/PickImage.dart';
import 'package:tsa_gram/widgets/TextInput.dart';

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _displayNameController = TextEditingController();
  final Auth _auth = Auth();

  File _image;
  String _imageFilename;

  @override
  void initState() {
    User user = Provider.of<User>(context, listen: false);

    _displayNameController.text = user.displayName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<User, Uploader>(
      builder: (final BuildContext context, final User user,
              final Uploader uploader, final Widget child) =>
          Form(
        key: _formKey,
        child: Column(
          children: [
            PickImage(
              onPicked: (File image, String filename) {
                setState(() {
                  _image = image;
                  _imageFilename = filename;
                });
              },
              builder: (BuildContext context,
                      void Function(ImageSource) pickImage) =>
                  this._image != null
                      ? Container(
                          child: InkWell(
                            onTap: () => pickImage(ImageSource.gallery),
                            child: Center(
                              child: Image.file(
                                this._image,
                                height: 200,
                              ),
                            ),
                          ),
                        )
                      : IconButton(
                          tooltip: 'Select from photo',
                          icon: Icon(Icons.add_photo_alternate),
                          onPressed: () => pickImage(ImageSource.gallery),
                        ),
            ),
            TextInput(
              controller: _displayNameController,
              labelText: 'Display Name',
              obscured: false,
              maxLength: 32,
            ),
            SizedBox(height: 20),
            uploader.isUploading
                ? LinearProgressIndicator(
                    value: uploader.progress,
                    backgroundColor: Colors.grey,
                  )
                : Button(
                    label: 'Update Profile',
                    onValidate: () => _formKey.currentState.validate(),
                    onSubmit: () {
                      if (this._image != null) {
                        uploader.upload(this._image,
                            "users/${user.uid}/${this._imageFilename}",
                            (final String pathFile) {
                          _auth.updateUser(
                              user, _displayNameController.text, pathFile);
                          setState(() {
                            this._image = null;
                          });
                        });
                      } else if (_displayNameController.text !=
                          user.displayName) {
                        _auth.updateUser(
                            user, _displayNameController.text, user.photoURL);
                      }
                      return null;
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

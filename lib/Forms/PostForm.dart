import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:tsa_gram/models/Posts/PostModel.dart';
import 'package:tsa_gram/models/Posts/PostsProvider.dart';
import 'package:tsa_gram/models/Uploader.dart';
import 'package:tsa_gram/screen/Connected/BaseScreen.dart';
import 'package:tsa_gram/widgets/Button.dart';
import 'package:tsa_gram/widgets/TextInput.dart';

class PostForm extends StatefulWidget {
  final File image;
  final String imageFilename;

  const PostForm({
    Key key,
    @required this.image,
    @required this.imageFilename,
  }) : super(key: key);

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _captionController = TextEditingController();

  bool _addLocation = false;

  @override
  Widget build(BuildContext context) {
    return Consumer3<User, PostsProvider, Uploader>(
      builder: (BuildContext context,
              final User user,
              final PostsProvider postsProvider,
              final Uploader uploader,
              final Widget child) =>
          Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextInput(
              controller: _captionController,
              labelText: 'Caption',
              obscured: false,
              maxLength: 140,
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Text('Ajouter la position GPS'),
                Switch(
                  value: _addLocation,
                  onChanged: (final bool value) async {
                    LocationPermission permission =
                        await Geolocator.checkPermission();

                    if (permission == LocationPermission.denied) {
                      permission = await Geolocator.requestPermission();
                    }

                    if (permission == LocationPermission.whileInUse ||
                        permission == LocationPermission.always) {
                      setState(() {
                        _addLocation = value;
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            uploader.isUploading
                ? LinearProgressIndicator(
                    value: uploader.progress,
                    backgroundColor: Colors.grey,
                  )
                : Button(
                    label: 'Done',
                    onValidate: () => _formKey.currentState.validate(),
                    onSubmit: () {
                      uploader.upload(this.widget.image,
                          "posts/${user.uid}/${this.widget.imageFilename}",
                          (final String pathFile) async {
                        String location;

                        if (this._addLocation) {
                          Position position =
                              await Geolocator.getCurrentPosition(
                                  desiredAccuracy: LocationAccuracy.high);
                          try {
                            location = await http
                                .get(
                                    'https://api-adresse.data.gouv.fr/reverse?lat=${position.latitude}&lon=${position.longitude}')
                                .then((http.Response response) {
                              if (response.statusCode >= 200 &&
                                  response.statusCode < 300) {
                                return json.decode(response.body)['features'][0]
                                    ['properties']['city'] as String;
                              }
                              throw Exception(
                                  'Request error code ${response.statusCode}: ${response.body}');
                            });
                          } catch (ex) {}
                        }

                        await postsProvider.addPost(
                            PostModel(pathFile, this._captionController.text,
                                location),
                            user.uid);
                      });
                      return null;
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

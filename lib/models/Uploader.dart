import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:tsa_gram/models/Auth/Auth.dart';

class Uploader extends ChangeNotifier {
  final Auth _auth = Auth();

  bool _isUploading = false;
  double _progress = 0.0;

  bool get isUploading {
    return _isUploading;
  }

  double get progress {
    return _progress;
  }

  void upload(final File file, final String fullPath,
      final void Function(String pathFile) onComplete) {
    if (_isUploading) {
      return;
    }

    _isUploading = true;
    _progress = 0.0;
    notifyListeners();

    Reference storeRef = _auth.store.ref();

    fullPath.split('/').forEach((final String pathElement) {
      storeRef = storeRef.child(pathElement);
    });

    final UploadTask uploadTask = storeRef.putFile(file);

    uploadTask.snapshotEvents.listen((TaskSnapshot event) {
      if (event.state == TaskState.success) {
        event.ref.getDownloadURL().then((final String pathFile) {
          _isUploading = false;
          onComplete(pathFile);
          notifyListeners();
        });
      } else {
        _progress = ((event.bytesTransferred * 100) / event.totalBytes) / 100;
        notifyListeners();
      }
    });
  }
}

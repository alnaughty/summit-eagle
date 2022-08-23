import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:summiteagle/services/data_cacher.dart';
import 'package:summiteagle/summit_eagle.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DataCacher _cacher = DataCacher.instance;
  await _cacher.init();
  await Firebase.initializeApp(
    options: kIsWeb
        ? const FirebaseOptions(
            apiKey: "AIzaSyD1YOAqUUcHm-trwq6Nkj7tq-mlp4xHdcE",
            appId: "1:437117244657:web:d8e3ccd819b2ae7e0c0550",
            messagingSenderId: "437117244657",
            projectId: "summiteagle-140af",
          )
        : null,
  );
  runApp(const SummitEagle());
}

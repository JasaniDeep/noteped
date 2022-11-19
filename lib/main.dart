// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:noteped/first.dart';
import 'package:flutter/services.dart';
import 'package:noteped/splesh.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MaterialApp(
      home: splesh(),
    ));
  });
}





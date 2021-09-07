import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'gallery.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()` can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtains a list of the available cameras on the device: an array
  final cameras = await availableCameras();

  runApp(
    // This widget is the root of your application.
    MaterialApp(
      title: 'Camera',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
      ),
      home: Camera(cameras: cameras),

      debugShowCheckedModeBanner: false,
    ),
  );
}

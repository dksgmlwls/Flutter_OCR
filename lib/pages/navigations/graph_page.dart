import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:ocr/pages/navigations/ExampleCameraOverlay.dart';
import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter_camera_overlay/flutter_camera_overlay.dart';
// import 'package:flutter_camera_overlay/model.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:flutter_camera_overlay/flutter_camera_overlay.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr/pages/navigations/ExampleCameraOverlay.dart';

class GraphPage extends StatefulWidget {
  static const routeName = '/camera-page';

  const GraphPage({Key? key}) : super(key: key);

  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  //const GraphPage({Key? key, required this.title}) : super(key: key);
  //final String title;
  late final DateTime _selectedDate;
  @override
  Widget build(BuildContext context) {
    return Material(



    );
  }
}
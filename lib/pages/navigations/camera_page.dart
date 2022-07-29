import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocr/pages/navigations/ExampleCameraOverlay.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ocr/pages/navigations/flutter_camera_overlay.dart';
import 'package:ocr/pages/navigations/model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';


class UseCameraPage extends StatefulWidget {
  static const routeName = '/camera-page';

  const UseCameraPage({Key? key}) : super(key: key);

  @override
  _UseCameraPageState createState() => _UseCameraPageState();
}

class _UseCameraPageState extends State<UseCameraPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [



                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ExampleCameraOverlay()),
                        // MaterialPageRoute는 머테리얼 디자인으로 작성된 페이지 사이에 화면 전환을 할 때 사용된다.
                        // MaterialPageRoute는 안드로이드와 iOS 각 플랫폼에 맞는 화면 전환을 지원해준다.
                      );
                    },
                    child: Text('카메라'),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      //ㅅㅓ버로 전송하는 코드 적으면 됨

                    },
                    child: Text('전송'),
                  ),


                ],
              )),
        ],
      ),
    );
  }

}


class ExampleCameraOverlay extends StatefulWidget {
  const ExampleCameraOverlay({Key? key}) : super(key: key);

  @override
  _ExampleCameraOverlayState createState() => _ExampleCameraOverlayState();
}

class _ExampleCameraOverlayState extends State<ExampleCameraOverlay> {
  OverlayFormat format = OverlayFormat.cardID1;
  int tab = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tab,
            onTap: (value) {
              setState(() {
                tab = value;
              });
              switch (value) {
                case (0):
                  setState(() {
                    format = OverlayFormat.cardID1;
                  });
                  break;
                case (1):
                  setState(() {
                    format = OverlayFormat.cardID3;
                  });
                  break;
                case (2):
                  setState(() {
                    format = OverlayFormat.simID000;
                  });
                  break;
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.credit_card),
                label: 'Bankcard',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.contact_mail), label: 'US ID'),
              BottomNavigationBarItem(icon: Icon(Icons.sim_card), label: 'Sim'),
            ],
          ),
          backgroundColor: Colors.white,
          body: FutureBuilder<List<CameraDescription>?>(
            future: availableCameras(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == null) {
                  return const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'No camera found',
                        style: TextStyle(color: Colors.black),
                      ));
                }
                return CameraOverlay(
                    snapshot.data!.first,
                    CardOverlay.byFormat(format),
                        (XFile file) => showDialog(
                      context: context,
                      barrierColor: Colors.black,
                      builder: (context) {
                        CardOverlay overlay = CardOverlay.byFormat(format);
                        return AlertDialog(
                            actionsAlignment: MainAxisAlignment.center,
                            backgroundColor: Colors.black,
                            title: const Text('Capture',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center),
                            actions: [
                              OutlinedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Icon(Icons.close))
                            ],
                            content: SizedBox(
                                width: double.infinity,
                                child: AspectRatio(
                                  aspectRatio: overlay.ratio!,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fitWidth,
                                          alignment: FractionalOffset.center,
                                          image: FileImage(
                                            File(file.path),
                                          ),
                                        )),
                                  ),
                                )));
                      },
                    ),
                    info:
                    'Position your ID card within the rectangle and ensure the image is perfectly readable.',
                    label: 'Scanning ID Card');
              } else {
                return const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Fetching cameras',
                      style: TextStyle(color: Colors.black),
                    ));
              }
            },
          ),
        ));
  }
}
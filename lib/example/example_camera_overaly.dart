import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; //쿠퍼티노 위젯
import 'package:camera/camera.dart';
import 'package:flutter_camera_overlay/flutter_camera_overlay.dart';
import 'package:flutter_camera_overlay/model.dart';
import '../pages/home_page.dart';
import '../pages/api/upload_image.dart';
import 'package:image_picker/image_picker.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ExampleCameraOverlay(),
  );
}

class ExampleCameraOverlay extends StatefulWidget {

  static const routeName = '/graph-page';

  const ExampleCameraOverlay({Key? key}) : super(key: key);

  @override
  _ExampleCameraOverlayState createState() => _ExampleCameraOverlayState();
}

class _ExampleCameraOverlayState extends State<ExampleCameraOverlay> {
  OverlayFormat format = OverlayFormat.cardID1;
  int tab = 0;

  @override
  Widget build(BuildContext context) {
    String urlpath;
    return MaterialApp(
        home: Scaffold(
          // bottomNavigationBar: BottomNavigationBar(
          //   currentIndex: tab,
          //   onTap: (value) {
          //     setState(() {
          //       tab = value;
          //     });
          //     switch (value) {
          //       case (0):
          //         setState(() {
          //           format = OverlayFormat.cardID1;
          //         });
          //         break;
          //       // case (1):
          //       //   setState(() {
          //       //     format = OverlayFormat.cardID3;
          //       //   });
          //       //   break;
          //       // case (2):
          //       //   setState(() {
          //       //     format = OverlayFormat.simID000;
          //       //   });
          //       //   break;
          //     }
          //   },
          //   items: const [
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.credit_card),
          //       label: 'Bankcard',
          //     ),
          //     // BottomNavigationBarItem(
          //     //     icon: Icon(Icons.contact_mail), label: 'US ID'),
          //     // BottomNavigationBarItem(icon: Icon(Icons.sim_card), label: 'Sim'),
          //   ],
          // ),
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
                            title: const Text('찰칵',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center),
                            actions: [
                              OutlinedButton(
                                // onPressed: () => Navigator.of(context).pop(),
                                  onPressed: () async {
                                    final filename = await submit_uploadimg(file);
                                    print(filename);

                                    Navigator.of(context).popUntil((route) => route.isFirst);
                                    await Navigator.push(context,MaterialPageRoute(builder: (context) =>
                                        HomePage(filename)),
                                    );
                                  },
                                  child: const Icon(Icons.send))
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


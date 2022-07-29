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
import 'package:image_picker/image_picker.dart';
import 'package:ocr/pages/navigations/ExampleCameraOverlay.dart';

class UseCameraPage extends StatefulWidget {
  static const routeName = '/camera-page';

  const UseCameraPage({Key? key}) : super(key: key);

  @override
  _UseCameraPageState createState() => _UseCameraPageState();
}

class _UseCameraPageState extends State<UseCameraPage> {
  File? _image;
  final picker = ImagePicker();

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path); // 가져온 이미지를 _image에 저장
    });
  }

  // 이미지를 보여주는 위젯
  Widget showImage() {
    return Container(
        color: const Color(0xffd0cece),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Center(
            child: _image == null
                ? Text('No image selected.')
                : Image.file(File(_image!.path))));
  }

  @override
  Widget build(BuildContext context) {
    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
        backgroundColor: const Color(0xfff4f3f9),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 25.0),
            showImage(),
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // 카메라 촬영 버튼
                FloatingActionButton(
                  heroTag: "camera",
                  child: Icon(Icons.add_a_photo),
                  tooltip: 'pick Iamge',
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                ),

                // 갤러리에서 이미지를 가져오는 버튼
                FloatingActionButton(
                  heroTag: "send_result",
                  child: Icon(Icons.check_outlined),
                  tooltip: 'pick Iamge',
                  onPressed: () {
                    //getImage(ImageSource.gallery);
                  },
                ),
              ],
            )
          ],
        ));
  }
}
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         //title: Text(widget.title),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//               padding: const EdgeInsets.all(20),
//               child: Row(
//                 children: [
//
//
//
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => ExampleCameraOverlay()),
//                         // MaterialPageRoute는 머테리얼 디자인으로 작성된 페이지 사이에 화면 전환을 할 때 사용된다.
//                         // MaterialPageRoute는 안드로이드와 iOS 각 플랫폼에 맞는 화면 전환을 지원해준다.
//                       );
//                     },
//                     child: Text('카메라'),
//                   ),
//
//                   ElevatedButton(
//                     onPressed: () {
//                     //ㅅㅓ버로 전송하는 코드 적으면 됨
//
//                     },
//                     child: Text('전송'),
//                   ),
//
//
//                 ],
//               )),
//         ],
//       ),
//     );
//   }
//
// }
//
// class ExampleCameraOverlay extends StatefulWidget {
//   const ExampleCameraOverlay({Key? key}) : super(key: key);
//
//   @override
//   _ExampleCameraOverlayState createState() => _ExampleCameraOverlayState();
// }
//
// class _ExampleCameraOverlayState extends State<ExampleCameraOverlay> {
//   OverlayFormat format = OverlayFormat.cardID1;
//   int tab = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//           bottomNavigationBar: BottomNavigationBar(
//             currentIndex: tab,
//             onTap: (value) {
//               setState(() {
//                 tab = value;
//               });
//               switch (value) {
//                 case (0):
//                   setState(() {
//                     format = OverlayFormat.cardID1;
//                   });
//                   break;
//                 case (1):
//                   setState(() {
//                     format = OverlayFormat.cardID3;
//                   });
//                   break;
//                 // case (2):
//                 //   setState(() {
//                 //     format = OverlayFormat.simID000;
//                 //   });
//                 //   break;
//               }
//             },
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.credit_card),
//                 label: 'Bankcard',
//               ),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.contact_mail), label: 'US ID'),
//              // BottomNavigationBarItem(icon: Icon(Icons.sim_card), label: 'Sim'),
//             ],
//           ),
//           backgroundColor: Colors.white,
//           body: FutureBuilder<List<CameraDescription>?>(
//             future: availableCameras(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 if (snapshot.data == null) {
//                   return const Align(
//                       alignment: Alignment.center,
//                       child: Text(
//                         'No camera found',
//                         style: TextStyle(color: Colors.black),
//                       ));
//                 }
//                 return CameraOverlay(
//                     snapshot.data!.first,
//                     CardOverlay.byFormat(format),
//                         (XFile file) => showDialog(
//                       context: context,
//                       barrierColor: Colors.black,
//                       builder: (context) {
//                         CardOverlay overlay = CardOverlay.byFormat(format);
//                         return AlertDialog(
//                             actionsAlignment: MainAxisAlignment.center,
//                             backgroundColor: Colors.black,
//                             title: const Text('Capture',
//                                 style: TextStyle(color: Colors.white),
//                                 textAlign: TextAlign.center),
//                             actions: [
//                               OutlinedButton(
//                                   onPressed: () => Navigator.of(context).pop(),
//                                   child: const Icon(Icons.close))
//                             ],
//                             content: SizedBox(
//                                 width: double.infinity,
//                                 child: AspectRatio(
//                                   aspectRatio: overlay.ratio!,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         image: DecorationImage(
//                                           fit: BoxFit.fitWidth,
//                                           alignment: FractionalOffset.center,
//                                           image: FileImage(
//                                             File(file.path),
//                                           ),
//                                         )),
//                                   ),
//                                 )));
//                       },
//                     ),
//                     info:
//                     'Position your ID card within the rectangle and ensure the image is perfectly readable.',
//                     label: 'Scanning ID Card');
//               } else {
//                 return const Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       'Fetching cameras',
//                       style: TextStyle(color: Colors.black),
//                     ));
//               }
//             },
//           ),
//         ));
//   }
// }
//
// void showToast(String message){
//   Fluttertoast.showToast(msg: message,
//   backgroundColor: Colors.blue,
//   toastLength: Toast.LENGTH_SHORT,
//   gravity: ToastGravity.BOTTOM);
// }
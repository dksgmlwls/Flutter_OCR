// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter_camera_overlay/flutter_camera_overlay.dart';
// import 'package:flutter_camera_overlay/model.dart';
//
// main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(
//     const ExampleCameraOverlay(),
//   );
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
//                 case (2):
//                   setState(() {
//                     format = OverlayFormat.simID000;
//                   });
//                   break;
//               }
//             },
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.credit_card),
//                 label: 'Bankcard',
//               ),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.contact_mail), label: 'US ID'),
//               BottomNavigationBarItem(icon: Icon(Icons.sim_card), label: 'Sim'),
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
//                         (XFile file) => print(file.path),
//                     info: 'Please take a picture into the frame',
//                     label: '가이드라인에 맞춰 사진을 찍어주세요');
//
//               } else {
//                 return const Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       '아직 촬영된 이미지가 없습니다',
//                       style: TextStyle(color: Colors.black),
//                     ));
//               }
//             },
//           ),
//         ));
//   }
// }
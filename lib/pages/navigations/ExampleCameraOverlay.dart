// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter_camera_overlay/flutter_camera_overlay.dart';
// import 'package:flutter_camera_overlay/model.dart';
// import 'package:image_picker/image_picker.dart';
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
//   // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
//   File? _image;
//   final picker = ImagePicker();
//   Future getImage(ImageSource imageSource) async {
//     print("getImageㅎㅎ");
//     final image = await picker.pickImage(source: imageSource);
//
//     setState(() {
//       _image = File(image!.path); // 가져온 이미지를 _image에 저장
//     });
//   }
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
//                                 // onPressed: (){
//                                 //   getImage(ImageSource.camera);
//                                 // },
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
//
//                                           ),
//                                         )),
//                                   ),
//                                 )));
//                       },
//                     ),
//                     info:
//                     '틀에 맞춰 촬영을 해주세요.',
//                     label: 'OCR');
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
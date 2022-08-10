import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; //쿠퍼티노 위젯
import 'package:camera/camera.dart';
import 'package:flutter_camera_overlay/flutter_camera_overlay.dart';
import 'package:flutter_camera_overlay/model.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const GalleryPreview(),
  );
}

class GalleryPreview extends StatefulWidget {
  //
  // static const routeName = '/graph-page';

  const GalleryPreview({Key? key}) : super(key: key);

  @override
  _GalleryPreviewState createState() => _GalleryPreviewState();
}

class _GalleryPreviewState extends State<GalleryPreview> {
  OverlayFormat format = OverlayFormat.cardID1;
  int tab = 0;

  @override
  Widget build(BuildContext context) {
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

                // Navigator.pop(context, file.path);

                //   final filename = await submit_uploadimg(file);
                //   print(filename);
                //   Navigator.of(context).popUntil((route) => route.isFirst);
                //   await Navigator.push(context,MaterialPageRoute(builder: (context) =>
                //       HomePage(filename)),
                //   );
              },
              child: const Icon(Icons.send))
        ]
      // content: SizedBox(
      //     width: double.infinity,
      //     child: AspectRatio(
      //       aspectRatio: overlay.ratio!,
      //       child: Container(
      //         decoration: BoxDecoration(
      //             image: DecorationImage(
      //               fit: BoxFit.fitWidth,
      //               alignment: FractionalOffset.center,
      //               image: FileImage(
      //                 File(file.path),
      //               ),
      //             )),
      //
      //       ),
    );

  }
}


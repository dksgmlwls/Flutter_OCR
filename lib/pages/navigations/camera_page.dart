import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class UseCamera extends StatefulWidget {
  const UseCamera({Key? key}) : super(key: key);
  static const routeName = '/camera-page';
  @override
  _UseCameraState createState() => _UseCameraState();
}

class _UseCameraState extends State<UseCamera> {
  File? _image;
  final picker = ImagePicker();

  //비동기 처리를 통해 카메라에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    setState(() {
      _image = File(image!.path); //가져온 이미지를 _image에 저장
    });
    }

    //이미지를 보여주는 위젯
    Widget showImage(){
      return Container(
        color: const Color(0xffd0cece),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Center(
          child: _image == null
              ? Text('No image  selected.')
              : Image.file(File(_image!.path))
        ),
      );
    }

    @override
    Widget build(BuildContext context){
    //화면 세로 고정
      SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
      );

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
                //카메라 촬영 버튼
                FloatingActionButton(
                  child: Icon(Icons.add_a_photo),
                  tooltip: 'pick Image',
                  onPressed: (){
                    getImage(ImageSource.camera);
                  },
                )
              ],
            )
          ],
        ),
      );
    }
}
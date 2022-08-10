import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter_camera_overlay/model.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../example/example_camera_overaly.dart';


class UseCameraPage extends StatefulWidget {
  static const routeName = '/camera-page';
  final String path;
  // const UseCameraPage({Key? key}) : super(key: key);

  const UseCameraPage(this.path);

  @override
  _UseCameraPageState createState() => _UseCameraPageState();
}

class _UseCameraPageState extends State<UseCameraPage> {

  File? _image;
  final picker = ImagePicker();
  //late final String pig_num = "ㄴㅁㅇㅁㄹ";
  //late final String birth_year, birth_month, birth_day, buy_year, buy_month, buy_day, rutting_year, rutting_month, rutting_day, et_ruting_date, delivery_date,
  //baby_meal_day,male_pig_num, baby_num_born, baby_num_survive, rutting_second, survive_baby_num, teenager_weight, estimated_delivery_date, baby_weight, memo;

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    print("getImage");
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
                ? (widget.path == "no" ? Text('No image selected.') : Image.file(File(widget.path)))
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

                Table(
                  children: [
                    TableRow(
                        children: [
                          Text("asdfas",textScaleFactor: 1.5),
                          Text("Year",textScaleFactor: 1.5),
                          Text("Country",textScaleFactor: 1.5),
                          Text("Club Name",textScaleFactor: 1.5),
                        ]
                    ),
                    TableRow(
                        children: [
                          Text("Ronaldo",textScaleFactor: 1.5),
                          Text("1997",textScaleFactor: 1.5),
                          Text("Brazil",textScaleFactor: 1.5),
                          Text("Internazional",textScaleFactor: 1.5),
                        ]
                    ),
                    TableRow(
                        children: [
                          Text("Zinedine Zidane",textScaleFactor: 1.5),
                          Text("1998",textScaleFactor: 1.5),
                          Text("France",textScaleFactor: 1.5),
                          Text("Juventus",textScaleFactor: 1.5),
                        ]
                    ),
                  ],
                ),

                // Table(
                //   children: [
                //     TableRow(
                //         children: [
                //           Text("OCR 모돈 현황판",textScaleFactor: 1.5),
                //           Text("모돈번호",textScaleFactor: 1.5),
                //           //Text(pig_num,textScaleFactor: 1.5),
                //         ]
                //     ),
                //     TableRow(
                //         children: [
                //           //Text("출생일",textScaleFactor: 1.5),
                //           //Text(birth_year,textScaleFactor: 1.5),
                //           Text("년",textScaleFactor: 1.5),
                //           //Text(birth_month,textScaleFactor: 1.5),
                //           Text("월",textScaleFactor: 1.5),
                //           //Text(birth_day,textScaleFactor: 1.5),
                //           Text("일",textScaleFactor: 1.5),
                //         ]
                //     ),
                //     TableRow(
                //         children: [
                //           //Text("구입일",textScaleFactor: 1.5),
                //           //Text(buy_year,textScaleFactor: 1.5),
                //           Text("년",textScaleFactor: 1.5),
                //           //Text(buy_month,textScaleFactor: 1.5),
                //           Text("월",textScaleFactor: 1.5),
                //          // Text(buy_day,textScaleFactor: 1.5),
                //           Text("일",textScaleFactor: 1.5),
                //         ]
                //     ),
                //     TableRow(
                //         children: [
                //           //Text("초발정일",textScaleFactor: 1.5),
                //           //Text(rutting_year,textScaleFactor: 1.5),
                //           Text("년",textScaleFactor: 1.5),
                //           //Text(rutting_month,textScaleFactor: 1.5),
                //           Text("월",textScaleFactor: 1.5),
                //           //Text(rutting_day,textScaleFactor: 1.5),
                //           Text("일",textScaleFactor: 1.5),
                //         ]
                //     ),
                //     TableRow(
                //         children: [
                //           Text("교배일",textScaleFactor: 1.5),
                //           //Text(et_ruting_date,textScaleFactor: 1.5),
                //           Text("분만일",textScaleFactor: 1.5),
                //           //Text(delivery_date,textScaleFactor: 1.5),
                //           Text("이유일",textScaleFactor: 1.5),
                //           //Text(baby_meal_day,textScaleFactor: 1.5),
                //         ]
                //     ),
                //     TableRow(
                //         children: [
                //           Text("웅돈번호",textScaleFactor: 1.5),
                //           //Text(male_pig_num,textScaleFactor: 1.5),
                //           Text("총산자수",textScaleFactor: 1.5),
                //           //Text(baby_num_born,textScaleFactor: 1.5),
                //           Text("이유두수",textScaleFactor: 1.5),
                //           //Text(baby_num_survive,textScaleFactor: 1.5),
                //         ]
                //     ),
                //     TableRow(
                //         children: [
                //           Text("재발확인일",textScaleFactor: 1.5),
                //           //Text(rutting_second,textScaleFactor: 1.5),
                //           Text("포유개시두수",textScaleFactor: 1.5),
                //           //Text(survive_baby_num,textScaleFactor: 1.5),
                //           Text("이유체중",textScaleFactor: 1.5),
                //           //Text(teenager_weight,textScaleFactor: 1.5),
                //         ]
                //     ),
                //     TableRow(
                //         children: [
                //           Text("분만예정일",textScaleFactor: 1.5),
                //           //Text(estimated_delivery_date,textScaleFactor: 1.5),
                //           Text("생시체중",textScaleFactor: 1.5),
                //           //Text(baby_weight,textScaleFactor: 1.5),
                //           Text("특이사항",textScaleFactor: 1.5),
                //           //Text(memo,textScaleFactor: 1.5),
                //         ]
                //     ),
                //   ],
                // ),
                // 카메라 촬영 버튼
                FloatingActionButton(
                  heroTag: 'camera',
                  child: Icon(Icons.add_a_photo),
                  tooltip: 'pick Iamge',
                  onPressed: ()  {
                    // getImage(ImageSource.camera);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ExampleCameraOverlay()));

                  },
                ),

                // 갤러리에서 이미지를 가져오는 버튼
                FloatingActionButton(
                  heroTag: 'send_button',
                  child: Icon(Icons.wallpaper),
                  tooltip: 'pick Iamge',
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                ),
              ],
            )
          ],
        ));
  }
}
import 'dart:ffi';


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

import 'package:dio/dio.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../example/example_camera_overaly.dart';
import '../api/upload_image.dart';


class UseCameraPage extends StatefulWidget {
  static const routeName = '/camera-page';
  final String path;
  // const UseCameraPage({Key? key}) : super(key: key);

  const UseCameraPage(this.path);

  @override
  _UseCameraPageState createState() => _UseCameraPageState();
}

class F {
  final double x;
  final double px;
  final double multiply;
  F({
    required this.x,
    required this.px,
  }) : multiply = x * px;
}

class _UseCameraPageState extends State<UseCameraPage> {
  File? _image;
  final picker = ImagePicker();
  late String modon ='';
  late String woongdon ='';
  late String lastresult ='';

  String galleryurl = '';
  late List<dynamic> array;

  //late final String pig_num = "ㄴㅁㅇㅁㄹ";
  //late final String birth_year, birth_month, birth_day, buy_year, buy_month, buy_day, rutting_year, rutting_month, rutting_day, et_ruting_date, delivery_date,
  //baby_meal_day,male_pig_num, baby_num_born, baby_num_survive, rutting_second, survive_baby_num, teenager_weight, estimated_delivery_date, baby_weight, memo;
  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    final temp=await submit_uploadimg(image);
    print("aaaa");
    print(temp);

    setState((){
      _image = File(image!.path); // 가져온 이미지를 _image에 저장
    });
    return temp;
  }


  // 이미지를 보여주는 위젯
  Widget showImage() {

    final String cameraurl = 'http://211.107.210.141:3000/images/' + widget.path;
    print(cameraurl);
    // if(widget.path != "no"){
    //   array = receiveresult();
    //   print(array);
    //   modon = array[0];
    // };


    return Container(
        color: const Color(0xffd0cece),
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .width,
        child: Center(
            child: _image == null //삼항연!산!자!
                ? (widget.path == "no" ? Text('No image selected.') : Image
                .network(cameraurl))
                : galleryurl == '' ? Text('No url selected.') : Image.network(
                'http://211.107.210.141:3000/images/' + galleryurl)));
  }

  List<F> data = [];

  final modonnum_Controller = TextEditingController();
  final pxController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // 화면 세로 고정
    // String test='a';
    // print(test.runtimeType);
    // print('a'.runtimeType);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    if(widget.path != "no"){
      array = receiveresult();
      print(array);
      modon = array[0];
      woongdon = array[1];
    };

    return SingleChildScrollView(
      // backgroundColor: const Color(0xfff4f3f9),
      scrollDirection: Axis.vertical,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(80.0),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle, // 표 가운데 정렬
                  border: TableBorder(
                    // color: Colors.white,
                    // style: BorderStyle.solid,
                    // width: 2
                      verticalInside: BorderSide(width: 1.0, color: Colors.black, style: BorderStyle.solid),
                      top: BorderSide(color: Colors.black, width: 1),
                      left: BorderSide(color: Colors.black, width: 1),
                      right: BorderSide(color: Colors.black, width: 1)
                  ),
                  children: [
                    TableRow(children: [
                      Column(children: [Text('모돈번호',
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [
                        TextField(controller: TextEditingController(),
                          decoration:  InputDecoration(hintText: modon ),)
                      ]),
                      Column(children: [Text('웅돈번호',
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [
                        TextField(controller: TextEditingController(),
                          decoration:  InputDecoration(hintText: woongdon),)
                      ]),
                    ]),
                  ],
                ),
              ),

            ],

          ),
          Row(
            // margin: EdgeInsets.all(10),
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(45.8),
                  border: TableBorder.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.3),
                  children: [
                    TableRow(children: [
                      Column(children: [Text('출생일')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('년')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('월')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('일')
                      ]),
                    ],
                    ),
                    TableRow(children: [
                      Column(children: [Text('구입일')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('년')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('월')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('일')
                      ]),
                    ],
                    ),
                    TableRow(children: [
                      Column(children: [Text('초발정일')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('년')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('월')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('일')
                      ]),
                    ],
                    ),
                    TableRow(children: [
                      Column(children: [Text('1차교배일')
                      ]),
                      Column(children: [Text('******')
                      ]),
                      Column(children: [Text('년')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('월')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('일')
                      ]),
                    ],
                    ),
                    TableRow(children: [
                      Column(children: [Text('2차교배일')
                      ]),
                      Column(children: [Text('******')
                      ]),
                      Column(children: [Text('년')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('월')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('일')
                      ]),
                    ],
                    ),
                    TableRow(children: [
                      Column(children: [Text('재발확인일')
                      ]),
                      Column(children: [Text('******')
                      ]),
                      Column(children: [Text('년')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('월')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('일')
                      ]),
                    ],
                    ),
                    TableRow(children: [
                      Column(children: [Text('분만예정일')
                      ]),
                      Column(children: [Text('******')
                      ]),
                      Column(children: [Text('년')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('월')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('일')
                      ]),
                    ],
                    ),
                    TableRow(children: [
                      Column(children: [Text('분만일')
                      ]),
                      Column(children: [Text('******')
                      ]),
                      Column(children: [Text('년')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('월')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('일')
                      ]),
                    ],
                    ),
                  ],

                ),
              ),

            ],

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(35.5),
                  border: TableBorder.all(
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 1.3),
                  children: [
                    TableRow(children: [
                      Column(children: [Text('총산자수')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('마리')
                      ]),
                      Column(children: [Text('포유개시두수')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('마리')
                      ]),
                      Column(children: [Text('생시체중')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('kg')
                      ]),
                    ])
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(45.7),
                  border: TableBorder.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.3),
                  children: [
                    TableRow(children: [
                      Column(children: [Text('이유일')
                      ]),
                      Column(children: [Text('******')
                      ]),
                      Column(children: [Text('년')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('월')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('일')
                      ]),
                    ])
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(53.3),
                  border: TableBorder.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.3),
                  children: [
                    TableRow(children: [
                      Column(children: [Text('이유두수')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('마리')
                      ]),
                      Column(children: [Text('이유체중')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('kg')
                      ]),
                    ])
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(32),
                  border: TableBorder.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.3),
                  children: [
                    TableRow(children: [
                      Column(children: [Text('백신1')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('월')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('일')
                      ]),
                      Column(children: [Text('백신2')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('월')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('일')
                      ]),
                    ])
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(160),
                  border: TableBorder.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.3),
                  children: [
                    TableRow(children: [
                      Column(children: [Text('특이사항')
                      ]),
                      Column(children: [TextField(controller: TextEditingController(),
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                    ])
                  ],
                ),
              )
            ],
          ),

          SizedBox(height: 10.0), // 위에 여백
          showImage(),
          SizedBox(
            height: 15.0,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: 'camera',
                  child: Icon(Icons.add_a_photo),
                  tooltip: 'pick Image',
                  onPressed: ()  {
                    // getImage(ImageSource.camera);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ExampleCameraOverlay()));
                    // print("open camera");
                  },
                ),
                FloatingActionButton(
                  heroTag: 'gallery_button',
                  child: Icon(Icons.wallpaper),
                  tooltip: 'pick Iamge',
                  onPressed: () async{
                    galleryurl = await getImage(ImageSource.gallery);
                    print("onpressed");
                    print(galleryurl);
                    // getImage(ImageSource.gallery);
                  },
                ),
                FloatingActionButton(
                  heroTag: 'send_button',
                  child: Icon(Icons.arrow_circle_right_sharp),
                  tooltip: 'pick Iamge',
                  onPressed: () async{
                    lastresult = modon + "," + woongdon ;
                    sendData(lastresult);
                    // getImage(ImageSource.gallery);
                  },
                ),
              ])

        ],
      ),
    );

  }
}

sendData(String? lastresult) async {
  Dio dio = new Dio();
  try {

    Response response = await dio.post(
        'http://211.107.210.141:3000/ocrs/uploadocr',
        data: {
          'lastresult' : lastresult
        }
    );
    final jsonBody = response.data;
    return response.statusCode;
  } catch (e) {
    Exception(e);
  } finally {
    dio.close();
  }
  return 0;
}

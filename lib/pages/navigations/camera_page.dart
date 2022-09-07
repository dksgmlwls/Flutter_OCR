import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';


import 'package:dio/dio.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

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

  late String sowID ='';

  late String birth_year ='';
  late String birth_month ='';
  late String birth_day ='';

  late String adoption_year ='';
  late String adoption_month ='';
  late String adoption_day ='';

  late String hormone_year ='';
  late String hormone_month ='';
  late String hormone_day ='';

  late String mate_month ='';
  late String mate_day ='';

  late String boar1ID ='';
  late String boar2ID ='';

  late String check_month ='';
  late String check_day ='';

  late String expect_month ='';
  late String expect_day ='';

  late String vaccine1 ='';
  late String vaccine2 ='';
  late String vaccine3 ='';
  late String vaccine4 ='';

  late String memo = '';

  late String lastresult ='';
  late String title = '';
  //late String

  String galleryurl = '';

  //final List<dynamic> array = [];
  List<dynamic> array = [];

  //late final String pig_num = "ㄴㅁㅇㅁㄹ";
  //late final String birth_year, birth_month, birth_day, buy_year, buy_month, buy_day, rutting_year, rutting_month, rutting_day, et_ruting_date, delivery_date,
  //baby_meal_day,male_pig_num, baby_num_born, baby_num_survive, rutting_second, survive_baby_num, teenager_weight, estimated_delivery_date, baby_weight, memo;
  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);

    final temp=await submit_uploadimg_front(image);
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

  final sowID_Controller = TextEditingController();
  final birth_year_Controller = TextEditingController();
  final birth_month_Controller = TextEditingController();
  final birth_day_Controller = TextEditingController();
  final adoption_year_Controller = TextEditingController();
  final adoption_month_Controller = TextEditingController();
  final adoption_day_Controller = TextEditingController();
  final hormone_year_Controller = TextEditingController();
  final hormone_month_Controller = TextEditingController();
  final hormone_day_Controller = TextEditingController();
  final mate_month_Controller = TextEditingController();
  final mate_day_Controller = TextEditingController();
  final boar1ID_Controller = TextEditingController();
  final boar2ID_Controller = TextEditingController();
  final check_month_Controller = TextEditingController();
  final check_day_Controller = TextEditingController();
  final expect_month_Controller = TextEditingController();
  final expect_day_Controller = TextEditingController();
  final vaccine1_Controller = TextEditingController();
  final vaccine2_Controller = TextEditingController();
  final vaccine3_Controller = TextEditingController();
  final vaccine4_Controller = TextEditingController();
  final memo_Controller = TextEditingController();



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
      sowID = array[0];
      birth_year = array[1];
      birth_month = array[2];
      birth_day = array[3];
      adoption_year = array[4];
      adoption_month = array[5];
      adoption_day = array[6];
      hormone_year = array[7];
      hormone_month = array[8];
      hormone_day = array[9];
      mate_month = array[10];
      mate_day = array[11];
      boar1ID = array[12];
      boar2ID = array[13];
      check_month = array[14];
      check_day = array[15];
      expect_month = array[16];
      expect_day = array[17];
      vaccine1 = array[18];
      vaccine2 = array[19];
      vaccine3 = array[20];
      vaccine4 = array[21];
      memo = array[22];


    }else{
      array = [];
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
                  defaultColumnWidth: FixedColumnWidth(160.0),
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
                      Column(children: [TextField(controller: sowID_Controller,
                        decoration: const InputDecoration(hintText: " "),)
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
                  defaultColumnWidth: FixedColumnWidth(45.7142857),
                  border: TableBorder.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.3),
                  children: [
                    TableRow(children: [
                      Column(children: [Text('출생일')
                      ]),
                      Column(children: [TextField(controller: birth_year_Controller,
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('년')
                      ]),
                      Column(children: [TextField(controller: birth_month_Controller,
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('월')
                      ]),
                      Column(children: [TextField(controller: birth_day_Controller,
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('일')
                      ]),
                    ],
                    ),
                    TableRow(children: [
                      Column(children: [Text('구입일')
                      ]),
                      Column(children: [TextField(controller: adoption_year_Controller,
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('년')
                      ]),
                      Column(children: [TextField(controller: adoption_month_Controller,
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('월')
                      ]),
                      Column(children: [TextField(controller: adoption_day_Controller,
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('일')
                      ]),
                    ],
                    ),
                    TableRow(children: [
                      Column(children: [Text('초발정일')
                      ]),
                      Column(children: [TextField(controller: hormone_year_Controller,
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('년')
                      ]),
                      Column(children: [TextField(controller: hormone_month_Controller,
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('월')
                      ]),
                      Column(children: [TextField(controller: hormone_day_Controller,
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
                  defaultColumnWidth: FixedColumnWidth(64),
                  border: TableBorder.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.3),
                  children: [
                    TableRow(children: [
                      Column(children: [Text('교배일')
                      ]),
                      Column(children: [TextField(controller: mate_month_Controller,
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('월')
                      ]),
                      Column(children: [TextField(controller: mate_day_Controller,
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('일')
                      ]),
                    ],
                    ),
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
                  defaultColumnWidth: FixedColumnWidth(80),
                  border: TableBorder.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.3),
                  children: [
                    TableRow(children: [
                      Column(children: [Text('1차웅돈번호')
                      ]),
                      Column(children: [TextField(controller: boar1ID_Controller,
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('2차웅돈번호')
                      ]),
                      Column(children: [TextField(controller: boar2ID_Controller,
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                    ],
                    ),
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
                  defaultColumnWidth: FixedColumnWidth(64),
                  border: TableBorder.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.3),
                  children: [
                    TableRow(children: [
                      Column(children: [Text('재발확인일')
                      ]),
                      Column(children: [TextField(controller: check_month_Controller,
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('월')
                      ]),
                      Column(children: [TextField(controller: check_day_Controller,
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('일')
                      ]),
                    ],
                    ),
                    TableRow(children: [
                      Column(children: [Text('분만예정일')
                      ]),
                      Column(children: [TextField(controller: expect_month_Controller,
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('월')
                      ]),
                      Column(children: [TextField(controller: expect_day_Controller,
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('일')
                      ]),
                    ],
                    ),
                  ],
                ),
              )
            ],
          ),//여기임
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(80),
                  border: TableBorder.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.3),
                  children: [
                    TableRow(children: [
                      Column(children: [Text('백신1')
                      ]),
                      Column(children: [TextField(controller: vaccine1_Controller,
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('백신2')
                      ]),
                      Column(children: [TextField(controller: vaccine2_Controller,
                        decoration: const InputDecoration(hintText: " "),)
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
                  defaultColumnWidth: FixedColumnWidth(80),
                  border: TableBorder.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.3),
                  children: [
                    TableRow(children: [
                      Column(children: [Text('백신3')
                      ]),
                      Column(children: [TextField(controller: vaccine3_Controller,
                        decoration: const InputDecoration(hintText: " "),)
                      ]),
                      Column(children: [Text('백신4')
                      ]),
                      Column(children: [TextField(controller: vaccine4_Controller,
                        decoration: const InputDecoration(hintText: " "),)
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
                      Column(children: [TextField(controller: memo_Controller,
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
                    ImagePicker picker = ImagePicker();
                    // galleryurl = (await picker.getImage(source: ImageSource.gallery)) as String;
                    galleryurl = (await ImagePicker().pickImage(source: ImageSource.gallery)) as String;

                    // galleryurl = (await ImagePicker.pickImage(source: ImageSource.gallery)) as String;
                    // print("갤러리 누름");
                    print(galleryurl);
                    // getImage(ImageSource.gallery);
                  },
                ),
                FloatingActionButton(
                  heroTag: 'send_button',
                  child: Icon(Icons.arrow_circle_right_sharp),
                  tooltip: 'pick Iamge',
                  onPressed: () async{
                    lastresult = sowID_Controller.text + "," + birth_year_Controller.text +"," + birth_month_Controller.text + "," + birth_day_Controller.text + ","
                        + "," +  adoption_month_Controller.text + "," +  adoption_month_Controller.text + "," + adoption_day_Controller.text+ "," +  hormone_year_Controller.text + "," + hormone_month_Controller.text + "," + hormone_day_Controller.text+ "," + mate_month_Controller.text
                        + "," +mate_day_Controller.text+ "," + boar1ID_Controller.text + "," +boar2ID_Controller.text+ "," + check_month_Controller.text + "," + check_day_Controller.text + "," +expect_month_Controller.text+ "," + expect_day_Controller.text + "," +vaccine1_Controller.text
                        + "," +vaccine2_Controller.text+ "," + vaccine3_Controller.text+ "," + vaccine4_Controller.text+ "," + memo_Controller.text;

                    print(mate_day_Controller.text);
                    print(boar2ID_Controller.text);
                    print(adoption_day_Controller.text);
                    print(hormone_year_Controller.text);
                    print(boar2ID_Controller.text);
                    print(hormone_year_Controller.text);
                    print(check_day_Controller.text);
                    print(lastresult);
                    print(sowID_Controller.text);
                    sendData(sowID, lastresult);
                    // getImage(ImageSource.gallery);
                  },
                ),
              ])

        ],
      ),
    );

  }

}

sendData(String? modon, String? lastresult) async {
  Dio dio = new Dio();
  try {

    Response response = await dio.post(
        'http://211.107.210.141:3000/ocrs/uploadimg/front/',
        data: {
          'modon' : modon,
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

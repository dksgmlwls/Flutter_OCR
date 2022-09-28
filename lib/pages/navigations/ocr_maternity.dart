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


//임신사

class MaternityPage extends StatefulWidget {
  static const routeName = "/login";

  @override
  _MaternityPageState createState() => _MaternityPageState();
}

class _MaternityPageState extends State<MaternityPage> {
  final formKey = GlobalKey<FormState>();

  late String sowID1 ='';
  late String sowID2 ='';
  late String sowID3 ='';
  late String sowID4 ='';
  late String sowID5 ='';

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

  late String boar1ID1 ='';
  late String boar1ID2 ='';
  late String boar1ID3 ='';
  late String boar1ID4 ='';
  late String boar1ID5 ='';

  late String boar2ID1 ='';
  late String boar2ID2 ='';
  late String boar2ID3 ='';
  late String boar2ID4 ='';
  late String boar2ID5 ='';

  late String check_month ='';
  late String check_day ='';

  late String expect_month ='';
  late String expect_day ='';

  late String vaccine1 ='';
  late String vaccine2 ='';
  late String vaccine3 ='';
  late String vaccine4 ='';

  late String memo = '';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);


    if(widget != "no"){
      array = receiveresult();
      print(array);
      sowID1 = array[0];
      sowID2 = array[1];
      sowID3 = array[2];
      sowID4 = array[3];
      sowID5 = array[4];
      birth_year = array[5];
      birth_month = array[6];
      birth_day = array[7];
      adoption_year = array[8];
      adoption_month = array[9];
      adoption_day = array[10];
      hormone_year = array[11];
      hormone_month = array[12];
      hormone_day = array[13];
      mate_month = array[14];
      mate_day = array[15];
      boar1ID1 = array[16];
      boar1ID2 = array[17];
      boar1ID3 = array[18];
      boar1ID4 = array[19];
      boar1ID5 = array[20];
      boar2ID1 = array[21];
      boar2ID2 = array[22];
      boar2ID3 = array[23];
      boar2ID4 = array[24];
      boar2ID5 = array[25];
      check_month = array[26];
      check_day = array[27];
      expect_month = array[28];
      expect_day = array[29];
      vaccine1 = array[30];
      vaccine2 = array[31];
      vaccine3 = array[32];
      vaccine4 = array[33];
      memo = array[34];

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
                  defaultColumnWidth: FixedColumnWidth(45.7142857),
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
                      Column(children: [Text(sowID1,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text(sowID2,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text(sowID3,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text(sowID4,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text('-',
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text(sowID5,
                          style: TextStyle(fontSize: 20.0))
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
                      Column(children: [Text(birth_year,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text('년')
                      ]),
                      Column(children: [Text(birth_month,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text('월')
                      ]),
                      Column(children: [Text(birth_day,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text('일')
                      ]),
                    ],
                    ),
                    TableRow(children: [
                      Column(children: [Text('구입일')
                      ]),
                      Column(children: [Text(adoption_year,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text('년')
                      ]),
                      Column(children: [Text(adoption_month,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text('월')
                      ]),
                      Column(children: [Text(adoption_day,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text('일')
                      ]),
                    ],
                    ),
                    TableRow(children: [
                      Column(children: [Text('초발정일')
                      ]),
                      Column(children: [Text(hormone_year,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text('년')
                      ]),
                      Column(children: [Text(hormone_month,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text('월')
                      ]),
                      Column(children: [Text(hormone_day,
                          style: TextStyle(fontSize: 20.0))
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
                      Column(children: [Text(mate_month,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text('월')
                      ]),
                      Column(children: [Text(mate_day,
                          style: TextStyle(fontSize: 20.0))
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
                      Column(children: [Text('1차웅돈번호')
                      ]),
                      Column(children: [Text(boar1ID1,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text(boar1ID2,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text(boar1ID3,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text(boar1ID4,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text('-')
                      ]),
                      Column(children: [Text(boar1ID5,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                    ],
                    ),
                    TableRow(children: [
                      Column(children: [Text('2차웅돈번호')
                      ]),
                      Column(children: [Text(boar2ID1,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text(boar2ID2,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text(boar2ID3,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text(boar2ID4,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text('-')
                      ]),
                      Column(children: [Text(boar2ID5,
                          style: TextStyle(fontSize: 20.0))
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
                      Column(children: [Text('재발확인일')
                      ]),
                      Column(children: [Text(check_month,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text('월')
                      ]),
                      Column(children: [Text(check_day,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text('일')
                      ]),
                    ],
                    ),
                    TableRow(children: [
                      Column(children: [Text('분만예정일')
                      ]),
                      Column(children: [Text(expect_month,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text('월')
                      ]),
                      Column(children: [Text(expect_day,
                          style: TextStyle(fontSize: 20.0))
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
                      Column(children: [Text(vaccine1,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text('백신2')
                      ]),
                      Column(children: [Text(vaccine2,
                          style: TextStyle(fontSize: 20.0))
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
                      Column(children: [Text(vaccine3,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                      Column(children: [Text('백신4')
                      ]),
                      Column(children: [Text(vaccine4,
                          style: TextStyle(fontSize: 20.0))
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
                      Column(children: [Text(memo,
                          style: TextStyle(fontSize: 20.0))
                      ]),
                    ])
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );

  }

}
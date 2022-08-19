import 'dart:ffi';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GraphPage extends StatefulWidget {
  static const routeName = '/camera-page';

  const  GraphPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  
  String dropdownValue = '총산자수';
  
  List<String> spinnerItems = [
    "총산자수",
    "포유개시두수",
    "생시체중",
    "이유두수",
    "이유체중"];


  DateTime startDate = DateTime.now() ;
  DateTime stopDate = DateTime.now();

  var customFormat = DateFormat('yyyy-MM-dd');

  Future<Null> showPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2101)
    );

    if (picked != null && picked != startDate)
      setState(() {
        startDate = picked;
      });
  }

  Future<Null> showPicker2(BuildContext context) async {

    final DateTime? picked2 = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2101)
    );


    if (picked2 != null && picked2 != stopDate)
      setState(() {
        stopDate = picked2;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Text('기간'),
              ],
            ),
            Row(
              children: [
                Text('${customFormat.format(startDate)}', style: TextStyle(fontSize: 18),),
                SizedBox(height: 20.0,),
                IconButton(onPressed: () => showPicker(context), icon: Icon(Icons.calendar_today_rounded)),
                Text('~ '),
                Text('${customFormat.format(stopDate)}', style: TextStyle(fontSize: 18),),
                SizedBox(height: 20.0,),
                IconButton(onPressed: () => showPicker2(context), icon: Icon(Icons.calendar_today_rounded)),
              ],
            ),
            Row(
              children: [
                Text('종류'),
              ],
            ),
            Row(
              children: [
                DropdownButton(
                    value: dropdownValue,
                    items: spinnerItems.map((value){
                      return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value){
                      setState(() {
                        dropdownValue = value.toString();
                      });
                    })
              ]),
            Row(
              children: [
                RaisedButton(
                  child: Text('그래프보기'),
                  onPressed: () => sendGraph(startDate.toString(), stopDate.toString(), dropdownValue.toString()),
                  color: Colors.blue,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

sendGraph(String? start_day, String? stop_day, String? number) async {
  Dio dio = new Dio();

  try {
    Response response = await dio.post(
        'http://211.107.210.141:3000/statistic',
        data: {
          'startdate' : start_day,
          'enddate' : stop_day,
          'sqlcol' : number
        }
    );
    return response.statusCode;
  } catch (e) {
    Exception(e);
  } finally {
    dio.close();
  }
  return 0;
}

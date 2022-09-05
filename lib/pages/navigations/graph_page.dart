import 'dart:ffi';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ocr/pages/api/upload_image.dart';

class GraphPage extends StatefulWidget {
  static const routeName = '/camera-page';

  const GraphPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {

  late String first = '' ;

  //late List<Double> array;


  String dropdownValue = '총산자수';
  String title = '';

  List<String> spinnerItems = [
    "총산자수",
    "포유개시두수",
    "생시체중",
    "이유두수",
    "이유체중" ];


  DateTime startDate = DateTime.now() ;
  DateTime stopDate = DateTime.now();

  var customFormat = DateFormat('yyyy-MM-dd');

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

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


    //그래프 데이터 값 받아오기
    array = receiveresult();
    //array = ['1','2','3'];

    first = array[0];


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
                          title = value.toString();
                        });
                      })
                ]),
            Row(
              children: [
                RaisedButton(
                    child: Text('그래프보기'),
                    onPressed: () => sendGraph(startDate.toString(), stopDate.toString(), dropdownValue.toString()),
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 20)
                ),
              ],
            ),
            Column(
              children: [
                AspectRatio(aspectRatio: 3/2,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10),
                        ),
                        color: Color(0xff232d37)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                      child: LineChart(
                        showAvg ? avgChart() : mainChart(),
                      ),
                    ),
                  ),)
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


//데이터 별 그래프
LineChartData mainChart() {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: Color(0xff37434d),
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: Color(0xff37434d),
          strokeWidth: 1,
        );
      },
    ),
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 22,
        textStyle: const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 16),
        getTitles: (value) {
          print('bottomTitles $value');
          switch (value.toInt()) {
            case 2:
              return 'MAR';
            case 5:
              return 'JUN';
            case 8:
              return 'SEP';
          }
          return '';
        },
        margin: 8,
      ),
      leftTitles: SideTitles(
        showTitles: true,
        textStyle: const TextStyle(
          color: Color(0xff67727d),
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        getTitles: (value) {
          print('leftTitles $value');
          switch (value.toInt()) {
            case 1:
              return '10k';
            case 3:
              return '30k';
            case 5:
              return '50k';
          }
          return '';
        },
        reservedSize: 28,
        margin: 12,
      ),
    ),
    borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1)),
    minX: 0,
    maxX: 11,
    minY: 0,
    maxY: 6,
    lineBarsData: [
      LineChartBarData(
        spots: [
          // for(double i = 0.0; i < 10 ; i++){
          //   FlSpot(i, 3),
          // };
          FlSpot(0, 3),
          FlSpot(2.6, 2),
          FlSpot(4.9, 5),
          FlSpot(6.8, 3.1),
          FlSpot(8, 4),
          FlSpot(9.5, 3),
          FlSpot(11, 4),
        ],
        isCurved: true,
        colors: gradientColors,
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
        ),
        belowBarData: BarAreaData(
          show: true,
          colors:
          gradientColors.map((color) => color.withOpacity(0.3)).toList(),
        ),
      ),
    ],
  );

}


//평균그래프
LineChartData avgChart() {

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  return LineChartData(
    lineTouchData: LineTouchData(enabled: false),
    gridData: FlGridData(
      show: true,
      drawHorizontalLine: true,
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
    ),
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 22,
        textStyle: const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 16),
        getTitles: (value) {
          switch (value.toInt()) {
            case 2:
              return 'MAR';
            case 5:
              return 'JUN';
            case 8:
              return 'SEP';
          }
          return '';
        },
        margin: 8,
      ),
      leftTitles: SideTitles(
        showTitles: true,
        textStyle: const TextStyle(
          color: Color(0xff67727d),
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 1:
              return '10k';
            case 3:
              return '30k';
            case 5:
              return '50k';
          }
          return '';
        },
        reservedSize: 28,
        margin: 12,
      ),
    ),
    borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1)),
    minX: 0,
    maxX: 11,
    minY: 0,
    maxY: 6,
    lineBarsData: [
      LineChartBarData(
        spots: [
          FlSpot(0, 3.44),
          FlSpot(2.6, 3.44),
          FlSpot(4.9, 3.44),
          FlSpot(6.8, 3.44),
          FlSpot(8, 3.44),
          FlSpot(9.5, 3.44),
          FlSpot(11, 3.44),
        ],
        isCurved: true,
        // colors: [
        //   ColorTween(begin: gradientColors[0], end: gradientColors[1])
        //       .lerp(0.2),
        //   ColorTween(begin: gradientColors[0], end: gradientColors[1])
        //       .lerp(0.2),
        // ],
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(show: true, colors: [
          ColorTween(begin: gradientColors[0], end: gradientColors[1])
              .lerp(0.2)!
              .withOpacity(0.1),
          ColorTween(begin: gradientColors[0], end: gradientColors[1])
              .lerp(0.2)!
              .withOpacity(0.1),
        ]),
      ),
    ],
  );
}
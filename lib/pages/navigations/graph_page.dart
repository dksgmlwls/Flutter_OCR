import 'dart:ffi';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GraphPage extends StatefulWidget {
  static const routeName = '/camera-page';

  const GraphPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {

  // Generate some dummy data for the cahrt
  // This will be used to draw the red line
  final List<FlSpot> dummyData1 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  // This will be used to draw the orange line
  final List<FlSpot> dummyData2 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });



  String dropdownValue = '총산자수';

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
    const Color(0xffffffff),
    const Color(0xffffffff),
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
                    color: Colors.white,
                    textColor: Colors.black,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10)
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
                        color: Color(0xffffffff)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: LineChart(
                         LineChartData(
                           borderData: FlBorderData(show: false),
                           lineBarsData: [
                             //The red line
                             LineChartBarData(
                               spots: dummyData1,
                               isCurved: true,
                               barWidth: 3,
                               colors: [
                                 Colors.red,
                               ]
                             ),
                             LineChartBarData(
                                 spots: dummyData2,
                                 isCurved: true,
                                 barWidth: 3,
                                 colors: [
                                   Colors.blue,
                                 ]
                             ),

                           ]
                         )



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



LineChartData mainChart() {

  List<Color> gradientColors_values = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  List<Color> gradientColors_avg = [
    const Color(0xfffa0000),
    const Color(0xffffdd00),
  ];

  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: Color(0xff000000),
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: Color(0xff000000),
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
            color: Color(0xff000000),
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
          color: Color(0xff000000),
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
        border: Border.all(color: const Color(0xff000000), width: 1)),
    minX: 0,
    maxX: 11,
    minY: 0,
    maxY: 6,
    lineBarsData: [
      LineChartBarData(
        spots: [
          FlSpot(0, 3),
          FlSpot(2.6, 2),
          FlSpot(4.9, 5),
          FlSpot(6.8, 3.1),
          FlSpot(8, 4),
          FlSpot(9.5, 3),
          FlSpot(11, 4),
        ],

        isCurved: true,
        colors: gradientColors_values,
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
        ),
        belowBarData: BarAreaData(
          show: true,
          colors:
          gradientColors_values.map((color) => color.withOpacity(0.3)).toList(),
        ),
      ),
    ],

  );

}

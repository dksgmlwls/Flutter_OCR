// import 'dart:ffi';
import 'dart:ffi';
// import 'dart:html';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ocr/pages/api/upload_image.dart';

late List<double> array_graph = List.filled(8, 0, growable: true);
var int_list = List<int>.filled(5, 0);


class GraphPage extends StatefulWidget {
  static const routeName = '/camera-page';

  const GraphPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {

  //late List<double> array_graph = [10, 20, 30, 40, 0, 40 ,25, 0];


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
    "이유두수",
    "교백복수"];


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

  //final List array_graph = [];

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
                    // onPressed: () => sendGraph(startDate.toString(), stopDate.toString(), dropdownValue.toString()),
                    onPressed: () async{
                      var a = await sendGraph(dropdownValue.toString());
                      //make_mainChart(a);
                      print(a);
                      mainChart();

                      array_graph[0] = a[0].toDouble();
                      array_graph[1] = a[1].toDouble();
                      array_graph[2] = a[2].toDouble();
                      array_graph[3] = a[3].toDouble();
                      array_graph[4] = a[4].toDouble();
                      array_graph[5] = a[5].toDouble();
                      array_graph[6] = a[6].toDouble();
                      array_graph[7] = a[7].toDouble();
                      int_list[0] = a[4].toInt();
                      int_list[1] = a[6].toInt();


                      print(array_graph);
                      print(int_list);

                      //make_mainChart(a);
                      // mainChart2(a);

                    },
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
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: LineChart(
                        mainChart(),
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

sendGraph(String? number) async {
  Dio dio = new Dio();

  try {
    Response response = await dio.post(
        'http://211.107.210.141:3001/statistic',
        data: {
          'sqlcol' : number
        }
    );
    return response.data['result'];
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

  // array_graph = receiveresult_graph();
  print("main 그래프 페이지 값 ");
  // print(array_graph);
  //var oneweek  = array_graph[0] as double;
  final oneweek = array_graph[0];
  final  twoweek = array_graph[1];
  final threeweek = array_graph[2];
  final fourweek = array_graph[3];
  final goal = array_graph[4];
  final minvalue = array_graph[5];
  final maxvalue = array_graph[6];
  final middlevalue = array_graph[7];
  final int_goal = int_list[0];
  final int_max = int_list[1];

  return LineChartData(

    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 10,
      drawHorizontalLine: true,
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
          // print('bottomTitles $value');
          switch (value.toInt()) {
            case 0:
              return '1주';
            case 3:
              return '2주';
            case 6:
              return '3주';
            case 9:
              return '4주';
          }
          return '';
        },
        margin: 8,
      ),
      leftTitles: SideTitles(
        showTitles: true,
        interval: 10,
        textStyle: const TextStyle(
          color: Color(0xff000000),
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        getTitles: (value) {
          // print('leftTitles $value');
          if (value.toInt() == minvalue) {
            return minvalue.toInt().toString();
          }else if(value.toInt() == maxvalue){
            return maxvalue.toInt().toString();
          }else if(value.toInt() == goal){
            return goal.toInt().toString();
          }else{
            return value.toInt().toString();
          }
          return '';
        },
        reservedSize: 28,
        margin: 12,
      ),
    ),
    // // borderData: FlBorderData(
    // //     show: true,
    // //     border: Border.all(color: const Color(0xff000000), width: 1)),
    minX: 0,
    maxX: 9,
    minY: 0,
    maxY: 40,
    lineBarsData: [
      LineChartBarData(
        spots: [
          FlSpot(0, oneweek),
          FlSpot(3, twoweek),
          FlSpot(6, threeweek),
          FlSpot(9, fourweek),
        ],

        isCurved: true,
        colors: gradientColors_values,
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
        ),
      ),
      LineChartBarData(
        spots: [
          FlSpot(0, goal),
          FlSpot(3, goal),
          FlSpot(6, goal),
          FlSpot(9, goal),
        ],
        isCurved: true,
        colors: gradientColors_avg,
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
        ),
      ),
    ],

  );

}
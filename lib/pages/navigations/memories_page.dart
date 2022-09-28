
import 'package:dio/dio.dart';
import 'package:editable/commons/math_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ocr/pages/navigations/ocr_maternity.dart';
import 'package:ocr/providers/auth_provider.dart';
import 'package:ocr/src/customization/calendar_style.dart';
import 'package:ocr/src/customization/header_style.dart';
import 'package:ocr/src/shared/utils.dart';
import 'package:ocr/src/table_calendar.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:flutter_clean_calendar/clean_calendar_event.dart';

class MemoryPage extends StatefulWidget {
  static const routeName = '/camera-page';

  const MemoryPage({Key? key}) : super(key: key);

  @override
  _MemoryPageState createState() => _MemoryPageState();
}

class _MemoryPageState extends State<MemoryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "기록보기",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          bottom: TabBar(
            labelColor: Colors.black,
            tabs: <Widget>[
              Tab(text: "내 기록보기"),
              Tab(text: "모든 기록보기"),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            FindUserMine(),
            FindUserEverybody(),
          ],
        ),
      ),
    );
  }
}

class FindUserMine extends StatefulWidget {
  @override
  _FindUserMineState createState() => _FindUserMineState();
}

class _FindUserMineState extends State<FindUserMine> {


  // var myFormat = DateFormat('d-MM-yyyy');

  DateTime? selectedDay;
  List <CleanCalendarEvent>? selectedEvent;

  final Map<DateTime,List<CleanCalendarEvent>> events = {
    DateTime (DateTime.now().year,DateTime.now().month,DateTime.now().day):
    [
      CleanCalendarEvent('Event A',
          startTime: DateTime(
              DateTime.now().year,DateTime.now().month,DateTime.now().day,10,0),
          endTime:  DateTime(
              DateTime.now().year,DateTime.now().month,DateTime.now().day,12,0),
          description: 'A special event',
          color: Colors.blue),
    ],
  };


  void _handleData(date){
    setState(() {
      selectedDay = date;
      selectedEvent = events[selectedDay] ?? [];
      //selectedDay = DateFormat('yyyy-MM-dd').format(selectedDay);
    });
    //print("_handleData" , selectedDay.);
    //서버로 날짜 전송
  }

  @override
  void initState() {
    // TODO: implement initState
    selectedEvent = events[selectedDay] ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Container(
          child: Calendar(
            startOnMonday: true,
            locale: 'ko-KR',
            selectedColor: Colors.blue,
            todayColor: Colors.red,
            eventColor: Colors.green,
            eventDoneColor: Colors.amber,
            bottomBarColor: Colors.deepOrange,
            todayButtonText: '',
            // onRangeSelected: (range) {
            //   print('selected Day ${range.from},${range.to}');
            // },
            onDateSelected: (date) async {

              print("날짜선탥했슈");
              print(DateFormat('yyyy-MM-dd').format(date));

              var memory = await sendRecordMine(DateFormat('yyyy-MM-dd').format(date));

              String a = memory[0].toString();
              print(a);

              // for(int i  = 0 ; i < count ; i++){
              //     modon[i];
              //     name[i];
              //
              // };

              //더 정리해보기

              // for(int i  = 0 ; i < count ; i++){
              //   make_event(modon1, name1);
              // };

              return _handleData(date);

            },
            onEventSelected: (date){
              print("이벤트선택했슈");
            },
            events: events,
            isExpanded: true,
            dayOfWeekStyle: TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.w100,
            ),
            bottomBarTextStyle: TextStyle(
              color: Colors.white,
            ),
            hideBottomBar: false,
            hideArrows: false,
            weekDays: ['월','화','수','목','금','토','일'],
          ),
        ),
      ),
    );
  }
}

void make_event(String name, String modon) {

  final Map<DateTime,List<CleanCalendarEvent>> events = {
    DateTime (DateTime.now().year,DateTime.now().month,DateTime.now().day):
    [
      CleanCalendarEvent(name,
          startTime: DateTime(
              DateTime.now().year,DateTime.now().month,DateTime.now().day,10,0),
          endTime:  DateTime(
              DateTime.now().year,DateTime.now().month,DateTime.now().day,12,0),
          description: modon,
          color: Colors.blue),
    ],
  };


}

class FindUserEverybody extends StatefulWidget {
  @override
  _FindUserEverybodyState createState() => _FindUserEverybodyState();
}

class _FindUserEverybodyState extends State<FindUserEverybody> {

  DateTime? selectedDay;
  List <CleanCalendarEvent>? selectedEvent;

  final Map<DateTime,List<CleanCalendarEvent>> events = {
    DateTime (DateTime.now().year,DateTime.now().month,DateTime.now().day):
    [
      CleanCalendarEvent('Event A',
          startTime: DateTime(
              DateTime.now().year,DateTime.now().month,DateTime.now().day,10,0),
          endTime:  DateTime(
              DateTime.now().year,DateTime.now().month,DateTime.now().day,12,0),
          description: 'A special event',
          color: Colors.blue),
    ],

    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2):
    [
      CleanCalendarEvent('Event B',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 10, 0),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 12, 0),
          color: Colors.orange),
      CleanCalendarEvent('Event C',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 14, 30),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 17, 0),
          color: Colors.pink),
    ],
  };

  void _handleData(date){
    setState(() {
      selectedDay = date;
      selectedEvent = events[selectedDay] ?? [];
    });
    print(selectedDay);
   // sendRecordEvery(selectedDay.toString());
  }
  @override
  void initState() {
    // TODO: implement initState
    selectedEvent = events[selectedDay] ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Container(
          child: Calendar(
            startOnMonday: true,
            locale: 'ko-KR',
            selectedColor: Colors.blue,
            todayColor: Colors.red,
            eventColor: Colors.green,
            eventDoneColor: Colors.amber,
            todayButtonText: '',
            bottomBarColor: Colors.deepOrange,
            // onRangeSelected: (range) {
            //   print("날자 선택?");
            //   print('selected Day ${range.from},${range.to}');
            // },
            onDateSelected: (date){
              print("날짜선택맞지?????/");
              sendRecordEvery(date.toString());
              return _handleData(date);
            },
            onEventSelected: (date){
              print("이벤트선택했슈");

              /////////페이지 이동 및 데이터띄우기
            },
            events: events,
            isExpanded: true,
            dayOfWeekStyle: TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.w100,
            ),
            bottomBarTextStyle: TextStyle(
              color: Colors.grey,
            ),
            hideBottomBar: false,
            hideArrows: false,
            weekDays: ['월','화','수','목','금','토','일'],
          ),
        ),
      ),
    );
  }
}


//서버로 사용자가 선택한 날짜 전송(내 기록보기)
sendRecordMine(String? day) async {
  Dio dio = new Dio();

  try {
    Response response = await dio.post(
        'http://211.107.210.141:4000/memory/list',
        data: {
          'date' : day,
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

//서버로 사용자가 선택한 날짜 전송(모든 기록보기)
sendRecordEvery(String? day) async {
  Dio dio = new Dio();

  try {
    Response response = await dio.post(
        'http://211.107.210.141:4000/memory/list',
        data: {
          'date' : day,
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

import 'package:dio/dio.dart';
import 'package:editable/commons/math_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocr/providers/auth_provider.dart';
import 'package:ocr/src/customization/calendar_style.dart';
import 'package:ocr/src/customization/header_style.dart';
import 'package:ocr/src/shared/utils.dart';
import 'package:ocr/src/table_calendar.dart';

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
  final formKey_mine = GlobalKey<FormState>();
  late Map<DateTime, List<Event>> selectedEvents_mine;
  CalendarFormat format_mine = CalendarFormat.month;
  DateTime selectedDay_mine = DateTime.now();
  DateTime focusedDay_mine = DateTime.now();
  TextEditingController _eventController_mine = TextEditingController();

  @override
  void initState() {
    selectedEvents_mine = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents_mine[date] ?? [];
  }

  @override
  void dispose() {
    _eventController_mine.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            focusedDay: selectedDay_mine,
            firstDay: DateTime(2022),
            lastDay: DateTime(2101),
            calendarFormat: format_mine,
            onFormatChanged: (CalendarFormat _format){
              setState(() {
                format_mine = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,

            //Day Changed
            onDaySelected: (DateTime selectDay, DateTime focusDay){
              setState(() {
                selectedDay_mine = selectDay;
                focusedDay_mine = focusDay;
              });
              print(focusedDay_mine);
            },
            selectedDayPredicate: (DateTime date){
              sendRecord(_eventController_mine.text);
              return isSameDay(selectedDay_mine, date);
            },

            eventLoader: _getEventsfromDay,

            //To style the calendar
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Colors.purpleAccent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            headerStyle: HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
                formatButtonShowsNext: false,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                formatButtonTextStyle: TextStyle(
                  color: Colors.white,
                ),

            ),
          ),

        ],
      ),

    );
  }
}

class Event {
  final String title;
  Event({required this.title});
  String toString() => this.title;
}

class FindUserEverybody extends StatefulWidget {
  @override
  _FindUserEverybodyState createState() => _FindUserEverybodyState();
}

class _FindUserEverybodyState extends State<FindUserEverybody> {
  final formKey_every = GlobalKey<FormState>();

  late Map<DateTime, List<Event>> selectedEvents_every;
  CalendarFormat format_every = CalendarFormat.month;
  DateTime selectedDay_every = DateTime.now();
  DateTime focusedDay_every = DateTime.now();
  TextEditingController _eventController_every = TextEditingController();

  @override
  void initState() {
    selectedEvents_every = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents_every[date] ?? [];
  }

  @override
  void dispose() {
    _eventController_every.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            focusedDay: selectedDay_every,
            firstDay: DateTime(2022),
            lastDay: DateTime(2101),
            calendarFormat: format_every,
            onFormatChanged: (CalendarFormat _format){
              setState(() {
                format_every = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,

            //Day Changed
            onDaySelected: (DateTime selectDay, DateTime focusDay){
              setState(() {
                selectedDay_every = selectDay;
                focusedDay_every = focusDay;
              });
              print(focusedDay_every);
              sendRecord(_eventController_every.text);
            },
            selectedDayPredicate: (DateTime date){
              return isSameDay(selectedDay_every, date);
            },

            eventLoader: _getEventsfromDay,

            //To style the calendar
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Colors.purpleAccent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5.0),
              ),
              formatButtonTextStyle: TextStyle(
                color: Colors.white,
              ),

            ),
          ),
        ],
      ),

    );
  }
}

sendRecord(String? day) async {
  Dio dio = new Dio();

  try {
    Response response = await dio.post(
        'http://211.107.210.141:3000/statistic',
        data: {
          'startdate' : day,
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
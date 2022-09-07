import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; //쿠퍼티노 위젯
import 'package:ocr/pages/home_page.dart';
import 'package:ocr/pages/initial_page.dart';
import 'package:ocr/pages/auths/login_page.dart';
import 'package:ocr/pages/auths/register_page.dart';
import 'package:ocr/pages/navigations/camera_page.dart';
import 'package:ocr/pages/navigations/camera_page2.dart';
import 'package:ocr/pages/navigations/graph_page.dart';
import 'package:ocr/pages/navigations/memories_page.dart';
import 'package:ocr/providers/auth_provider.dart';
import '/pages/initial_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //   title: 'OCR',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      title: 'Flutter Demo',
      home: HomePage(''),
      // ),
    );
  }
}


//
// class FormScreen extends StatefulWidget {
//   const FormScreen({Key? key, required this.title}) : super(key: key);
//   final String title;
//
//   @override
//   State<FormScreen> createState() => FormScreenState();
// }
//
// class FormScreenState extends State<FormScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => LoginPage()),
//                       );
//                     },
//                     child: Text('로그인'),
//                   ),
//
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push( // SecondPage로 화면 이동 코드.
//                         context,
//                         MaterialPageRoute(builder: (context) => SignUpPage()),
//                       );
//                     },
//                     child: Text('회원가입'),
//                   ),
//
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => HomePage("")),
//                       );
//                     },
//                     child: Text('메인'),
//                   ),
//
//                 ],
//               )),
//         ],
//       ),
//     );
//   }
//
// }

class HomePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);
  final String path;
  const HomePage(this.path);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;


  List<Widget> _screen = [
    UseCameraPage("no"),
    UseCameraPage2("no"),
    GraphPage(),
    MemoryPage(),
  ];


  @override
  Widget build(BuildContext context) {
    // int _selectedIndex = 0;

    List<Widget> _screen = [
      UseCameraPage(widget.path==null? "no" : widget.path),
      UseCameraPage2(widget.path==null? "no" : widget.path),
      GraphPage(),
      MemoryPage(),
    ];

    return Scaffold(
      body: _screen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            label: '임신사',
            icon: Icon(Icons.aspect_ratio_outlined ),
          ),
          BottomNavigationBarItem(
            label: '분만사',
            icon: Icon(Icons.aspect_ratio_rounded),
          ),
          BottomNavigationBarItem(
            label: '그래프',
            icon: Icon(Icons.bar_chart_rounded),
          ),
          BottomNavigationBarItem(
            label: '기록',
            icon: Icon(Icons.chat),
          ),
        ],
        onTap: (int index) {
          setState(
                () {
              _selectedIndex = index;
            },
          );
        },
      ),
    );
  }
}

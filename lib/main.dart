import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; //쿠퍼티노 위젯
import 'package:ocr/pages/home_page.dart';
import 'package:ocr/pages/initial_page.dart';
import 'package:ocr/pages/auths/login_page.dart';
import 'package:ocr/pages/auths/register_page.dart';
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
      home: FormScreen(title: 'OCR'),
     // ),
    );
  }
}

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<FormScreen> createState() => FormScreenState();
}

class FormScreenState extends State<FormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        // MaterialPageRoute는 머테리얼 디자인으로 작성된 페이지 사이에 화면 전환을 할 때 사용된다.
                        // MaterialPageRoute는 안드로이드와 iOS 각 플랫폼에 맞는 화면 전환을 지원해준다.
                      );
                    },
                    child: Text('로그인'),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push( // SecondPage로 화면 이동 코드.
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                        // MaterialPageRoute는 머테리얼 디자인으로 작성된 페이지 사이에 화면 전환을 할 때 사용된다.
                        // MaterialPageRoute는 안드로이드와 iOS 각 플랫폼에 맞는 화면 전환을 지원해준다.
                      );
                    },
                    child: Text('회원가입'),
                  ),

                  ElevatedButton(
                    onPressed: () {

                      Navigator.push( // SecondPage로 화면 이동 코드.
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        // MaterialPageRoute는 머테리얼 디자인으로 작성된 페이지 사이에 화면 전환을 할 때 사용된다.
                        // MaterialPageRoute는 안드로이드와 iOS 각 플랫폼에 맞는 화면 전환을 지원해준다.
                      );
                    },
                    child: Text('메인화면'),
                  ),

                ],
              )),
        ],
      ),
    );
  }

}

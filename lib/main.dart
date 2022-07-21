import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; //쿠퍼티노 위젯
import 'package:ocr/pages/home_page.dart';
import 'package:ocr/pages/initial_page.dart';
import 'package:ocr/pages/auths/login_page.dart';
import 'package:ocr/pages/auths/register_page.dart';
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
  State<FormScreen> createState() => Login();
}

class Login extends State<FormScreen> {
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
                      //!!!! 중요
                      //pop을 이용해 데이터를 반환할때는 arguments클래스를 생성하면서 returnValue 에 데이터를 실어서 보낸다.
                      //Navigator.pop(context, Arguments(returnValue: ReturnValue(result:'Yep!')));
                      //Navigator.of(context).pushNamed(LoginPage.routeName);
                      Navigator.push( // SecondPage로 화면 이동 코드.
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
                      // Navigator.push(
                      //   context,
                      //   //MaterialPageRoute(builder: (_) => Register2()),
                      // );
                     //Navigator.of(context).pushNamed(SignUpPage.routeName);
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
                      // Navigator.push(
                      //   context,
                      //   //MaterialPageRoute(builder: (_) => Register2()),
                      // );
                      //Navigator.of(context).pushNamed(SignUpPage.routeName);
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


class SignUpPage extends StatefulWidget {
  static const routeName = "/signUp";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  late String _name;
  late String _password;
  late String _email;
  late String _phoneNumber;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          "회원가입 실패",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text("예"),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (formKey.currentState!.validate() == false) {
      return;
    } else {
      formKey.currentState!.save();
      try {
        await Provider.of<AuthProvider>(context, listen: false)
            .signUp(_name, _phoneNumber, _email, _password);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("가입이 완료되었습니다. 로그인을 진행해주세요."),
            duration: Duration(seconds: 1),
          ),
        );
        Navigator.of(context).pop();
      } catch (error) {
        _showErrorDialog("이미 존재하는 계정입니다.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "회원가입",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleTextComponent("이름"),
                Container(
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "이름을 입력해주세요.",
                    ),
                    onSaved: (value) {
                      _name = value!;
                    },
                    // validator: (value) {
                    //   if (value!.length < 4) {
                    //     return "이름은 4자 이하입니다.";
                    //   }
                    // },
                  ),
                ),
                SizedBox(height: 20),
                TitleTextComponent("휴대폰 번호"),
                Container(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "(예시) 01012341234",
                    ),
                    onSaved: (value) {
                      _phoneNumber = value!;
                    },
                    // validator: (value) {
                    //   if (value!.length < 10) {
                    //     return "휴대폰 번호는 10자 이하입니다.";
                    //   }
                    // },
                  ),
                ),
                SizedBox(height: 20),
                TitleTextComponent("계정 이메일"),
                Container(
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "이메일을 입력해주세요.",
                    ),
                    onSaved: (value) {
                      _email = value!;
                    },
                    // validator: (value) {
                    //   if (value!.length < 10) {
                    //     return "이메일 형식에 맞게 입력해주세요.";
                    //   }
                    // },
                  ),
                ),
                SizedBox(height: 20),
                TitleTextComponent("비밀번호"),
                Container(
                  child: Text(
                    "영문, 숫자, 특수문자를 1개 이상 조합하여 10자리 이상을 입력해주세요.",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  margin: EdgeInsets.only(bottom: 10),
                ),
                Container(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: "비밀번호를 입력해주세요.",
                    ),
                    onSaved: (value) {
                      _password = value!;
                    },
                    // validator: (value) {
                    //   if (value!.length < 10) {
                    //     return "비밀번호는 10자 이상입니다.";
                    //   }
                    // },
                  ),
                ),
                SizedBox(height: 20),
                TitleTextComponent("비밀번호 확인"),
                Container(
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: "비밀번호를 다시 입력해주세요.",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //CheckBoxComponent("개인정보 수집 및 이용 동의 (필수)"),
                SizedBox(height: 20),
                FlatButton(
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey,
                    ),
                    child: Text("가입하기",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center),
                  ),
                  onPressed: () {
                    //_submit();
                    Navigator.of(context).pushNamed(LoginPage.routeName);

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget TitleTextComponent(String keyword) {
    return Container(
      child: Text(
        keyword,
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      margin: EdgeInsets.only(bottom: 10),
    );
  }

  Widget TextFormFieldComponent(
      bool obscureText,
      TextInputType keyboardType,
      TextInputAction textInputAction,
      String hintText,
      int maxSize,
      String errorMessage) {
    return Container(
      child: TextFormField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          hintText: hintText,
        ),
        onSaved: (value) {},
        validator: (value) {
          if (value!.length < maxSize) {
            return errorMessage;
          }
        },
      ),
    );
  }

// Widget CheckBoxComponent(String keyword) {
//   return CheckboxListTileFormField(
//     validator: (value) {
//       if (value == false) {
//         return "필수 동의 항목입니다.";
//       } else {
//         return null;
//       }
//     },
//     title: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           keyword,
//           style: TextStyle(
//             fontSize: 12,
//           ),
//         ),
//         FlatButton(
//           child: Container(
//             padding: EdgeInsets.all(5),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5), color: Colors.grey),
//             child: Text(
//               "자세히",
//               style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//             ),
//           ),
//           onPressed: () {},
//         ),
//       ],
//     ),
//   );
// }
}

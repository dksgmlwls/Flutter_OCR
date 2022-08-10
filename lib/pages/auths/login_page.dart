import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; //쿠퍼티노 위젯
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ocr/findUserInfo_page.dart';
// import 'package:ocr/pages/home_page.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:ocr/providers/auth_provider.dart';
// import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:ocr/pages/home_page.dart';


class LoginPage extends StatefulWidget {
  static const routeName = "/login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  var _isLoading = false;

  late String? _id;
  late String? _password;
  late int? res;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) =>
          AlertDialog(
            title: Text(
              "로그인 실패",
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
        setState(() {
          _isLoading = true;
        });
        res = await login(_id, _password);
        print(res);
        setState(() {
          _isLoading = false;
        });
        switch(res){
          case 200:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("로그인에 성공하였습니다."),
                duration: Duration(seconds: 1),
                
              ),
            );
            //Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage("no")),);
            //Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            //Navigator.of(context).pushNamed(HomePage);
            break;
          case 201:
            _showErrorDialog("이메일을 입력해주세요");
            break;
          case 202:
            _showErrorDialog("비밀번호를 입력해주세요");
            break;
          case 203:
            _showErrorDialog("이메일을 잘못 입력하셨습니다.");
            break;
          case 204:
            _showErrorDialog("비밀번호를 잘못 입력하셨습니다.");
            break;
          case 205:
            _showErrorDialog("오류");
            break;
          default:
            break;
        }
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        _showErrorDialog("아이디 또는 비밀번호를 확인해주세요.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "로그인",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.8,
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20.0),
                  //child: Image.asset("images/initial_4.png"),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: "아이디를 입력해주세요.",
                        ),
                        onSaved: (value) {
                          _id = value;
                        },
                        // validator: (value) {
                        //   if (value!.length < 10) {
                        //     return "이메일 형식에 맞게 입력해주세요.";
                        //   }
                        // },
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: "비밀번호를 입력해주세요.",
                          ),
                          onSaved: (value) {
                            _password = value;
                          },
                          // validator: (value) {
                          //   if (value!.length < 10) {
                          //     return "비밀번호는 10자 이상입니다.";
                          //   }
                          // },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                _isLoading
                    ? Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: CircularProgressIndicator(),
                )
                    : FlatButton(
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    child: Text("로그인",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center),
                  ),
                  onPressed: () {
                    _submit();
                    //Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "이메일 또는 비밀번호를 잊으셨나요?",
                      style: TextStyle(color: Colors.blue, fontSize: 10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => FindUserInfoPage()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

login(String? id, String? password) async {
  Dio dio = new Dio();
  try {
    Response response = await dio.post(
        'http://211.107.210.141:3000/users/login/',
        data: {
          'email' : id,
          'password' : password,
        }
    );
    final jsonBody = response.data;
    return response.statusCode;
  } catch (e) {
    Exception(e);
  } finally {
    dio.close();
  }
  return 0;
}
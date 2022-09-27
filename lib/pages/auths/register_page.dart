import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; //쿠퍼티노 위젯
// import 'package:ocr/pages/auths/login_page.dart';
// import 'package:ocr/providers/auth_provider.dart';
// import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = "/signUp";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  late String _name;
  late String _password='';
  late String _passwordcheck='';
  late String _email;
  late String _phoneNumber;
  late int? res;

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
        if(_password!=_passwordcheck){
          print(_passwordcheck);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("비밀번호가 일치하지 않습니다."),
              duration: Duration(seconds: 1),
            ),
          );
        }
        else{
          res = await signUp(_email, _password,_name, _phoneNumber);
          switch(res) {
            case 200:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("가입이 완료되었습니다. 로그인을 진행해주세요."),
                  duration: Duration(seconds: 1),
                ),
              );
              Navigator.of(context).pop();
              break;
            case 201:
              _showErrorDialog("모든 항목을 입력해주세요.");
              break;
            case 202:
              _showErrorDialog("이미 가입된 이메일입니다.");
              break;
            case 203:
              _showErrorDialog("오류");
              break;
            default:
              break;
          }
        }
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
                    "영문, 숫자, 특수문자를 1개 이상 조합하여 8자리 이상을 입력해주세요.",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  margin: EdgeInsets.only(bottom: 8),
                ),
                Container(
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
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
                    onSaved: (value) {
                      _passwordcheck = value!;
                    },

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
                    _submit();

                    //Navigator.of(context).pushNamed(LoginPage.routeName);

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
// }

signUp(String? _email, String? _password, String? _name, String? _phoneNumber) async {
  Dio dio = new Dio();
  try {
    Response response = await dio.post(
        'http://211.107.210.141:3001/users/signup/',
        data: {
          'email' : _email,
          'password' : _password,
          'name' : _name,
          'phone' : _phoneNumber
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
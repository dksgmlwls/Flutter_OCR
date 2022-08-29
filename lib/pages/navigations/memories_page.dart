import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocr/providers/auth_provider.dart';
import 'package:provider/provider.dart';

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
  final formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text("가입 시 등록하신 휴대폰 번호를 입력해주세요.\n이메일 주소를 알려드립니다."),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                "휴대폰 번호",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              margin: EdgeInsets.only(bottom: 10),
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: "(예시) 01012341234",
              ),
              onSaved: (value) {

              },
              validator: (value) {
                if (value!.length < 10) {
                  return "휴대폰 번호는 10자 이상입니다.";
                }
              },
            ),
            SizedBox(height: 20),
            FlatButton(
              child: Container(
                height: 40,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Text("아이디 찾기",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center),
              ),
              onPressed: () {
              },
            ),
            // formKey.currentState!.validate() ? Container() : Container()
          ],
        ),
      ),
    );
  }
}


class FindUserEverybody extends StatefulWidget {
  @override
  _FindUserEverybodyState createState() => _FindUserEverybodyState();
}

class _FindUserEverybodyState extends State<FindUserEverybody> {
  final formKey = GlobalKey<FormState>();
  late String email;
  var _isLoading = false;

  Future<void> _submit() async {
    if (formKey.currentState!.validate() == false) {
      return;
    } else {
      FocusManager.instance.primaryFocus!.unfocus(); // focus 제거
      formKey.currentState!.save();
      try {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<AuthProvider>(context, listen: false)
            .findPassword(email);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext ctx) {
            return AlertDialog(
              content: Text("이메일을 확인해주세요."),
              actions: [
                FlatButton(
                  child: Text("확인"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          },
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            content: Text("입력하신 이메일로 임시 비밀번호가 전송되었습니다."),
            actions: [
              FlatButton(
                child: Text("확인"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text("가입 시 등록하신 이메일 주소를 입력해주세요.\n비밀번호 재설정 링크를 보내드립니다."),
            ),
            SizedBox(height: 20),
            Container(
              child: Text(
                "이메일 주소",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              margin: EdgeInsets.only(bottom: 10),
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: "이메일 주소를 입력해주세요.",
              ),
              onSaved: (value) {
                email = value!;
              },
              validator: (value) {
                if (value!.length < 10) {
                  return "이메일 주소를 입력해주세요.";
                }
              },
            ),
            SizedBox(height: 20),
            FlatButton(
              child: Container(
                height: 40,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: _isLoading
                    ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                )
                    : Text("비밀번호 찾기",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center),
              ),
              onPressed: () {
                _submit();
              },
            ),
            // formKey.currentState!.validate() ? Container() : Container()
          ],
        ),
      ),
    );
  }
}

sendGraph(String? day) async {
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
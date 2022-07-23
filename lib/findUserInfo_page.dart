import 'package:flutter/material.dart';
import 'package:ocr/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class FindUserInfoPage extends StatefulWidget {
  static const routeName = '/find-user';

  @override
  _FindUserInfoPageState createState() => _FindUserInfoPageState();
}

class _FindUserInfoPageState extends State<FindUserInfoPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "아이디ㆍ비밀번호 찾기",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          bottom: TabBar(
            labelColor: Colors.black,
            tabs: <Widget>[
              Tab(text: "아이디"),
              Tab(text: "비밀번호"),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            FindUserId(),
            FindUserPW(),
          ],
        ),
      ),
    );
  }
}

class FindUserId extends StatefulWidget {
  @override
  _FindUserIdState createState() => _FindUserIdState();
}

class _FindUserIdState extends State<FindUserId> {
  final formKey = GlobalKey<FormState>();
  String? email = "";
  late String phoneNumber;

  Future<void> _submit() async {
    if (formKey.currentState!.validate() == false) {
      return;
    } else {
      FocusManager.instance.primaryFocus!.unfocus(); // focus 제거
      formKey.currentState!.save();
      try {
        await Provider.of<AuthProvider>(context, listen: false)
            .findId(phoneNumber);
      } catch (error) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext ctx) {
            return AlertDialog(
              content: Text("회원님의 정보를 찾을 수 없습니다."),
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
        return;
      }
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return AlertDialog(
            content: Text("회원님의 ID는\nk906506@gmail.com입니다."),
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
                phoneNumber = value!;
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


class FindUserPW extends StatefulWidget {
  @override
  _FindUserPWState createState() => _FindUserPWState();
}

class _FindUserPWState extends State<FindUserPW> {
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

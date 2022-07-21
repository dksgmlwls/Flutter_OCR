import 'package:flutter/material.dart';
import 'package:ocr/pages/auths/login_page.dart';
import 'package:ocr/pages/auths/register_page.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  var _pageController = PageController();
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.8,
              width: double.infinity,
              child: PageView(
                onPageChanged: (int currentIndex) {
                  setState(() {
                    _index = currentIndex;
                  });
                },
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                children: <Widget>[

                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.8,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(20.0),
                            child: Image.asset("images/initial_4.png"),
                          ),
                          FlatButton(
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(10.0),
                              //   color: Colors.grey,
                              // ),
                              child: Text(
                                "로그인",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  LoginPage.routeName);
                            },
                          ),
                          FlatButton(
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(10.0),
                              //   color: Colors.lightBlueAccent,
                              // ),
                              child: Text(
                                "회원 가입",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed(SignUpPage.routeName);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
import 'package:flutter/material.dart';
import 'navigations/ExampleCameraOverlay.dart';
import 'navigations/main_page.dart';
import 'navigations/camera_page.dart';
import 'navigations/graph_page.dart';
import 'navigations/memories_page.dart';
import 'navigations/my_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _screen = [
    UseCameraPage(),
    GraphPage(),
    MemoryPage(),
    MyPage()
  ];

  @override
  Widget build(BuildContext context) {
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
            label: '카메라',
            icon: Icon(Icons.aspect_ratio_outlined ),
          ),
          BottomNavigationBarItem(
            label: '그래프',
            icon: Icon(Icons.auto_graph_rounded),
          ),
          BottomNavigationBarItem(
            label: '기록',
            icon: Icon(Icons.chat),
          ),
          BottomNavigationBarItem(
            label: '내 정보',
            icon: Icon(Icons.assignment_ind_outlined),
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

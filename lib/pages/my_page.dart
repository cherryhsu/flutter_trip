import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final PageController _controller = PageController(
    initialPage: 0, //初始状态下显示第0个tab
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('我的'),
    ));
  }
}

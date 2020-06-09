import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController(
    initialPage: 0, //初始状态下显示第0个tab
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('首页'),
    ));
  }
}

import 'package:flutter/material.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  final PageController _controller = PageController(
    initialPage: 0, //初始状态下显示第0个tab
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('旅拍'),
    ));
  }
}

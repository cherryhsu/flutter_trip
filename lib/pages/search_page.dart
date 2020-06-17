import 'package:flutter/material.dart';
import 'package:fluttertripstudy/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final PageController _controller = PageController(
    initialPage: 0, //初始状态下显示第0个tab
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
        body: Column(
          children: <Widget>[
            SearchBar(
              hideLeft: true,
              defaultText: 'ces',
              hint: '123',
              leftButtonClick: (){
                Navigator.pop(context);
              },
              onChanged: _onTextChanged,
            )
          ],
        ));
  }
  _onTextChanged(text){

  }
}

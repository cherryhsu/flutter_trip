import 'package:flutter/material.dart';
import 'package:fluttertripstudy/model/grid_nav_model.dart';

class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;

  //@required参数必填
  const GridNav({Key key, @required this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('GridNav');
  }
//
//  @override
//  _GridNavState createState()=>_GridNavState();
}

//class _GridNavState extends State<GridNav>{
//  @override
//  Widget build(BuildContext context) {
//    return Text('GridNav');
//  }
//
//
//}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertripstudy/dao/home_dao.dart';
import 'package:fluttertripstudy/model/common_model.dart';
import 'package:fluttertripstudy/model/grid_nav_model.dart';
import 'package:fluttertripstudy/model/home_model.dart';
import 'package:fluttertripstudy/model/sales_box_model.dart';
import 'package:fluttertripstudy/widget/grid_nav.dart';
import 'package:fluttertripstudy/widget/loading_container.dart';
import 'package:fluttertripstudy/widget/local_nav.dart';
import 'package:fluttertripstudy/widget/sales_box.dart';
import 'package:fluttertripstudy/widget/sub_nav.dart';
import 'package:fluttertripstudy/widget/webview.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController(
    initialPage: 0, //初始状态下显示第0个tab
  );
  double appBarAlpha = 0;
  String resultString = "";
  List<CommonModel> LocalNavList = [];
  List<CommonModel> bannerList = [];
  List<CommonModel> subNavList = [];
  SalesBoxModel salesBoxModel;
  GridNavModel gridNavModel;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _handleRefesh();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingContainer(
        isLoading: _loading,
        child: Scaffold(
            backgroundColor: Color(0xfff2f2f2),
            body: Stack(
              children: <Widget>[
                MediaQuery.removePadding(
                    removeTop: true, //移除顶部padding
                    context: context,
                    child: RefreshIndicator(
                        child: NotificationListener(
                          //监听列表
                          onNotification: (scrollNotification) {
                            if (scrollNotification
                                    is ScrollUpdateNotification &&
                                scrollNotification.depth == 0) {
                              //滚动且是列表滚动的时候,第0个元素 即 ListView
                              _onScroll(scrollNotification.metrics.pixels);
                            }
                          },
                          child: _listView,
                        ),
                        onRefresh: _handleRefesh)),
                Opacity(
                  opacity: appBarAlpha,
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text('首页'),
                      ),
                    ),
                  ),
                )
              ],
            )));
  }

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0; //向上滚动,透明度为0
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    // print(appBarAlpha);
  }

  Future<Null> _handleRefesh() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        LocalNavList = model.localNavList;
        subNavList = model.subNavList;
        bannerList = model.bannerList;
        salesBoxModel = model.salesBox;
        gridNavModel = model.gridNav;
        resultString = json.encode(model.config);
        _loading = false;
      });
    } catch (e) {
      setState(() {
        print(e);
        _loading = false;
      });
    }
    return null;
  }

  Widget get _listView{
    return ListView(
      children: <Widget>[
        Container(
          height: 160,
          child: Swiper(
            itemCount: bannerList.length,
            autoplay: true,
            itemBuilder:
                (BuildContext context, int index) {
              return GestureDetector(
                child: Image.network(
                  bannerList[index].icon,
                  fit: BoxFit.fill,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) {
                            CommonModel model = bannerList[index];
                            return WebView(
                              url: model.url,
                              title: model.title,
                              hideAppBar: model.hideAppBar,
                            );
                          }));
                },
              );
            },
            pagination: SwiperPagination(),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(
            localNavList: LocalNavList,
          ),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
            child: GridNav(gridNavModel: gridNavModel)),
        Padding(
            padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
            child: SubNav(subNavList: subNavList)),
        Padding(
            padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
            child: SalesBox(salesBox: salesBoxModel)),
        Container(
          height: 800,
          child: ListTile(title: Text(resultString)),
        )
      ],
    );
  }
//  _loadData() {
//    HomeDao.fetch()
//        .then((res) => setState(() {
//              resultString = json.encode(res);
//            }))
//        .catchError((e) => setState(() {
//              resultString = e.toString();
//            }));
//  }
}

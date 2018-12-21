import 'package:flutter/material.dart';
import 'package:cctv_news/components/HomeNewsCell.dart';
import 'package:cctv_news/models/NewsModel.dart';
import 'package:dio/dio.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeNewsListPage extends StatefulWidget {
  @override
  HomeNewsListPageState createState() => HomeNewsListPageState();
}

class HomeNewsListPageState extends State<HomeNewsListPage> {
  List<NewsModel> _dataSource = [];
  int _page = 1;
  RefreshController _refreshController;

  Future<Null> requestDataAndReload(bool isPulldown) async {
    isPulldown ? _page = 1 : _page++;
    var models = await requestData(page: _page);
    if (isPulldown) {
      _dataSource.clear();
    }
    print('zhoukang===>$models\n');
    setState(() {
      _dataSource.addAll(models);
    });
    if (isPulldown) {
      _refreshController?.sendBack(false, RefreshStatus?.idle);
      _refreshController.sendBack(true, RefreshStatus.completed);
    } else {
      // _refreshController.sendBack(false, RefreshStatus.completed);
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    requestDataAndReload(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新闻列表'),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: requestDataAndReload,
        child: ListView.builder(
          itemCount: _dataSource.length,
          itemBuilder: (context, index) {
            return HomeNewsCell(
              model: _dataSource[index],
            );
          },
        ),
      ),
    );
  }
}

Future<List<NewsModel>> requestData({@required int page}) async {
  assert(page > 0, '页码必须大于0');
  final String urlString =
      'http://api.cportal.cctv.com/api/rest/navListInfo/getHandDataListInfoNew?id=Nav-9Nwml0dIB6wAxgd9EfZA160510&toutuNum=5&version=1&n=20';
  final fullUrlString = urlString + '&p=$page';
  Dio dio = Dio();
  Response response = await dio.get(fullUrlString);
  Map dataDict = response.data as Map;
  var rawDatas = (dataDict['itemList'] as List);
  var models = rawDatas.map((map) {
    map = map as Map;
    NewsModel model = NewsModel.fromDict(map);
    return model;
  }).toList();
  return models;
}

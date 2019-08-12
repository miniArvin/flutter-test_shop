import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../routers/application.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  String homePageContent = '正在获取数据……';

  int page = 1;
  List<Map> hotGoodsList = [];

  @override
  void initState() {
    super.initState();
//    _getHotGoods();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    return Scaffold(
      appBar: AppBar(
        title: Text("百姓生活+"),
      ),
      body: FutureBuilder(
        future: request('homePageContent', formDatas: formData),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = jsonDecode(snapshot.data.toString());
            List<Map> swiper = (data['data']['slides'] as List).cast();
            List<Map> navigatorList = (data['data']['category'] as List).cast();
            String adImgs = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderImg = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];

            List<Map> recommendList =
                (data['data']['recommend'] as List).cast();

            String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
            String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS'];
            String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS'];
            List<Map> floor1 = (data['data']['floor1'] as List).cast();
            List<Map> floor2 = (data['data']['floor2'] as List).cast();
            List<Map> floor3 = (data['data']['floor3'] as List).cast();

            return EasyRefresh(
                footer: ClassicalFooter(
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  infoColor: Colors.pink,
                  showInfo: true,
                  noMoreText: '',
                  infoText: "加载中……",
                  loadReadyText: '上拉加载……',
                ),
                child: ListView(
                  children: <Widget>[
                    SwiperDiy(swiperDateList: swiper),
                    TopNavigator(
                      navigatorList: navigatorList,
                    ),
                    AdBanner(
                      adImgs: adImgs,
                    ),
                    LeaderPhone(
                      leaderImg: leaderImg,
                      leaderPhone: leaderPhone,
                    ),
                    Recommend(
                      recommendList: recommendList,
                    ),
                    FloorTitle(
                      picture_address: floor1Title,
                    ),
                    FloorContent(
                      floorGoodsList: floor1,
                    ),
                    FloorTitle(
                      picture_address: floor2Title,
                    ),
                    FloorContent(
                      floorGoodsList: floor2,
                    ),
                    FloorTitle(
                      picture_address: floor3Title,
                    ),
                    FloorContent(
                      floorGoodsList: floor3,
                    ),
                    _hotGoods(),
                  ],
                ),
                onLoad: () async {
                  print("开始加载更多……");
                  var formData = {'page': page};
                  await request('homePageBelowConten', formDatas: formData)
                      .then((val) {
                    var data = json.decode(val.toString());
                    List<Map> newGoodsList = (data['data'] as List).cast();
                    setState(() {
                      hotGoodsList.addAll(newGoodsList);
                      page++;
                    });
                  });
                });
          } else {
            return Center(
              child: Text(
                "加载中……",
                style: TextStyle(fontSize: ScreenUtil().setSp(28)),
              ),
            );
          }
        },
      ),
    );
  }

//  void _getHotGoods() {
//    var formData = {'page': page};
//    request('homePageBelowConten', formDatas: formData).then((val) {
//      var data = json.decode(val.toString());
//      List<Map> newGoodsList = (data['data'] as List).cast();
//      setState(() {
//        hotGoodsList.addAll(newGoodsList);
//        page++;
//      });
//    });
//  }

  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Text(
      '火爆专区',
      style: TextStyle(fontSize: 17),
    ),
  );

  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
          onTap: () {
            Application.router
                .navigateTo(context, '/detail?id=${val['goodsId']}');
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  val['image'],
                  width: ScreenUtil().setWidth(370),
                ),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                ),
                Row(
                  children: <Widget>[
                    Text('￥${val['mallPrice']}'),
                    Text(
                      '￥${val['price']}',
                      style: TextStyle(
                          color: Colors.black12,
                          decoration: TextDecoration.lineThrough),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }

  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[
          hotTitle,
          _wrapList(),
        ],
      ),
    );
  }
}

class SwiperDiy extends StatelessWidget {
  final List swiperDateList;

  SwiperDiy({this.swiperDateList});

  @override
  Widget build(BuildContext context) {
    print('设备的像素密度：${ScreenUtil.pixelRatio}');
    print('设备的高：${ScreenUtil.screenHeight}');
    print('设备的宽：${ScreenUtil.screenWidth}');
    return Container(
      height: ScreenUtil().setHeight(333),
      width: double.infinity,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              onTap: () {
                Application.router.navigateTo(
                    context, '/detail?id=${swiperDateList[index]['goodsId']}');
              },
              child: Image.network("${swiperDateList[index]['image']}"));
        },
        itemCount: swiperDateList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

class TopNavigator extends StatelessWidget {
  final List navigatorList;

  const TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(
            item['mallCategoryName'],
            style: TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, navigatorList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5, //每行
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

class AdBanner extends StatelessWidget {
  final String adImgs;

  const AdBanner({Key key, this.adImgs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adImgs),
    );
  }
}

class LeaderPhone extends StatelessWidget {
  final String leaderImg;
  final String leaderPhone;

  const LeaderPhone({Key key, this.leaderImg, this.leaderPhone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          launchURL();
        },
        child: Image.network(leaderImg),
      ),
    );
  }

  void launchURL() async {
    String url = 'tel:' + leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'url不能进行访问，异常';
    }
  }
}

class Recommend extends StatelessWidget {
  final List recommendList;

  const Recommend({Key key, this.recommendList}) : super(key: key);

  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 2, 0, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12)),
      ),
      child: Text(
        "商店推荐",
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  //商品单独项方法
  Widget _item(index,context) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(
            context, '/detail?id=${recommendList[index]['goodsId']}');
      },
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 0.5, color: Colors.black12),
          ),
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['mallPrice']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //横向列表方法
  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(360),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(index,context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.only(
        top: 10,
      ),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommendList(),
        ],
      ),
    );
  }
}

//楼层标题
class FloorTitle extends StatelessWidget {
  final String picture_address;

  const FloorTitle({Key key, this.picture_address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Image.network(picture_address),
    );
  }
}

//楼层商品
class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  const FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(context),
          _otherGoods(context),
        ],
      ),
    );
  }

  Widget _firstRow(context) {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[0],context),
        Column(
          children: <Widget>[
            _goodsItem(floorGoodsList[1],context),
            _goodsItem(floorGoodsList[2],context),
          ],
        ),
      ],
    );
  }

  Widget _otherGoods(context) {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoodsList[3],context),
        _goodsItem(floorGoodsList[4],context),
      ],
    );
  }

  Widget _goodsItem(Map goods,context) {
    return Container(
      width: ScreenUtil().setHeight(375),
      child: InkWell(
        onTap: () {
          Application.router.navigateTo(context, '/detail?id=${goods['goodsId']}');
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}

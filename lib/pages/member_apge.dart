import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: ListView(
        children: <Widget>[
          _topHead(),
          _mineOrder(),
          _orderType(),
          _listTitleCont(),
        ],
      ),
    );
  }

  Widget _topHead() {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.black12,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            height: ScreenUtil().setHeight(200),
            child: ClipOval(//圆形头像
              child: Image.network(
                  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1566314427226&di=a241e14c16e1f45af9e83e31daeed580&imgtype=0&src=http%3A%2F%2Fmmbiz.qpic.cn%2Fmmbiz_png%2FlENC1DRZ3Nm97ea86ibBeicokGiatIJWjV9PaCCniaOKUrIhfsL3bRfvmb9fny5hWC6yK40MhF4BECxDtUL7CPJGvQ%2F640%3Fwx_fmt%3Dpng'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              'miniArvin',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(36), color: Colors.black54),
            ),
          )
        ],
      ),
    );
  }

  Widget _mineOrder(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1,color: Colors.black12)
        )
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  Widget _orderType(){
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.party_mode,
                  size: 30,
                ),
                Text('待付款'),
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.query_builder,
                  size: 30,
                ),
                Text('待发货'),
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.directions_car,
                  size: 30,
                ),
                Text('待收货'),
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.content_paste,
                  size: 30,
                ),
                Text('待评价'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //通用listTile
  Widget _mineListTile(String title){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1,color: Colors.black12),
        ),
      ),
      child: ListTile(
        leading: Icon(Icons.blur_circular),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  Widget _listTitleCont(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _mineListTile('领取优惠券'),
          _mineListTile('已领取优惠券'),
          _mineListTile('地址管理'),
          _mineListTile('客服电话'),
          _mineListTile('关于我们'),
        ],
      ),
    );
  }
}

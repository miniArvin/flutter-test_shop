import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsExplain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(10),
      child: Text(
        '说明：> 极速送达 > 正品保证',
        style: TextStyle(color: Colors.redAccent,fontSize: ScreenUtil().setSp(30)),
      ),
    );
  }
}

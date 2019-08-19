import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/cartInfo.dart';
import '../cart_page/cart_count.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';

class CartItem extends StatelessWidget {
  final CartInfoModel item;

  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
//    print(item.images);
    return Container(
      margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: <Widget>[
          _cartCheckBtn(item, context),
          _cartImage(item),
          _cartGoodsName(item),
          _cartGoodsPrice(item,context),
        ],
      ),
    );
  }

  //多选按钮
  Widget _cartCheckBtn(item, context) {
    return Container(
      alignment: Alignment.center,
      child: Checkbox(
          value: item.isCheck,
          activeColor: Colors.pink,
          onChanged: (bool val) {
            item.isCheck = val;
            Provide.value<CartProvide>(context).changeCheckState(item);
          }),
    );
  }

  //商品图片
  Widget _cartImage(item) {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Image.network(item.images),
    );
  }

  //商品名称
  Widget _cartGoodsName(item) {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.goodsName),
          Container(
            alignment: Alignment.centerLeft,
            child: CartCount(item),
          ),
        ],
      ),
    );
  }

  //商品价格
  Widget _cartGoodsPrice(item,context) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${item.price}'),
          Container(
            child: InkWell(
              onTap: () {
                Provide.value<CartProvide>(context).deleteOneGoods(item.goodsId);
              },
              child: Icon(
                Icons.delete_forever,
                color: Colors.black26,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}

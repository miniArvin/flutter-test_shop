import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/index_page.dart';
import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';
import './provide/details_info.dart';
import './provide/cart.dart';
import 'package:fluro/fluro.dart';
import './routers/routers.dart';
import './routers/application.dart';
import './provide/current_index.dart';

void main() {
  var counter = Counter();
  var childCategory = ChildCategory();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var detailsInfoProvide = DetailsInfoProvide();
  var cartProvide = CartProvide();
  var currentIndexProvide = CurrentIndexProvide();
  var providers = Providers();

  providers..provide(Provider<Counter>.value(counter))
  ..provide(Provider<ChildCategory>.value(childCategory))
  ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
  ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide))
  ..provide(Provider<CartProvide>.value(cartProvide))
  ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final router = Router();
    Routers.configureRouters(router);
    Application.router = router;
    return Container(
      child: MaterialApp(
        title: "百姓生活+",
        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false, //去掉debug图标
        theme: ThemeData(
          primaryColor: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}

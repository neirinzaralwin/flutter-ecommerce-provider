import 'package:ecommerce_app/providers/bag_list.dart';
import 'package:ecommerce_app/providers/shop_card_list.dart';
import 'package:ecommerce_app/providers/total_price.dart';
import 'package:ecommerce_app/screens/bottom_bar.dart';
import 'package:ecommerce_app/screens/shopcard/shop_card_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider<ShopCardList, ShopCardListState>(
            create: (context) => ShopCardList()),
        StateNotifierProvider<BagList, BagListState>(
            create: (context) => BagList()),
        StateNotifierProvider<TotalPrice, TotalPriceState>(
            create: (context) => TotalPrice()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Daw Kyee Rone',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BottomBar(),
        routes: {
          'bottombar': (context) => BottomBar(),
          'shopcard': (context) => ShopCardPage(),
        },
      ),
    );
  }
}

import 'package:badges/badges.dart';
import 'package:ecommerce_app/providers/bag_list.dart';
import 'package:ecommerce_app/providers/shop_card_list.dart';
import 'package:ecommerce_app/screens/home/home_page.dart';
import 'package:ecommerce_app/screens/settings/setting_page.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  GlobalKey<_BottomBarState> _bottombarkey = new GlobalKey();

  int _currentIndex = 0;
  List<Widget> pages = const [
    HomePage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ShopCardListState>().productList;

    return Scaffold(
      key: _bottombarkey,
      appBar: AppBar(
        backgroundColor: scaffoldBackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'ECOMMERCE',
          style: TextStyle(
            fontSize: 20.0,
            color: Color(0xFF545D68),
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'shopcard');
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Badge(
                position: BadgePosition.topEnd(top: 5, end: -10),
                showBadge: (products.length > 0) ? true : false,
                badgeContent: Text(
                  '${products.length}',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
                child: Icon(
                  Icons.shopping_bag_outlined,
                  color: Color(0xFF545D68),
                ),
              ),
            ),
          )
        ],
      ),
      body: Center(child: pages[_currentIndex]),
      bottomNavigationBar: NavigationBar(
        height: 60,
        backgroundColor: scaffoldBackgroundColor,
        animationDuration: const Duration(seconds: 1),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _currentIndex,
        onDestinationSelected: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            selectedIcon: Icon(Icons.home),
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.settings),
            label: 'Settings',
            selectedIcon: Icon(CupertinoIcons.settings_solid),
          ),
        ],
      ),
    );
  }
}

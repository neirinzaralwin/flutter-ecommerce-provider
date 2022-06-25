import 'package:ecommerce_app/screens/home/home_page.dart';
import 'package:ecommerce_app/screens/shopcard/shop_card_page.dart';
import 'package:flutter/material.dart';

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
    ShopCardPage(),
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _bottombarkey,
      appBar: _appbar,
      body: Center(child: pages[_currentIndex]),
      bottomNavigationBar: NavigationBar(
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
            icon: Icon(Icons.shop_outlined),
            label: 'My Card',
            selectedIcon: Icon(Icons.shop),
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
            selectedIcon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }

  get _appbar {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Color(0xFF545D68),
        ),
        onPressed: () {},
      ),
      title: const Text(
        'Daw Kyee Rone',
        style: TextStyle(
          fontFamily: 'Varela',
          fontSize: 20.0,
          color: Color(0xFF545D68),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.shopping_bag_outlined,
            color: Color(0xFF545D68),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

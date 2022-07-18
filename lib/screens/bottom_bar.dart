import 'package:ecommerce_app/screens/home/home_page.dart';
import 'package:ecommerce_app/screens/settings/setting_page.dart';
import 'package:flutter/cupertino.dart';
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
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _bottombarkey,
      appBar: _appbar,
      body: Center(child: pages[_currentIndex]),
      bottomNavigationBar: NavigationBar(
        height: 60,
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

  get _appbar {
    return AppBar(
      backgroundColor: Colors.white,
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
        IconButton(
          icon: const Icon(
            Icons.shopping_bag_outlined,
            color: Color(0xFF545D68),
          ),
          onPressed: () {
            Navigator.pushNamed(context, 'shopcard');
          },
        ),
      ],
    );
  }
}

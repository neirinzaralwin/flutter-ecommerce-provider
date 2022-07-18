import 'dart:async';

import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/models/notification_permission.dart';
import 'package:ecommerce_app/models/storage_permission.dart';
import 'package:ecommerce_app/providers/all_permissions.dart';
import 'package:ecommerce_app/providers/bag_list.dart';
import 'package:ecommerce_app/providers/shop_card_list.dart';
import 'package:ecommerce_app/providers/total_price.dart';
import 'package:ecommerce_app/screens/bottom_bar.dart';
import 'package:ecommerce_app/screens/loading/loading_page.dart';
import 'package:ecommerce_app/screens/login/login_page.dart';
import 'package:ecommerce_app/screens/login/phone_page.dart';
import 'package:ecommerce_app/screens/permission/permission_page.dart';
import 'package:ecommerce_app/screens/settings/setting_page.dart';
import 'package:ecommerce_app/screens/shopcard/shop_card_page.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var permission;
  bool isLoading = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    get_shared_preference();
  }

  Future<void> get_shared_preference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      permission = prefs.getString('permission');
    });
    _timer = Timer(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
    print('>> got shared preference');
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

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
        StateNotifierProvider<NotificationPermission,
                NotificationPermissionState>(
            create: (context) => NotificationPermission()),
        StateNotifierProvider<StoragePermission, StoragePermissionState>(
            create: (context) => StoragePermission()),
        StateNotifierProvider<AllPermission, AllPermissionState>(
            create: (context) => AllPermission()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecommerce',
        theme: ThemeData(
          primaryColor: primaryColor,
          primarySwatch: Colors.brown,
        ),
        home: isLoading
            ? LoadingPage()
            : (permission == 'Granted')
                ? BottomBar()
                : PermissionPage(),
        routes: {
          'bottombar': (context) => BottomBar(),
          'shopcard': (context) => ShopCardPage(),
          'login': (context) => LoginPage(),
          'settings': (context) => SettingPage(),
          'phone': (context) => PhonePage(),
        },
      ),
    );
  }
}

import 'package:ecommerce_app/models/notification_permission.dart';
import 'package:ecommerce_app/models/storage_permission.dart';
import 'package:ecommerce_app/providers/all_permissions.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermissionPage extends StatefulWidget {
  const PermissionPage({Key? key}) : super(key: key);

  @override
  State<PermissionPage> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    context.read<NotificationPermission>().checkNotificationPermission();
    context.read<StoragePermission>().checkStoragePermission();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      context.read<NotificationPermission>().checkNotificationPermission();
      context.read<StoragePermission>().checkStoragePermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentNotificationStatus =
        context.watch<NotificationPermissionState>().notificationStatus;
    final currentStorageStatus =
        context.watch<StoragePermissionState>().storageStatus;
    final currentPermissionStatus =
        context.watch<AllPermissionState>().permissionStatus;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * .1),
              child: Text(
                'Welcome to Ecommerce',
                style: TextStyle(
                  color: Colors.black.withOpacity(.7),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  wordSpacing: 4,
                ),
              ),
            ),

            //*  --- Notification Permisssion
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Notification Permission',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Row(
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Notification Permission will be used when one time password is recieved",
                    style: TextStyle(color: Colors.black.withOpacity(0.5)),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    context.read<NotificationPermission>().requestPermission();
                  },
                  child: (currentNotificationStatus ==
                          NotificationStatus.permissionGranted)
                      ? Icon(Icons.check, color: Colors.green)
                      : Text('Allow'),
                  style: ElevatedButton.styleFrom(
                      primary: (currentNotificationStatus ==
                              NotificationStatus.permissionGranted)
                          ? Colors.white70
                          : primaryColor,
                      textStyle: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ],
            ),

            SizedBox(height: 20),

            //*  --- Storage Permisssion
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Storage Permission',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Row(
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Expanded(
                  child: Text(
                    "To save photos and download voucher from this application.",
                    style: TextStyle(color: Colors.black.withOpacity(0.5)),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    context.read<StoragePermission>().requestPermission();
                  },
                  child:
                      (currentStorageStatus == StorageStatus.permissionGranted)
                          ? Icon(Icons.check, color: Colors.green)
                          : Text('Allow'),
                  style: ElevatedButton.styleFrom(
                      primary: (currentStorageStatus ==
                              StorageStatus.permissionGranted)
                          ? Colors.white70
                          : primaryColor,
                      textStyle: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ],
            ),

            SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: primaryColor,
                minimumSize: const Size.fromHeight(50), // NEW
              ),
              onPressed: (currentPermissionStatus == PermissionStatus.isGranted)
                  ? () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('permission', 'Granted');
                      Navigator.pushReplacementNamed(context, 'login');
                    }
                  : null,
              child: const Text(
                'Continue',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

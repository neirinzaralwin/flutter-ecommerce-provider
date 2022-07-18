// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:state_notifier/state_notifier.dart';

enum NotificationStatus {
  noNotificationPermission,
  noNotificationPermissionPermanent,
  permissionGranted,
}

class NotificationPermissionState extends Equatable {
  final NotificationStatus notificationStatus;

  NotificationPermissionState({
    required this.notificationStatus,
  });

  @override
  List<Object> get props => [notificationStatus];

  @override
  bool get stringify => true;

  NotificationPermissionState copyWith({
    NotificationStatus? notificationStatus,
  }) {
    return NotificationPermissionState(
      notificationStatus: notificationStatus ?? this.notificationStatus,
    );
  }
}

class NotificationPermission
    extends StateNotifier<NotificationPermissionState> {
  NotificationPermission()
      : super(NotificationPermissionState(
            notificationStatus: NotificationStatus.noNotificationPermission));

  void changeNotificationStatus(NotificationStatus newStatus) {
    state = state.copyWith(notificationStatus: newStatus);
  }

  void requestPermission() async {
    var notistatus = await Permission.notification.status;
    if (notistatus.isDenied) {
      var result = await Permission.notification.request();
      if (!result.isGranted) {
        openAppSettings();
      } else {
        print('notification permission granted!');
      }
    } else if (notistatus.isPermanentlyDenied) {
      openAppSettings();
    }

    checkNotificationPermission();
  }

  void checkNotificationPermission() async {
    if (await Permission.notification.isGranted) {
      changeNotificationStatus(NotificationStatus.permissionGranted);
      print('notification permission granted!');
    } else if (await Permission.notification.isDenied) {
      changeNotificationStatus(
          NotificationStatus.noNotificationPermissionPermanent);
      print('notification permission permanently denied!');
    } else {
      changeNotificationStatus(NotificationStatus.noNotificationPermission);
      print('notification permission denied!');
    }
  }
}

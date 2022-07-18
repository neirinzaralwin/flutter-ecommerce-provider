// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:state_notifier/state_notifier.dart';

enum StorageStatus {
  noStoragePermission,
  noStoragePermissionPermanent,
  permissionGranted,
}

class StoragePermissionState extends Equatable {
  final StorageStatus storageStatus;

  StoragePermissionState({
    required this.storageStatus,
  });

  @override
  List<Object> get props => [storageStatus];

  @override
  bool get stringify => true;

  StoragePermissionState copyWith({
    StorageStatus? storageStatus,
  }) {
    return StoragePermissionState(
      storageStatus: storageStatus ?? this.storageStatus,
    );
  }
}

class StoragePermission extends StateNotifier<StoragePermissionState> {
  StoragePermission()
      : super(StoragePermissionState(
            storageStatus: StorageStatus.noStoragePermission));

  void changeNotificationStatus(StorageStatus newStatus) {
    state = state.copyWith(storageStatus: newStatus);
  }

  void requestPermission() async {
    var stostatus = await Permission.storage.status;
    if (stostatus.isDenied) {
      var result = await Permission.storage.request();
      if (!result.isGranted) {
        openAppSettings();
      } else {
        print('storage permission granted!');
      }
    } else if (stostatus.isPermanentlyDenied) {
      openAppSettings();
    }

    checkStoragePermission();
  }

  void checkStoragePermission() async {
    if (await Permission.storage.isGranted) {
      changeNotificationStatus(StorageStatus.permissionGranted);
      print('storage permission granted!');
    } else if (await Permission.storage.isDenied) {
      changeNotificationStatus(StorageStatus.noStoragePermissionPermanent);
      print('storage permission permanently denied!');
    } else {
      changeNotificationStatus(StorageStatus.noStoragePermission);
      print('storage permission denied!');
    }
  }
}

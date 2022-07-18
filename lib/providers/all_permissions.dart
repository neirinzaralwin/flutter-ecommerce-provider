// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/models/notification_permission.dart';
import 'package:ecommerce_app/models/storage_permission.dart';
import 'package:equatable/equatable.dart';
import 'package:state_notifier/state_notifier.dart';

enum PermissionStatus {
  isGranted,
  isDenied,
}

class AllPermissionState extends Equatable {
  final PermissionStatus permissionStatus;
  AllPermissionState({
    required this.permissionStatus,
  });

  @override
  List<Object> get props => [permissionStatus];

  @override
  bool get stringify => true;

  AllPermissionState copyWith({
    PermissionStatus? permissionStatus,
  }) {
    return AllPermissionState(
      permissionStatus: permissionStatus ?? this.permissionStatus,
    );
  }
}

class AllPermission extends StateNotifier<AllPermissionState>
    with LocatorMixin {
  AllPermission()
      : super(AllPermissionState(permissionStatus: PermissionStatus.isDenied));

  @override
  void update(Locator watch) {
    final notificationStatus =
        watch<NotificationPermissionState>().notificationStatus;
    final storageStatus = watch<StoragePermissionState>().storageStatus;

    if (notificationStatus == NotificationStatus.permissionGranted &&
        storageStatus == StorageStatus.permissionGranted) {
      state = state.copyWith(permissionStatus: PermissionStatus.isGranted);
    } else {
      state = state.copyWith(permissionStatus: PermissionStatus.isDenied);
    }

    super.update(watch);
  }
}

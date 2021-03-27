import 'package:permission_handler/permission_handler.dart';

class CheckPermissionHandler {
  Future checkPermission() async {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> status = await [
      Permission.location,
      Permission.storage,
      Permission.camera,
      Permission.location,
      Permission.notification,
      Permission.mediaLibrary
    ].request();
    return status[[Permission.mediaLibrary]];
  }
}

final permissionHandler = CheckPermissionHandler();

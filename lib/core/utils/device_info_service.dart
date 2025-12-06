import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<String> getDeviceId() async {
    if (Platform.isAndroid) {
      final android = await _deviceInfo.androidInfo;
      return android.id;
    } else if (Platform.isIOS) {
      final ios = await _deviceInfo.iosInfo;
      return ios.identifierForVendor ?? '';
    }
    return '';
  }
}

final deviceInfoServiceProvider = Provider<DeviceInfoService>((ref) {
  return DeviceInfoService();
});

final deviceIdProvider = FutureProvider<String>((ref) async {
  final service = ref.watch(deviceInfoServiceProvider);
  return service.getDeviceId();
});

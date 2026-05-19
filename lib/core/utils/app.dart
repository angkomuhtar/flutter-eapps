import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

String getSleepDuration(DateTime start, DateTime end) {
  final duration = end.difference(start);
  return '${duration.inHours}j ${duration.inMinutes.remainder(60)}m';
}

String getSleepHours(DateTime start, DateTime end) {
  final duration = end.difference(start);
  return '${duration.inHours}';
}

String getSleepMinutes(DateTime start, DateTime end) {
  final duration = end.difference(start);
  return '${duration.inMinutes.remainder(60)}';
}

String getErrorMessage(int statusCode) {
  return switch (statusCode) {
    400 => 'Data yang dikirim tidak valid',
    401 => 'Sesi telah berakhir, silakan login kembali',
    403 => 'Anda tidak memiliki akses untuk fitur ini',
    404 => 'Layanan tidak ditemukan',
    413 => 'Ukuran file terlalu besar',
    422 => 'Data tidak lengkap atau format salah',
    500 => 'Terjadi kesalahan pada server',
    502 => 'Server sedang tidak tersedia',
    503 => 'Server sedang dalam pemeliharaan',
    _ => 'Terjadi kesalahan, silakan coba lagi',
  };
}

Future<bool> requestStoragePermission() async {
  // Android 13+ (SDK 33+) — tidak perlu permission untuk simpan ke app folder
  if (Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;

    if (androidInfo.version.sdkInt >= 33) {
      // Tidak perlu permission untuk simpan ke getExternalFilesDir
      return true;
    } else if (androidInfo.version.sdkInt >= 30) {
      // Android 11-12 — tidak perlu permission untuk app-specific storage
      return true;
    } else {
      // Android < 11 — perlu WRITE_EXTERNAL_STORAGE
      final status = await Permission.storage.request();
      return status.isGranted;
    }
  }
  return true;
}

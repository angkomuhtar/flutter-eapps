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

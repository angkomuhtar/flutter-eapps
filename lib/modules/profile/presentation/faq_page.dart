import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:gap/gap.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Pertanyaan Umum (FAQ)',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.help_outline, color: AppColors.primary, size: 28),
                  const Gap(12),
                  Expanded(
                    child: Text(
                      'Temukan jawaban untuk pertanyaan yang sering diajukan',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(16),
            _buildCategoryHeader('Umum'),
            _buildFaqItem(
              question: 'Bagaimana cara login ke aplikasi?',
              answer:
                  'Username dan password yang telah diberikan oleh tim HR. Jika belum memiliki akun atau lupa password, silakan hubungi tim HR untuk bantuan.',
            ),
            _buildFaqItem(
              question: 'Apa yang harus dilakukan jika lupa password?',
              answer:
                  'Anda dapat menghubungi tim HR atau IT Support untuk melakukan reset password. Pastikan Anda memberikan informasi identitas yang valid untuk verifikasi keamanan.',
            ),
            _buildFaqItem(
              question: 'Apakah aplikasi bisa digunakan offline?',
              answer:
                  'Beberapa fitur memerlukan koneksi internet seperti absensi dengan GPS, submit laporan, dan sinkronisasi data. Namun Anda tetap bisa melihat data yang sudah tersimpan di lokal.',
            ),
            const Gap(16),
            _buildCategoryHeader('Absensi'),
            _buildFaqItem(
              question: 'Bagaimana cara melakukan absensi?',
              answer:
                  'Buka menu Absensi, pastikan GPS dan lokasi perangkat Anda aktif, lalu tekan tombol Check-In saat tiba di kantor dan Check-Out saat pulang. Pastikan Anda berada di area yang ditentukan.',
            ),
            _buildFaqItem(
              question: 'Mengapa absensi saya gagal?',
              answer:
                  'Absensi bisa gagal karena beberapa alasan:\n\n• GPS perangkat tidak aktif\n• Berada di luar radius lokasi yang ditentukan\n• Koneksi internet tidak stabil\n• Waktu perangkat tidak sinkron\n• Menggunakan Applikasi Lokasi Palsu\n\nPastikan semua persyaratan terpenuhi sebelum melakukan absensi.',
            ),
            _buildFaqItem(
              question: 'Apakah saya bisa absen jika lupa check-in/check-out?',
              answer:
                  'Jika lupa melakukan check-in atau check-out, segera hubungi atasan atau tim HR untuk melakukan koreksi absensi dengan menyertakan bukti pendukung seperti foto atau keterangan yang valid.',
            ),
            _buildFaqItem(
              question: 'Bagaimana cara melihat riwayat absensi?',
              answer:
                  'Buka menu Absensi, lalu pilih "Riwayat Absensi". Anda dapat melihat data absensi harian, mingguan, atau bulanan beserta detail waktu check-in dan check-out.',
            ),
            const Gap(16),
            _buildCategoryHeader('Cuti dan Izin'),
            _buildFaqItem(
              question: 'Bagaimana cara mengajukan cuti?',
              answer:
                  'Buka menu Cuti, pilih "Ajukan Cuti", isi formulir dengan lengkap (jenis cuti, tanggal, alasan), upload dokumen pendukung jika diperlukan, lalu submit. Anda akan mendapat notifikasi status persetujuan.',
            ),
            _buildFaqItem(
              question: 'Berapa lama proses persetujuan cuti?',
              answer:
                  'Proses persetujuan cuti biasanya memakan waktu 1-3 hari kerja tergantung kebijakan perusahaan dan ketersediaan atasan. Anda dapat memantau status pengajuan di menu Riwayat Cuti.',
            ),
            _buildFaqItem(
              question: 'Apakah saya bisa membatalkan pengajuan cuti?',
              answer:
                  'Anda dapat membatalkan pengajuan cuti selama masih berstatus "Menunggu Persetujuan". Jika sudah disetujui, hubungi atasan atau tim HR untuk proses pembatalan.',
            ),
            const Gap(16),
            _buildCategoryHeader('Hazard & Inspeksi'),
            _buildFaqItem(
              question: 'Apa itu Hazard Report?',
              answer:
                  'Hazard Report adalah fitur untuk melaporkan potensi bahaya atau kondisi tidak aman di lingkungan kerja. Tujuannya untuk mencegah kecelakaan kerja dan meningkatkan K3 (Kesehatan dan Keselamatan Kerja).',
            ),
            _buildFaqItem(
              question: 'Bagaimana cara melaporkan hazard?',
              answer:
                  'Buka menu Hazard Report, tekan tombol "Tambah Laporan", isi detail temuan (lokasi, jenis bahaya, tingkat risiko), upload foto sebagai bukti, lalu submit. Tim terkait akan menindaklanjuti laporan Anda.',
            ),
            _buildFaqItem(
              question: 'Apa perbedaan Hazard Report dan Inspection?',
              answer:
                  'Hazard Report digunakan untuk melaporkan bahaya yang ditemukan secara insidental. Sedangkan Inspection adalah pemeriksaan rutin dan terjadwal untuk memastikan standar keselamatan kerja terpenuhi.',
            ),
            const Gap(16),
            _buildCategoryHeader('Sleep Duration'),
            _buildFaqItem(
              question: 'Mengapa harus melapor durasi tidur?',
              answer:
                  'Monitoring durasi tidur penting untuk memastikan karyawan cukup istirahat, terutama bagi yang bekerja di posisi yang memerlukan konsentrasi tinggi atau mengoperasikan alat berat untuk keselamatan kerja.',
            ),
            _buildFaqItem(
              question: 'Bagaimana cara mencatat durasi tidur?',
              answer:
                  'Buka menu Sleep Duration, pilih tanggal, masukkan jam tidur dan jam bangun, sistem akan otomatis menghitung durasi. Anda juga bisa menambahkan catatan jika ada gangguan tidur.',
            ),
            const Gap(16),
            _buildCategoryHeader('Keamanan & Privasi'),
            _buildFaqItem(
              question: 'Apakah data saya aman?',
              answer:
                  'Ya, data Anda dilindungi dengan enkripsi standar industri dan hanya dapat diakses oleh pihak berwenang. Kami berkomitmen menjaga privasi dan keamanan data sesuai kebijakan privasi yang berlaku.',
            ),
            _buildFaqItem(
              question: 'Siapa saja yang bisa melihat data saya?',
              answer:
                  'Data Anda hanya dapat diakses oleh:\n\n• Anda sendiri\n• Atasan langsung (untuk approval)\n• Tim HR (untuk administrasi)\n• Tim terkait sesuai kebutuhan operasional\n\nSemua akses dicatat dan diaudit secara berkala.',
            ),
            const Gap(16),
            _buildCategoryHeader('Notifikasi'),
            _buildFaqItem(
              question: 'Mengapa saya tidak menerima notifikasi?',
              answer:
                  'Pastikan:\n\n• Notifikasi aplikasi diaktifkan di pengaturan perangkat\n• Koneksi internet stabil\n• Aplikasi dalam versi terbaru\n• Tidak ada pembatasan baterai yang memblokir notifikasi\n\nJika masih bermasalah, coba logout dan login kembali.',
            ),
            _buildFaqItem(
              question: 'Notifikasi apa saja yang akan saya terima?',
              answer:
                  'Anda akan menerima notifikasi untuk:\n\n• Pengingat absensi\n• Status persetujuan cuti/izin\n• Follow-up hazard report\n• Pengumuman penting perusahaan\n• Reminder pengisian sleep duration\n• Update dari atasan atau HR',
            ),
            const Gap(16),
            _buildCategoryHeader('Troubleshooting'),
            _buildFaqItem(
              question:
                  'Aplikasi error atau force close, apa yang harus dilakukan?',
              answer:
                  'Coba langkah berikut:\n\n1. Tutup dan buka kembali aplikasi\n2. Clear cache aplikasi di pengaturan perangkat\n3. Pastikan aplikasi sudah versi terbaru\n4. Restart perangkat\n5. Uninstall dan install ulang aplikasi\n\nJika masih bermasalah, hubungi IT Support dengan menyertakan screenshot error.',
            ),
            _buildFaqItem(
              question: 'GPS tidak akurat, bagaimana solusinya?',
              answer:
                  'Untuk meningkatkan akurasi GPS:\n\n• Aktifkan High Accuracy Mode di pengaturan lokasi\n• Pastikan berada di area terbuka, bukan di dalam gedung\n• Restart GPS dengan mematikan dan menghidupkan kembali\n• Kalibrasi kompas perangkat dengan menggerakkan angka 8\n• Update Google Play Services',
            ),
            const Gap(16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(Icons.support_agent, color: AppColors.primary, size: 48),
                  const Gap(12),
                  Text(
                    'Masih Ada Pertanyaan?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    'Hubungi tim support kami untuk bantuan lebih lanjut',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email, size: 16, color: AppColors.primary),
                      const Gap(6),
                      Text(
                        'mam.dept.it@gmail.com',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const Gap(6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, size: 16, color: AppColors.primary),
                      const Gap(6),
                      Text(
                        '+62 21 1234-5678',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Gap(8),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem({required String question, required String answer}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          title: Text(
            question,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          iconColor: AppColors.primary,
          collapsedIconColor: AppColors.textSecondary,
          children: [
            Text(
              answer,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}

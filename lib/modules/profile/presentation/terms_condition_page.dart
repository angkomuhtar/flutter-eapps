import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:gap/gap.dart';

class TermsConditionPage extends StatelessWidget {
  const TermsConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Syarat dan Ketentuan',
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
            Text(
              'Dengan menggunakan aplikasi ini, Anda menyetujui syarat dan ketentuan berikut:',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            const Gap(16),
            _buildAccordionItem(
              title: '1. Penggunaan Aplikasi',
              content:
                  'Aplikasi ini dirancang untuk membantu karyawan dalam melakukan absensi, pelaporan, dan manajemen tugas harian. Pengguna wajib menggunakan aplikasi sesuai dengan ketentuan perusahaan dan tidak diperkenankan untuk menyalahgunakan fitur yang tersedia.',
            ),
            _buildAccordionItem(
              title: '2. Akun dan Keamanan',
              content:
                  'Setiap pengguna bertanggung jawab untuk menjaga kerahasiaan kredensial akun mereka. Pengguna tidak diperbolehkan untuk membagikan informasi login kepada pihak lain. Perusahaan tidak bertanggung jawab atas penyalahgunaan akun yang terjadi akibat kelalaian pengguna.',
            ),
            _buildAccordionItem(
              title: '3. Data dan Privasi',
              content:
                  'Data yang dikumpulkan melalui aplikasi ini akan digunakan untuk keperluan internal perusahaan dan tidak akan dibagikan kepada pihak ketiga tanpa persetujuan pengguna, kecuali diwajibkan oleh hukum. Perusahaan berkomitmen untuk melindungi privasi dan keamanan data pengguna.',
            ),
            _buildAccordionItem(
              title: '4. Absensi dan Pelaporan',
              content:
                  'Pengguna wajib melakukan absensi sesuai dengan jadwal yang telah ditentukan. Setiap laporan yang disubmit harus akurat dan jujur. Pemalsuan data atau informasi dapat berakibat pada tindakan disipliner sesuai kebijakan perusahaan.',
            ),
            _buildAccordionItem(
              title: '5. Pembaruan Aplikasi',
              content:
                  'Perusahaan berhak untuk melakukan pembaruan atau perubahan pada aplikasi tanpa pemberitahuan sebelumnya. Pengguna disarankan untuk selalu menggunakan versi terbaru dari aplikasi untuk mendapatkan fitur dan keamanan yang optimal.',
            ),
            _buildAccordionItem(
              title: '6. Penghentian Layanan',
              content:
                  'Perusahaan berhak untuk menghentikan atau menangguhkan akses pengguna terhadap aplikasi jika terdapat pelanggaran terhadap syarat dan ketentuan ini atau kebijakan perusahaan lainnya.',
            ),
            _buildAccordionItem(
              title: '7. Batasan Tanggung Jawab',
              content:
                  'Perusahaan tidak bertanggung jawab atas kerugian atau kerusakan yang timbul akibat penggunaan atau ketidakmampuan untuk menggunakan aplikasi, termasuk namun tidak terbatas pada kehilangan data, gangguan teknis, atau kesalahan sistem.',
            ),
            _buildAccordionItem(
              title: '8. Perubahan Syarat dan Ketentuan',
              content:
                  'Perusahaan berhak untuk mengubah syarat dan ketentuan ini sewaktu-waktu. Perubahan akan diinformasikan melalui aplikasi atau saluran komunikasi resmi perusahaan. Pengguna disarankan untuk meninjau syarat dan ketentuan secara berkala.',
            ),
            _buildAccordionItem(
              title: '9. Hukum yang Berlaku',
              content:
                  'Syarat dan ketentuan ini tunduk pada hukum yang berlaku di Republik Indonesia. Setiap sengketa yang timbul akan diselesaikan melalui mekanisme penyelesaian yang disepakati oleh kedua belah pihak.',
            ),
            _buildAccordionItem(
              title: '10. Kontak',
              content:
                  'Jika Anda memiliki pertanyaan atau memerlukan bantuan terkait syarat dan ketentuan ini, silakan hubungi tim HR atau IT Support perusahaan melalui email atau telepon yang tertera di aplikasi.',
            ),
            const Gap(24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Terakhir diperbarui: Januari 2024',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccordionItem({
    required String title,
    required String content,
  }) {
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
            title,
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
              content,
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

import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:gap/gap.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Kebijakan Privasi',
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
              'Kami menghargai privasi Anda dan berkomitmen untuk melindungi data pribadi Anda. Kebijakan privasi ini menjelaskan bagaimana kami mengumpulkan, menggunakan, dan melindungi informasi Anda.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            const Gap(16),
            _buildAccordionItem(
              title: '1. Informasi yang Kami Kumpulkan',
              content:
                  'Kami mengumpulkan informasi yang Anda berikan secara langsung, termasuk:\n\n• Data profil (nama, email, nomor telepon, foto profil)\n• Data kepegawaian (NIK, divisi, jabatan)\n• Data absensi (waktu check-in/check-out, lokasi GPS)\n• Data laporan (hazard report, inspection, sleep duration)\n• Data cuti dan izin\n• Log aktivitas dalam aplikasi\n\nInformasi ini diperlukan untuk menjalankan fungsi aplikasi dan memenuhi kebutuhan administratif perusahaan.',
            ),
            _buildAccordionItem(
              title: '2. Bagaimana Kami Menggunakan Informasi',
              content:
                  'Informasi yang kami kumpulkan digunakan untuk:\n\n• Verifikasi identitas dan autentikasi pengguna\n• Pencatatan kehadiran dan absensi karyawan\n• Pemrosesan pengajuan cuti dan izin\n• Pelaporan insiden dan hazard\n• Monitoring durasi tidur untuk keselamatan kerja\n• Komunikasi internal terkait pekerjaan\n• Analisis dan peningkatan kualitas layanan\n• Kepatuhan terhadap regulasi dan audit internal',
            ),
            _buildAccordionItem(
              title: '3. Penyimpanan Data',
              content:
                  'Data Anda disimpan di server yang aman dengan enkripsi standar industri. Kami menerapkan langkah-langkah keamanan teknis dan organisasi untuk melindungi data dari akses tidak sah, kehilangan, atau penyalahgunaan.\n\nData akan disimpan selama Anda masih aktif sebagai karyawan dan sesuai dengan kebijakan retensi data perusahaan, kecuali diwajibkan lain oleh hukum.',
            ),
            _buildAccordionItem(
              title: '4. Berbagi Informasi dengan Pihak Ketiga',
              content:
                  'Kami tidak akan menjual, menyewakan, atau membagikan informasi pribadi Anda kepada pihak ketiga untuk tujuan komersial. Informasi hanya akan dibagikan dalam kondisi berikut:\n\n• Dengan persetujuan eksplisit dari Anda\n• Kepada penyedia layanan yang membantu operasional aplikasi (cloud hosting, analytics) dengan perjanjian kerahasiaan\n• Ketika diwajibkan oleh hukum atau proses hukum\n• Untuk melindungi hak dan keselamatan perusahaan, karyawan, atau publik',
            ),
            _buildAccordionItem(
              title: '5. Akses dan Penggunaan Lokasi',
              content:
                  'Aplikasi ini menggunakan layanan lokasi GPS untuk:\n\n• Verifikasi lokasi saat absensi\n• Pelaporan insiden dengan koordinat lokasi\n• Monitoring kehadiran di area kerja yang ditentukan\n\nData lokasi hanya dikumpulkan saat Anda menggunakan fitur yang memerlukannya dan tidak dilacak secara terus-menerus. Anda dapat mengelola izin lokasi melalui pengaturan perangkat Anda.',
            ),
            _buildAccordionItem(
              title: '6. Akses Kamera dan Media',
              content:
                  'Aplikasi memerlukan akses ke kamera dan galeri foto untuk:\n\n• Mengambil foto profil\n• Dokumentasi laporan hazard dan inspection\n• Upload bukti pendukung untuk pengajuan cuti\n\nFoto dan media yang Anda upload akan disimpan di server perusahaan dan hanya dapat diakses oleh pihak berwenang untuk keperluan verifikasi dan arsip.',
            ),
            _buildAccordionItem(
              title: '7. Hak Anda atas Data Pribadi',
              content:
                  'Anda memiliki hak untuk:\n\n• Mengakses dan melihat data pribadi Anda\n• Memperbarui atau mengoreksi informasi yang tidak akurat\n• Meminta penghapusan data (sesuai kebijakan perusahaan)\n• Menarik persetujuan penggunaan data tertentu\n• Mengajukan keluhan terkait penggunaan data pribadi\n\nUntuk melaksanakan hak-hak ini, silakan hubungi tim HR atau IT Support.',
            ),
            _buildAccordionItem(
              title: '8. Keamanan Data',
              content:
                  'Kami menerapkan standar keamanan tinggi untuk melindungi data Anda:\n\n• Enkripsi data saat transmisi (HTTPS/TLS)\n• Autentikasi dan otorisasi berlapis\n• Audit log dan monitoring aktivitas\n• Backup data secara berkala\n• Pembatasan akses hanya untuk personel berwenang\n\nNamun, tidak ada sistem yang 100% aman. Anda juga bertanggung jawab untuk menjaga kerahasiaan kredensial akun Anda.',
            ),
            _buildAccordionItem(
              title: '9. Cookies dan Tracking',
              content:
                  'Aplikasi mobile ini tidak menggunakan cookies seperti website. Namun, kami mengumpulkan data analytics untuk memahami penggunaan aplikasi dan meningkatkan pengalaman pengguna:\n\n• Frekuensi penggunaan fitur\n• Waktu sesi aplikasi\n• Informasi perangkat (model, OS, versi aplikasi)\n• Log error dan crash reports\n\nData ini bersifat anonim dan tidak dapat digunakan untuk mengidentifikasi Anda secara personal.',
            ),
            _buildAccordionItem(
              title: '10. Perubahan Kebijakan Privasi',
              content:
                  'Kami dapat memperbarui kebijakan privasi ini sewaktu-waktu untuk mencerminkan perubahan praktik pengolahan data atau persyaratan hukum. Perubahan signifikan akan diinformasikan melalui:\n\n• Notifikasi dalam aplikasi\n• Email ke alamat yang terdaftar\n• Pengumuman resmi perusahaan\n\nKami mendorong Anda untuk meninjau kebijakan ini secara berkala. Penggunaan aplikasi setelah perubahan dianggap sebagai penerimaan terhadap kebijakan yang diperbarui.',
            ),
            _buildAccordionItem(
              title: '11. Penghapusan Akun',
              content:
                  'Jika Anda ingin menghapus akun dan data pribadi Anda, silakan hubungi tim HR dengan prosedur berikut:\n\n• Ajukan permintaan penghapusan akun secara tertulis\n• Verifikasi identitas akan dilakukan\n• Data akan dihapus dalam waktu 30 hari kerja\n• Beberapa data mungkin tetap disimpan untuk keperluan hukum dan audit\n\nPerlu diingat bahwa penghapusan akun akan menghilangkan akses Anda ke semua fitur aplikasi.',
            ),
            _buildAccordionItem(
              title: '12. Kontak',
              content:
                  'Jika Anda memiliki pertanyaan, kekhawatiran, atau permintaan terkait kebijakan privasi ini dan penggunaan data pribadi Anda, silakan hubungi:\n\n• Email: mam.dept.it@gmail.com\n• Website: mitraabadimahakam.id\n• Telepon: (021) 1234-5678\n• Tim HR & IT Support\n\nKami akan merespons pertanyaan Anda dalam waktu 7 hari kerja.',
            ),
            const Gap(24),
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
              child: Column(
                children: [
                  Icon(
                    Icons.security,
                    color: AppColors.primary,
                    size: 32,
                  ),
                  const Gap(8),
                  Text(
                    'Privasi Anda adalah Prioritas Kami',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(4),
                  Text(
                    'Kami berkomitmen untuk melindungi dan menghormati data pribadi Anda sesuai dengan hukum yang berlaku.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Gap(16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
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

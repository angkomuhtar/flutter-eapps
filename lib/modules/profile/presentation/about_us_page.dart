import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:gap/gap.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  String appVersion = '';
  String buildNumber = '';

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Tentang Aplikasi',
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Image.asset(
                'assets/launcher/foreground.png',
                width: 100,
                height: 100,
              ),
            ),
            const Gap(24),
            Text(
              'MAM E-Apps',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            const Gap(8),
            Text(
              'Mitra Abadi Mahakam',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const Gap(4),
            Text(
              'Employee Application System',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            ),
            const Gap(8),
            Text(
              'Versi $appVersion${buildNumber.isNotEmpty ? ' ($buildNumber)' : ''}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textHint,
              ),
            ),
            const Gap(32),
            _buildInfoCard(
              icon: Icons.info_outline,
              title: 'Tentang MAM E-Apps',
              content:
                  'MAM E-Apps adalah aplikasi mobile yang dirancang khusus untuk karyawan PT Mitra Abadi Mahakam dalam mengelola aktivitas harian kerja. Aplikasi ini menyediakan berbagai fitur untuk meningkatkan efisiensi, produktivitas, dan keselamatan kerja di lingkungan PT Mitra Abadi Mahakam.',
            ),
            const Gap(16),
            _buildInfoCard(
              icon: Icons.flag_outlined,
              title: 'Visi Kami',
              content:
                  'Menjadi solusi digital terdepan dalam manajemen kepegawaian yang memberikan kemudahan akses, transparansi, dan efisiensi bagi seluruh karyawan.',
            ),
            const Gap(16),
            _buildInfoCard(
              icon: Icons.lightbulb_outline,
              title: 'Misi Kami',
              content:
                  'Menyediakan platform yang user-friendly, aman, dan terintegrasi untuk mendukung kebutuhan administratif karyawan PT Mitra Abadi Mahakam serta meningkatkan kualitas layanan internal dan standar keselamatan kerja.',
            ),
            const Gap(24),
            Container(
              padding: const EdgeInsets.all(20),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.apps, color: AppColors.primary, size: 24),
                      const Gap(12),
                      Text(
                        'Fitur Utama',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const Gap(16),
                  _buildFeatureItem(
                    Icons.check_circle_outline,
                    'Absensi Digital dengan GPS',
                  ),
                  _buildFeatureItem(
                    Icons.check_circle_outline,
                    'Pengajuan dan Tracking Cuti',
                  ),
                  _buildFeatureItem(
                    Icons.check_circle_outline,
                    'Pelaporan Hazard dan Insiden',
                  ),
                  _buildFeatureItem(
                    Icons.check_circle_outline,
                    'Hazard Action Management',
                  ),
                  _buildFeatureItem(
                    Icons.check_circle_outline,
                    'Inspeksi Keselamatan Kerja',
                  ),
                  _buildFeatureItem(
                    Icons.check_circle_outline,
                    'Monitoring Durasi Tidur',
                  ),
                  _buildFeatureItem(
                    Icons.check_circle_outline,
                    'Dashboard dan Rekap Data',
                  ),
                  _buildFeatureItem(
                    Icons.check_circle_outline,
                    'Notifikasi Real-time',
                  ),
                ],
              ),
            ),
            const Gap(24),
            Container(
              padding: const EdgeInsets.all(20),
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
                  Icon(
                    Icons.email_outlined,
                    color: AppColors.primary,
                    size: 32,
                  ),
                  const Gap(12),
                  Text(
                    'Hubungi Kami',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Gap(16),
                  _buildContactItem(Icons.phone, '+62 21 1234-5678'),
                  const Gap(8),
                  _buildContactItem(Icons.email, 'mam.dept.it@gmail.com'),
                  const Gap(8),
                  _buildContactItem(Icons.language, 'mitraabadimahakam.id'),
                ],
              ),
            ),
            const Gap(24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    '© 2024 PT Mitra Abadi Mahakam',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(4),
                  Text(
                    'MAM E-Apps - All rights reserved.',
                    style: TextStyle(fontSize: 11, color: AppColors.textHint),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 24),
              const Gap(12),
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
          const Gap(12),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const Gap(12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: AppColors.primary, size: 18),
        const Gap(8),
        Text(
          text,
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

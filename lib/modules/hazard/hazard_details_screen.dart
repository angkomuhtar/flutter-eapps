import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/hazard/hazard_provider.dart';
import 'package:flutter_eapps/widget/appbar-widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_eapps/widget/loading-list.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:flutter_eapps/widget/hazard/hazard_widget.dart';

class HazardDetailsScreen extends ConsumerStatefulWidget {
  final String id;

  const HazardDetailsScreen({super.key, required this.id});

  @override
  ConsumerState<HazardDetailsScreen> createState() =>
      _HazardDetailsScreenState();
}

class _HazardDetailsScreenState extends ConsumerState<HazardDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(detailHazardProvider(id: widget.id));

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustAppBar(title: 'Detail Laporan'),
            Expanded(
              child: detailAsync.when(
                data: (data) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(detailHazardProvider(id: widget.id));
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          spacing: 12,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ContBox(
                              children: [
                                itemValue(
                                  title: "Nomor Laporan",
                                  value: data.hazard_number,
                                ),
                                itemValue(
                                  title: "Status Laporan",
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: data.status == "OPEN"
                                          ? AppColors.red
                                          : data.status == "ONPROGRESS"
                                          ? AppColors.yellow
                                          : AppColors.green,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      data.status == "OPEN"
                                          ? "Open"
                                          : data.status == "ONPROGRESS"
                                          ? "On Progress"
                                          : "Closed",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                itemValue(
                                  title: "Tanggal Laporan",
                                  value:
                                      DateFormat(
                                        'EEEE, dd MMM yyyy - hh:mm a',
                                        'id_ID',
                                      ).format(
                                        DateFormat(
                                          "yyyy-MM-dd HH:mm:ss",
                                        ).parse(data.date),
                                      ),
                                ),
                                itemValue(
                                  title: "Kategori Bahaya",
                                  value: data.category == 'TTA'
                                      ? "Tindakan Tidak Aman"
                                      : "Kondisi Tidak Aman",
                                ),
                                itemValue(
                                  title: "Lokasi Temuan",
                                  value: data.location?.id == 999
                                      ? data.other_location ?? '-'
                                      : data.location?.name ?? '-',
                                ),
                                itemValue(
                                  title: "Detail Lokasi temuan",
                                  value: data.detail_location ?? '-',
                                ),
                              ],
                            ),
                            Text(
                              'Departement Terkait',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ContBox(
                              children: [
                                itemValue(
                                  title: "Perusahaan",
                                  value: data.company?.name ?? '-',
                                ),
                                itemValue(
                                  title: "Project",
                                  value: data.project?.name ?? '-',
                                ),
                                itemValue(
                                  title: "Departement",
                                  value: data.division?.name ?? '-',
                                ),
                              ],
                            ),
                            Text(
                              'Detail Temuan Bahaya',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ContBox(
                              children: [
                                itemValue(
                                  title: "Kondisi Temuan",
                                  value: data.condition,
                                ),
                                itemValue(
                                  title: "Rekomendasi Tindakan",
                                  value: data.recomended_action,
                                ),
                                itemValue(
                                  title: "Tindakan yang diambil",
                                  value: data.action_taken,
                                ),
                                itemValue(
                                  title: "Lampiran Laporan",
                                  child: ImageViewer(
                                    imageUrl: data.report_attachment,
                                  ),
                                ),
                                itemValue(
                                  title: "Batas Waktu Penanganan",
                                  value:
                                      DateFormat(
                                        'EEEE, dd MMM yyyy',
                                        'id_ID',
                                      ).format(
                                        DateFormat(
                                          'yyyy-MM-dd',
                                        ).parse(data.due_date),
                                      ),
                                ),
                              ],
                            ),
                            Gap(14),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                loading: () => Center(child: LoadingList()),
                error: (e, st) => Center(child: ErrorList()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

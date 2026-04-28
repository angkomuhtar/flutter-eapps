import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/leave/leave_provider.dart';
import 'package:flutter_eapps/widget/appbar-widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_eapps/widget/loading-list.dart';
import 'package:gap/gap.dart';
import 'package:flutter_eapps/widget/hazard/hazard_widget.dart';
import 'package:intl/intl.dart';

class LeaveDetailsScreen extends ConsumerStatefulWidget {
  final String id;

  const LeaveDetailsScreen({super.key, required this.id});

  @override
  ConsumerState<LeaveDetailsScreen> createState() => _LeaveDetailsScreenState();
}

class _LeaveDetailsScreenState extends ConsumerState<LeaveDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(detailLeaveProvider(id: widget.id));

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustAppBar(title: 'Detail Pengajuan Cuti'),
            Expanded(
              child: detailAsync.when(
                data: (data) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(detailLeaveProvider(id: widget.id));
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Detail Cuti',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: data.status == 'approved'
                                        ? Colors.green
                                        : data.status == 'pending'
                                        ? Colors.orange
                                        : Colors.red,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    (data.status == 'approved'
                                            ? 'Disetujui'
                                            : data.status == 'pending'
                                            ? 'Menunggu'
                                            : data.status == 'expired'
                                            ? 'Kadaluarsa '
                                            : 'Ditolak')
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ContBox(
                              children: [
                                itemValue(
                                  title: "Jenis Cuti",
                                  value: data.absence_type.name,
                                ),
                                itemValue(
                                  title: "Tanggal Cuti",
                                  value: data.start_date == data.end_date
                                      ? DateFormat('dd MMM yyyy').format(
                                          DateTime.parse(data.start_date),
                                        )
                                      : '${DateFormat('dd MMM yyyy', 'id-ID').format(DateTime.parse(data.start_date))} s/d ${DateFormat('dd MMM yyyy', 'id-ID').format(DateTime.parse(data.end_date))}',
                                ),
                                itemValue(
                                  title: "Jumlah Hari",
                                  value: '${data.total_days.toString()} Hari',
                                ),
                                itemValue(
                                  title: "Alasan Cuti",
                                  value: data.notes ?? '-',
                                ),
                              ],
                            ),
                            Text(
                              'Persetujuan',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ...data.approvals.map(
                              (approval) => ContBox(
                                children: [
                                  itemValue(
                                    title: "Peran",
                                    value: approval.role == 'admin_dept'
                                        ? 'Admin Departement'
                                        : approval.role == 'dept_head'
                                        ? 'Kepala Departement'
                                        : approval.role == 'admin_hr'
                                        ? 'Admin HR'
                                        : approval.role == 'dept_head_hr'
                                        ? 'Kepala Departement HR'
                                        : 'Project Manager',
                                  ),
                                  itemValue(
                                    title: "Nama",
                                    value: approval.approver.name,
                                  ),
                                  itemValue(
                                    title: "Status",
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: approval.status == 'approved'
                                                ? Colors.green
                                                : approval.status ==
                                                          'pending' ||
                                                      approval.status ==
                                                          'waiting'
                                                ? Colors.orange
                                                : Colors.red,
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          child: Text(
                                            (approval.status == 'approved'
                                                    ? 'Disetujui'
                                                    : approval.status ==
                                                              'pending' ||
                                                          approval.status ==
                                                              'waiting'
                                                    ? 'Menunggu'
                                                    : approval.status ==
                                                          'expired'
                                                    ? 'Kadaluarsa '
                                                    : 'Ditolak')
                                                .toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        if (approval.approved_at != null) ...[
                                          Gap(8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              '(${DateFormat('dd MMM yyyy, HH:mm').format(DateFormat('dd MMMM yyyy - HH:mm:ss').parse(approval.approved_at!))})',
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  itemValue(
                                    title: "Catatan",
                                    value: approval.notes,
                                  ),
                                ],
                              ),
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

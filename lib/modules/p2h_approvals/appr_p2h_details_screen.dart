import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/core/models/appr_p2h_model.dart';
import 'package:flutter_eapps/modules/p2h_approvals/appr_p2h_provider.dart';
import 'package:flutter_eapps/widget/alert-widget.dart';
import 'package:flutter_eapps/widget/appbar-widget.dart';
import 'package:flutter_eapps/widget/loading-widget.dart';
import 'package:flutter_eapps/widget/text-input.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_eapps/widget/hazard/hazard_widget.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class ApprP2hDetailsScreen extends ConsumerStatefulWidget {
  final ApprP2hModel item;

  const ApprP2hDetailsScreen({super.key, required this.item});

  @override
  ConsumerState<ApprP2hDetailsScreen> createState() =>
      _ApprP2hDetailsScreenState();
}

class _ApprP2hDetailsScreenState extends ConsumerState<ApprP2hDetailsScreen> {
  final _formData = <String, dynamic>{};

  Future<void> _submit() async {
    _formData['id'] = widget.item.id;
    LoadingWidget.show(context, message: 'Memverifikasi Laporan P2H');

    final (success, errorMessage) = await ref
        .read(verifyP2hProvider.notifier)
        .upload(_formData);

    debugPrint(_formData.toString());

    if (!mounted) return;

    LoadingWidget.hide(context);

    if (success) {
      _formData.clear();
      await AlertWidget.show(
        context: context,
        title: 'Berhasil',
        description: 'Berhasil memperbarui penanganan laporan bahaya',
        type: 'success',
      ).then((_) {
        ref.read(listApprP2hProvider().notifier).refresh();
        Navigator.of(context).pop(true);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage ?? 'Gagal menyimpan laporan bahaya'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final detailAsync = ref.watch(detailInspectionProvider(id: widget.id));

    final Map<int, FormHeader> headerMap = {};
    final Map<int, List<FormMaster>> groupedMasters = {};

    for (final fm in widget.item.form_masters) {
      headerMap.putIfAbsent(fm.form_header.id, () => fm.form_header);
      groupedMasters.putIfAbsent(fm.form_header.id, () => []).add(fm);
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            CustAppBar(title: 'Detail Laporan P2H'),
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ContBox(
                      children: [
                        itemValue(
                          title: "Unit",
                          value:
                              "${widget.item.unit.brand} ${widget.item.unit.model} / ${widget.item.unit.code}",
                        ),
                        itemValue(
                          title: "HM / KM (Awal - Akhir)",
                          value:
                              "${widget.item.hm_start} - ${widget.item.hm_end}",
                        ),
                        itemValue(
                          title: "Tanggal Pemeriksaan",
                          value:
                              "${DateFormat('dd MMMM yyyy', 'id_ID').format(DateFormat('yyyy-MM-dd').parse(widget.item.date))} ${DateFormat('HH:mm', 'id_ID').format(DateFormat('HH:mm:ss').parse(widget.item.activity_start_time))}",
                        ),
                        itemValue(
                          title: "Shift",
                          value:
                              "${widget.item.shift.name} (${widget.item.shift.start_time} - ${widget.item.shift.end_time})",
                        ),
                        itemValue(
                          title: "Lama Tidur",
                          value: "${widget.item.sleep_duration} Jam",
                        ),
                        itemValue(
                          title: "Kondisi Badan",
                          value:
                              "${widget.item.operator_condition == "fit" ? "Sehat" : "Tidak Sehat"}",
                        ),
                        itemValue(title: "Catatan", value: widget.item.notes),
                        // itemValue(title: "Status", value: widget.item.status),
                      ],
                    ),
                    Text(
                      'Hasil Inspeksi',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: groupedMasters.entries.expand((entry) {
                        final header = headerMap[entry.key]!;
                        final items = entry.value;
                        return [
                          ContBox(
                            children: [
                              Text(
                                "${entry.key}. ${header.name}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ...items.expand(
                                (e) => [
                                  itemValue(
                                    title: e.question,
                                    value: e.condition == "good"
                                        ? "Baik"
                                        : e.condition == "bad"
                                        ? "Tidak Baik"
                                        : "Tidak Tersedia",
                                  ),
                                  if (e.condition == "bad")
                                    itemValue(
                                      title: "Keterangan",
                                      value: e.note ?? "-",
                                    ),
                                ],
                              ),
                            ],
                          ),
                          Gap(12),
                        ];
                      }).toList(),
                    ),
                    Text(
                      'Persetujuan',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: widget.item.approvals != null
                          ? widget.item.approvals!.expand((approval) {
                              return [
                                approval.user == null
                                    ? SizedBox.shrink()
                                    : ContBox(
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundImage:
                                                    approval.user != null
                                                    ? NetworkImage(
                                                        approval.user!.avatar!,
                                                      )
                                                    : null,
                                                child: approval.user == null
                                                    ? Icon(Icons.person)
                                                    : null,
                                              ),
                                              Gap(12),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    approval.user!.name,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${approval.user!.position} - ${approval.user!.department}",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: itemValue(
                                                  title: "Status",
                                                  value: approval.status,
                                                ),
                                              ),
                                              Expanded(
                                                child: itemValue(
                                                  title: "Peran",
                                                  value:
                                                      approval.role.isNotEmpty
                                                      ? approval.role
                                                      : "-",
                                                ),
                                              ),
                                            ],
                                          ),
                                          itemValue(
                                            title: "Tanggal Disetujui",
                                            value: approval.approved_at != null
                                                ? DateFormat(
                                                    'dd MMMM yyyy HH:mm',
                                                    'id_ID',
                                                  ).format(
                                                    DateTime.parse(
                                                      approval.approved_at!,
                                                    ),
                                                  )
                                                : "-",
                                          ),
                                          itemValue(
                                            title: "Catatan",
                                            value: approval.note.isNotEmpty
                                                ? approval.note
                                                : "-",
                                          ),
                                        ],
                                      ),
                                Gap(12),
                              ];
                            }).toList()
                          : [],
                    ),
                    InputText(
                      key: const ValueKey('notes'),
                      labelText: 'Catatan Verifikasi (Opsional)',
                      keyboardType: TextInputType.text,
                      maxLines: 3,
                      minLines: 3,
                      onSaved: (value) {
                        _formData['verification_note'] = value;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _formData['status'] = 'rejected';
                              _submit();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondaryDark,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Tolak',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Gap(12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _formData['status'] = 'approved';
                              _submit();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Setujui',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(25),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

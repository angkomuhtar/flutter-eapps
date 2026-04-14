import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/widget/appbar-widget.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              CustAppBar(title: 'Notifikasi'),
              // Container(
              //   height: 100,
              //   decoration: BoxDecoration(color: AppColors.white),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

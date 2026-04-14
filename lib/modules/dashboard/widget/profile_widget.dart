import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';
import 'package:flutter_eapps/modules/auth/auth_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ProfileWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(currentUserProvider);
    return userAsyncValue.when(
      data: (user) {
        return Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/avatar-default.png'),
              backgroundColor: AppColors.white,
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    user?.name ?? 'Guest User',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  Gap(4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '${user?.employee?.jabatan} - ${user?.employee?.divisi}',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      loading: () => const Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/avatar-default.png'),
            backgroundColor: AppColors.white,
          ),
          Gap(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                height: 16,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
              ),
              Gap(6),
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    height: 12,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                  ),
                  Gap(8),
                  SizedBox(
                    width: 80,
                    height: 12,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      error: (e, __) {
        print(e);
        return Text('Error loading user data');
      },
    );
  }
}

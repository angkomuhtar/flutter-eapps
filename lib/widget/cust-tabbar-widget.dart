import 'package:flutter/material.dart';
import 'package:flutter_eapps/core/constants/app_colors.dart';

class CustTabBar extends StatelessWidget {
  final int selectedIndex;
  final List<Tabs> tabs;

  const CustTabBar({
    super.key,
    required this.selectedIndex,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width - 32;
    final int tabCount = tabs.length;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Center(
            child: Container(
              width: screenWidth,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.20),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    left: selectedIndex * (screenWidth / tabCount),
                    top: 0,
                    bottom: 0,
                    width: screenWidth / tabCount,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  Row(
                    children: tabs.map((tab) {
                      final int index = tabs.indexOf(tab);
                      return TabButton(
                        index: index,
                        icon: tab.icon,
                        text: tab.text,
                        tabwidth: screenWidth / tabCount,
                        isSelected: selectedIndex == index,
                        onTap: tab.onTap,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Tabs {
  final IconData? icon;
  final String text;
  final VoidCallback onTap;

  const Tabs({this.icon, required this.text, required this.onTap});
}

class TabButton extends StatelessWidget {
  final int index;
  final IconData? icon;
  final String text;
  final double tabwidth;
  final bool isSelected;
  final VoidCallback onTap;

  const TabButton({
    super.key,
    required this.index,
    this.icon,
    required this.text,
    required this.tabwidth,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: tabwidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            spacing: 6,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  size: 22,
                  color: isSelected ? AppColors.white : AppColors.primary,
                ),
              Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isSelected ? AppColors.white : AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

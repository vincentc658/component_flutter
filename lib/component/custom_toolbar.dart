import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:research_component/constant/constants_color.dart';

class CustomToolbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isShowBackButton;
  final VoidCallback? onBack;
  final Widget? action;
  final PreferredSizeWidget? bottom;

  const CustomToolbar({
    Key? key,
    required this.title,
    required this.isShowBackButton,
    this.onBack,
    this.action,
    this.bottom,
  }) : super(key: key);

  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize.height ?? 0.0;
    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: ConstantsColor.PRIMARY[800],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ConstantsColor.PRIMARY.shade900,
              ConstantsColor.PRIMARY.shade400,
              ConstantsColor.PRIMARY.shade200,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      leading: isShowBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: onBack ?? () => Get.back(result: true),
      )
          : null,
      actions: action != null
          ? [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: action!,
        ),
      ]
          : null,
      bottom: bottom,
    );
  }
}

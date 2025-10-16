import 'package:flutter/material.dart';

class CustomSnackBar {
  
  static const _profiles = {
    "success": {"color": Colors.green, "icon": Icons.check_circle},
    "error": {"color": Color(0xFFFF5449), "icon": Icons.error_outline_rounded},
    "warning": {"color": Colors.amber, "icon": Icons.warning_amber_rounded},
  };

  static void show(
    BuildContext context, {
    required String message,
    String profile = "success",
    IconData? icon,
    Color? backgroundColor,
  }) {

    final profileData = _profiles[profile] ?? _profiles["success"]!;
    final snackBarIcon = icon ?? profileData["icon"] as IconData;
    final snackBarColor = backgroundColor ?? profileData["color"] as Color;

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(snackBarIcon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
      backgroundColor: snackBarColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

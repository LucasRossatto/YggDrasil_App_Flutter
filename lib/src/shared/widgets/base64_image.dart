import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class Base64Image extends StatelessWidget {
  final String? base64String;

  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final BoxShadow? boxShadow;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? placeholder;

  const Base64Image({
    super.key,
    required this.base64String,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.boxShadow,
    this.backgroundColor = Colors.transparent,
    this.padding,
    this.margin,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    Uint8List? bytes;
    try {
      if (base64String != null && base64String!.isNotEmpty) {
        bytes = base64Decode(base64String!);
      }
    } catch (e) {
      bytes = null;
    }

    return Container(
      margin: margin,
      padding: padding,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        boxShadow: boxShadow != null ? [boxShadow!] : null,
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: bytes != null
            ? Image.memory(bytes, width: width, height: height, fit: fit)
            : (placeholder ??
                  Icon(Icons.image_not_supported, color: Colors.grey)),
      ),
    );
  }
}

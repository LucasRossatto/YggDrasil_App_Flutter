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

  Uint8List? _decodeBase64(String? input) {
    if (input == null || input.isEmpty) return null;

    try {
      // Remove prefixo se existir (ex: data:image/png;base64,)
      final cleaned = input.replaceAll(RegExp(r'^data:image\/[a-zA-Z]+;base64,'), '');
      // Remove quebras de linha e espaços extras
      final normalized = cleaned.replaceAll('\n', '').trim();
      return base64Decode(normalized);
    } catch (e) {
      debugPrint('Erro ao decodificar imagem base64: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bytes = _decodeBase64(base64String);

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
            ? Image.memory(
                bytes,
                width: width,
                height: height,
                fit: fit,
                errorBuilder: (context, error, stackTrace) =>
                    placeholder ??
                    const Icon(Icons.broken_image, color: Colors.grey),
              )
            : (placeholder ??
                const Icon(Icons.image_not_supported, color: Colors.grey)),
      ),
    );
  }
}

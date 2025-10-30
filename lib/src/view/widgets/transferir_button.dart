import 'package:flutter/material.dart';

/// Perfis de cor do botão
enum ButtonColorProfile { normal, error }

/// Posição do ícone dentro do botão
enum IconPosition { left, right }

class TransferirButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String text;
  final ButtonColorProfile? colorProfile; 
  final IconData? icon;
  final IconPosition iconPosition;

  const TransferirButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    required this.text,
    this.colorProfile,
    this.icon,
    this.iconPosition = IconPosition.left,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // Define cores conforme o perfil
    final Color backgroundColor;
    final Color textColor;

    switch (colorProfile) {
      case ButtonColorProfile.error:
        backgroundColor = colors.error;
        textColor = colors.onError;
        break;
      case ButtonColorProfile.normal:
      case null:
        backgroundColor = colors.primary;
        textColor = colors.surface;
        break;
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          backgroundColor: WidgetStatePropertyAll(backgroundColor),
        ),
        onPressed: isLoading ? null : onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLoading
              ? SizedBox(
                  height: 17,
                  width: 17,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null && iconPosition == IconPosition.left) ...[
                      Icon(icon, size: 20, color: textColor),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    if (icon != null && iconPosition == IconPosition.right) ...[
                      const SizedBox(width: 8),
                      Icon(icon, size: 20, color: textColor),
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:YggDrasil/src/models/wallet_model.dart';
import 'package:YggDrasil/src/view/widgets/qr_code.dart';

Future<dynamic> qrcodeModal(BuildContext context, WalletModel wallet) {
    return showModalBottomSheet(
    context: context,
    useSafeArea: true,
    showDragHandle: true,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Carteira',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Este é seu código para receber Yggcoins ou SCC por Transferência",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            WalletQrCode(walletKey: wallet.key),
            const SizedBox(height: 24),
          ],
        ),
      );
    },
  );
  }
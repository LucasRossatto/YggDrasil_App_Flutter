import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class WalletQrCode extends StatefulWidget {
  const WalletQrCode({super.key});

  @override
  State<WalletQrCode> createState() => _WalletQrCode();
}

class _WalletQrCode extends State<WalletQrCode> {
  @override
  Widget build(BuildContext context) {
    return PrettyQrView.data(
      data: 'carteira ygg',
      decoration: const PrettyQrDecoration(
        image: PrettyQrDecorationImage(image: AssetImage('assets/images/logo-yggdrasil-qrcode.png')),
        quietZone: PrettyQrQuietZone.standart,
      ),
    );
  }
}

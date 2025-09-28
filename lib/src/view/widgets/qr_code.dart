import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class WalletQrCode extends StatefulWidget {
  final String walletKey;

  const WalletQrCode({super.key, required this.walletKey});

  @override
  State<WalletQrCode> createState() => _WalletQrCodeState();
}

class _WalletQrCodeState extends State<WalletQrCode> {
  @override
  Widget build(BuildContext context) {
    final double qrSize = MediaQuery.of(context).size.width - 140;
    final String walletKey = widget.walletKey;

    return Center(
      child: SizedBox(
        width: qrSize,
        height: qrSize,
        child: PrettyQrView.data(
          data: walletKey,
          errorCorrectLevel: QrErrorCorrectLevel.H,
         
        ),
      ),
    );
  }
}

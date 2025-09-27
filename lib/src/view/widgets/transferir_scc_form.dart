import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yggdrasil_app/src/shared/widgets/app_text_field.dart';
import 'package:yggdrasil_app/src/view/widgets/saldo_wallet_card.dart';
import 'package:yggdrasil_app/src/view/widgets/transferir_button.dart';

class SccTransferirForm extends StatelessWidget {
  final int carteiraId;
  final int carteiraSaldo;
  final _carteidaDestino = TextEditingController();
  final _quantidadeScc = TextEditingController();
  final VoidCallback abrirScanner;

  SccTransferirForm({
    super.key,
    required this.carteiraId,
    required this.carteiraSaldo, required this.abrirScanner,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 20),
          SaldoWalletCard(
            label: "Saldo Disponível",
            icone: SvgPicture.asset('assets/Icons/Icone_SCC.svg'),
            titulo: "Carteira SCC",
            subtitulo: "Saldo disponível SCC",
            saldo: "$carteiraSaldo",
            onTap: () {},
          ),
          SizedBox(height: 20),
          Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 110,
                child: AppTextField(
                  controller: _carteidaDestino,
                  label: "Carteira Destinada",
                  extraLabel: "Carteira Destinada",
                  hint: "Digite a carteira de destino ou escaneie o QR Code",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 22),
                child: IconButton(
                  iconSize: 42,
                  onPressed: abrirScanner,
                  icon: Icon(
                    Icons.qr_code_rounded,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          AppTextField(
            keyboardType: TextInputType.number,
            controller: _quantidadeScc,
            label: "Valor",
            extraLabel: "Quantidade de SCC",
            hint: "Insira o valor a ser transferido",
          ),
          SizedBox(height: MediaQuery.of(context).size.width - 110),
          TransferirButton(onPressed: () {}, text: 'Transferir SCC'),
        ],
      ),
    );
  }
}

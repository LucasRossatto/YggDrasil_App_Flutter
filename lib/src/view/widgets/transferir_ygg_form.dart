import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yggdrasil_app/src/shared/widgets/app_text_field.dart';
import 'package:yggdrasil_app/src/view/widgets/saldo_wallet_card.dart';
import 'package:yggdrasil_app/src/view/widgets/transferir_button.dart';

class YggTransferirForm extends StatelessWidget {
  final int carteiraId;
  final int carteiraSaldo;
  final VoidCallback abrirScanner;

  final TextEditingController carteiraDestinoController;
  final TextEditingController quantidadeController;

  const YggTransferirForm({
    super.key,
    required this.carteiraId,
    required this.carteiraSaldo,
    required this.abrirScanner,
    required this.carteiraDestinoController,
    required this.quantidadeController,
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
            icone: SvgPicture.asset('assets/Icons/Icone_YGG.svg'),
            iconeSize: 44,
            titulo: "Carteira YGG",
            subtitulo: "Saldo disponível YGG",
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
                  controller: carteiraDestinoController,
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
                    shape: const WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
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
            controller: quantidadeController,
            label: "Valor",
            extraLabel: "Quantidade de YGG",
            hint: "Insira o valor a ser transferido",
          ),
          SizedBox(height: MediaQuery.of(context).size.width - 110),
          TransferirButton(onPressed: () {}, text: 'Transferir YGG'),
        ],
      ),
    );
  }
}

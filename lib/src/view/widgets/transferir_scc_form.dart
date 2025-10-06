// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:yggdrasil_app/src/models/wallet_model.dart';
import 'package:yggdrasil_app/src/repository/wallet_repositorio.dart';
import 'package:yggdrasil_app/src/shared/widgets/app_numeric_field.dart';
import 'package:yggdrasil_app/src/shared/widgets/app_text_field.dart';
import 'package:yggdrasil_app/src/shared/widgets/custom_snackbar.dart';
import 'package:yggdrasil_app/src/view/widgets/saldo_wallet_card.dart';
import 'package:yggdrasil_app/src/view/widgets/transferir_button.dart';
import 'package:yggdrasil_app/src/viewmodel/wallet_viewmodel.dart';

class SccTransferirForm extends StatelessWidget {
  final WalletModel carteiraUsuario;
  final int carteiraKey;
  final int carteiraSaldo;
  final VoidCallback abrirScanner;
  final TextEditingController carteiraDestinoController;
  final TextEditingController quantidadeController;
  final tipo = "SCC";

  const SccTransferirForm({
    super.key,
    required this.carteiraKey,
    required this.carteiraSaldo,
    required this.abrirScanner,
    required this.carteiraDestinoController,
    required this.quantidadeController,
    required this.carteiraUsuario,
  });

  @override
  Widget build(BuildContext context) {
    final vmWallet = context.read<WalletViewmodel>();
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 20),
          SaldoWalletCard(
            label: "Saldo Disponível",
            icone: SvgPicture.asset('assets/Icons/Icone_SCC.svg'),
            iconeSize: 44,
            titulo: "Carteira SCC",
            subtitulo: "Saldo disponível SCC",
            saldo: carteiraSaldo.toString(),
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
          AppNumericField(
            controller: quantidadeController,
            label: "Valor",
            extraLabel: "Quantidade de SCC",
            hint: "Insira o valor a ser transferido",
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.66),
          TransferirButton(
            text: 'Funcionalidade disponível apenas no painel',
            onPressed: () async {
              CustomSnackBar.show(
                context,
                profile: 'error',
                message:
                    "🚧 Esta funcionalidade ainda está em desenvolvimento no aplicativo",
              );
              return;

              final quantidade = int.tryParse(quantidadeController.text) ?? 0;
              if (carteiraDestinoController.text.isEmpty) {
                CustomSnackBar.show(
                  context,
                  profile: 'warning',
                  message: "Informe a carteira de destino",
                );
                return;
              }

              if (quantidade <= 0) {
                CustomSnackBar.show(
                  context,
                  profile: 'warning',

                  message: "Informe uma quantidade válida",
                );
                return;
              }
              if (quantidade > carteiraSaldo) {
                CustomSnackBar.show(
                  context,
                  profile: 'warning',

                  message: "Saldo insuficiente",
                );
                return;
              }

              final transacaoValida = await vmWallet.validarTransferencia(
                carteiraKey.toString(),
                carteiraDestinoController.text,
                quantidade,
                tipo,
                carteiraUsuario,
              );

              if (transacaoValida == false) {
                CustomSnackBar.show(
                  context,
                  profile: 'error',
                  message: "Transação inválida",
                );
                return;
              }

              final DadosTransferencia dadosTransferencia = DadosTransferencia(
                walletSaida: carteiraKey.toString(),
                walletDestino: carteiraDestinoController.text,
                quantidade: quantidade,
                tipo: tipo,
              );

              final transacao = await vmWallet.transferir(dadosTransferencia);
              if (transacao == true) {
                CustomSnackBar.show(
                  context,
                  icon: Icons.check_circle_sharp,
                  message: "Transferencia realizada com sucesso!",
                );
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

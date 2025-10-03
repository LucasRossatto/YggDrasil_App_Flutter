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

class YggTransferirForm extends StatelessWidget {
  final String carteiraKey;
  final int carteiraSaldo;
  final WalletModel carteiraUsuario;
  final VoidCallback abrirScanner;
  final TextEditingController carteiraDestinoController;
  final TextEditingController quantidadeController;
  final tipo = "YGG";

  const YggTransferirForm({
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
    final theme = Theme.of(context);
    final vmWallet = context.read<WalletViewmodel>();
    final formKey = GlobalKey<FormState>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: formKey,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Insira uma carteira de destino";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 22),
                  child: IconButton(
                    iconSize: 42,
                    onPressed: abrirScanner,
                    icon: Icon(
                      Icons.qr_code_rounded,
                      color: theme.colorScheme.surface,
                    ),
                    style: ButtonStyle(
                      shape: const WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            AppNumericField(
              validator: (valor) {
                if (valor == null || valor.isEmpty) {
                  return "Informe uma quantidade";
                }

                final quantidade = int.tryParse(valor);
                if (quantidade == null) {
                  return "Valor inválido";
                }

                if (quantidade <= 0) {
                  return "Informe uma quantidade maior que 0";
                }

                if (quantidade > carteiraSaldo) {
                  return "Saldo insuficiente";
                }

                return null; // tudo certo
              },
              controller: quantidadeController,
              label: "Valor",
              extraLabel: "Quantidade de YGG",
              hint: "Insira o valor a ser transferido",
            ),
            SizedBox(height: MediaQuery.of(context).size.width - 110),
            TransferirButton(
              text: 'Transferir YGG',
              onPressed: () async {
                if (!formKey.currentState!.validate()) {
                  CustomSnackBar.show(
                    context,
                    message: "Preencha todos os campos obrigatórios.",
                    profile: 'warning',
                  );
                  return;
                }
                final quantidade = int.tryParse(quantidadeController.text) ?? 0;
                if (carteiraDestinoController.text.isEmpty) {
                  CustomSnackBar.show(
                    context,
                    icon: Icons.error,
                    message: "Informe a carteira de destino",
                    backgroundColor: theme.colorScheme.errorContainer,
                  );
                  return;
                }
                if (quantidade <= 0) {
                  CustomSnackBar.show(
                    context,
                    icon: Icons.error,
                    message: "Informe uma quantidade válida",
                    backgroundColor: theme.colorScheme.errorContainer,
                  );
                  return;
                }
                if (quantidade > carteiraSaldo) {
                  CustomSnackBar.show(
                    context,
                    icon: Icons.error,
                    message: "Saldo insuficiente",
                    backgroundColor: theme.colorScheme.errorContainer,
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
                    icon: Icons.error,
                    message: "Transação inválida",
                    backgroundColor: theme.colorScheme.errorContainer,
                  );
                  return;
                }

                final DadosTransferencia dadosTransferencia =
                    DadosTransferencia(
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
      ),
    );
  }
}

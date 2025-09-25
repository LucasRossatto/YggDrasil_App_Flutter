import 'package:equatable/equatable.dart';

class WalletModel extends Equatable {
  final int id;
  final int usuarioId;
  final String key;
  final int yggCoin;
  final int scc;
  final int status;

  const WalletModel({
    required this.id,
    required this.usuarioId,
    required this.key,
    required this.yggCoin,
    required this.scc,
    required this.status,
  });

  factory WalletModel.int() {
    return WalletModel(
      id: 0,
      usuarioId: 0,
      key: '',
      yggCoin: 0,
      scc: 0,
      status: 0,
    );
  }

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id'] ?? 0,
      usuarioId: json['usuarioId'] ?? '',
      key: json['key'] ?? '',
      yggCoin: json['yggCoin'] ?? 0,
      scc: json['scc'] ?? 0,
      status: json['status'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'usuarioId': usuarioId,
      'key': key,
      'yggCoin': yggCoin,
      'scc': scc,
      'status': status,
    };
  }

  WalletModel copyWith({
    int? id,
    int? usuarioId,
    String? key,
    int? yggCoin,
    int? scc,
    int? status,
  }) {
    return WalletModel(
      id: id ?? this.id,
      usuarioId: usuarioId ?? this.usuarioId,
      key: key ?? this.key,
      yggCoin: yggCoin ?? this.yggCoin,
      scc: scc ?? this.scc,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [id, usuarioId, key, yggCoin, scc, status];
}

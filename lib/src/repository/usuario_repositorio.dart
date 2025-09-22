import 'package:http/http.dart';
import 'package:yggdrasil_app/src/models/usuario_model.dart';
import 'package:yggdrasil_app/src/services/api_service.dart';

class UsuarioRepositorio {
  final ApiService _api;
  UsuarioRepositorio(this._api);
  final client = Client();
  Future<UsuarioModel> cadastrarUsuario(
    String nome,
    String email,
    String senha,
  ) async {
    final data = await _api.post("/CadastrarUsuario", {
      "nome": nome,
      "email": email,
      "senha": senha,
    });

    return UsuarioModel.fromJson(data);
  }
}

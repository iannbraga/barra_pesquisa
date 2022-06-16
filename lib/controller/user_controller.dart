import 'package:flutter/widgets.dart';
import 'package:teste_api/model/user_model.dart';

class UserController {
  List<String> usuarios = [];
  List<String> sugestaoUsuarios = [];

  final state = ValueNotifier<PageState>(PageState.start);

  Future start() async {
    UserModel user = UserModel();
    state.value = PageState.loading;
    try {
      usuarios = user.getUsuario();
      sugestaoUsuarios = user.getSugestaoUsuario();
      state.value = PageState.success;
    } catch (e) {
      state.value = PageState.error;
    }
  }
}

enum PageState { start, loading, success, searching, error }

import 'package:flutter/material.dart';
import 'package:teste_api/controller/user_controller.dart';
import 'package:teste_api/widget/custom_search_delegate.dart';

// ignore: use_key_in_widget_constructors
class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = UserController();
  String resultadoPesquisa = 'Resultado da Pesquisa';
  _success() {
    return SizedBox(
      child: ListView.builder(
        itemCount: controller.usuarios.length,
        itemBuilder: (context, index) {
          var user = controller.usuarios[index];
          return ListTile(
            title: Text(user),
          );
        },
      ),
    );
  }

  _loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  _error() {
    return Center(
        child: ElevatedButton(
      onPressed: () {
        controller.start();
      },
      child: const Text('Tentar novamente'),
    ));
  }

  _start() {
    return Container();
  }

  stateManagement(PageState state) {
    switch (state) {
      case PageState.success:
        return _success();
      case PageState.loading:
        return _loading();
      case PageState.error:
        return _error();
      case PageState.start:
        return _start();
      default:
        return _start();
    }
  }

  @override
  void initState() {
    super.initState();
    controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Barra de Pesquisa'),
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                final restulado = await showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                    todosUsuarios: controller.usuarios,
                    sugestaoUsuarios: controller.sugestaoUsuarios,
                  ),
                );
                setState(() {
                  resultadoPesquisa = restulado;
                });
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(resultadoPesquisa),
            Expanded(
              child: AnimatedBuilder(
                animation: controller.state,
                builder: (context, child) {
                  return stateManagement(controller.state.value);
                },
              ),
            ),
          ],
        ));
  }
}

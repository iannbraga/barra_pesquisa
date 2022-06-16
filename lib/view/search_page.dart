import 'package:flutter/material.dart';
import 'package:teste_api/controller/user_controller.dart';

// ignore: use_key_in_widget_constructors
class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = UserController();

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
          title: Text('Barra de Pesquisa'),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                    todoUsuarios: controller.usuarios,
                    sugestaoUsuarios: controller.sugestaoUsuarios,
                  ),
                );
              },
              icon: Icon(Icons.search),
            )
          ],
        ),
        body: AnimatedBuilder(
          animation: controller.state,
          builder: (context, child) {
            return stateManagement(controller.state.value);
          },
        ));
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List<String> todoUsuarios;
  final List<String> sugestaoUsuarios;

  CustomSearchDelegate(
      {required this.todoUsuarios, required this.sugestaoUsuarios});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<String> sugestaoUsuarios = todoUsuarios
        .where(
          (usuario) => usuario.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
    return ListView.builder(
      itemCount: sugestaoUsuarios.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(sugestaoUsuarios[index]),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> todos = todoUsuarios
        .where(
          (usuario) => usuario.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(todos[index]),
        );
      },
    );
  }
}

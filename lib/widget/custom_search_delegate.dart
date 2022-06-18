import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<String> todosUsuarios;
  final List<String> sugestaoUsuarios;
  int count = 0;

  CustomSearchDelegate(
      {required this.todosUsuarios, required this.sugestaoUsuarios});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (count == 0 && query.isNotEmpty) {
            query = '';
          } else {
            count = 0;
            close(context, null);
          }
          count = count + 1;
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // widget unico a esquerda
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back_ios_new),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> newsResults = todosUsuarios
        .where((element) => element.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: newsResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            newsResults[index],
          ),
          onTap: () {
            query = newsResults[index];
            close(context, query);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> newsSugestions = sugestaoUsuarios
        .where(
          (element) => element.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();

    return ListView.builder(
      itemCount: newsSugestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            newsSugestions[index],
          ),
          onTap: () {
            query = newsSugestions[index];
            close(context, query);
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

import 'view_content.dart';
import 'widgets/postcard.dart'; 


class Post {
  final String category;
  final String imageUrl;
  final String title;
  final String content;

  Post(this.category, this.imageUrl, this.title, this.content);
}

List<Post> posts = [
  Post('Educação', 'https://via.placeholder.com/150', 'Título do Post 1', 'Conteúdo do post 1...'),
  Post('Lazer', 'https://via.placeholder.com/150', 'Título do Post 2', 'Conteúdo do post 2...'),
  Post('Desenvolvimento', 'https://via.placeholder.com/150', 'Título do Post 3', 'Conteúdo do post 3...'),
  // Adicione mais posts conforme necessário
];

class ContentPageList extends StatefulWidget {
  const ContentPageList({super.key});

  @override
  _ContentPageListState createState() => _ContentPageListState();
}

class _ContentPageListState extends State<ContentPageList> {
  List<String> selectedCategories = []; // Lista de categorias selecionadas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todos os conteúdos',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filtro de Categorias
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  categoryButton('Educação'),
                  categoryButton('Lazer'),
                  categoryButton('Desenvolvimento'),
                  categoryButton('Higiene'),
                  categoryButton('Brincadeiras'),
                  categoryButton('Dúvidas'),
                ],
              ),
            ),
            // Lista de Cards (aqui onde os posts são exibidos)
            Expanded(
              child: ListView.builder(
                itemCount: filteredPosts.length, // Exibe a quantidade de posts filtrados
                itemBuilder: (context, index) {
                  final post = filteredPosts[index]; 
                  return GestureDetector(
                    onTap: () {
                      // Navega para a página de visualização de conteúdo
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContentPage(),
                        ),
                      );
                    },
                    child: PostCard(
                      post: post, // Passa o post para o PostCard
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Filtro de posts com base nas categorias selecionadas
  List<Post> get filteredPosts {
    if (selectedCategories.isEmpty) {
      return posts; // Exibe todos os posts se nenhuma categoria for selecionada
    }
    return posts.where((post) => selectedCategories.contains(post.category)).toList();
  }

  // Filtro de categorias para adicionar ou remover da lista de categorias selecionadas
  Widget categoryButton(String category) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(category),
        selected: selectedCategories.contains(category),
        onSelected: (isSelected) {
          setState(() {
            if (isSelected) {
              selectedCategories.add(category); // Adiciona categoria à lista
            } else {
              selectedCategories.remove(category); // Remove categoria da lista
            }
          });
        },
      ),
    );
  }
}

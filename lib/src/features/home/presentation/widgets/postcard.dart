import 'package:flutter/material.dart';

import '../list_contents.dart';

// class Post {
//   final String category;
//   final String imageUrl;
//   final String title;
//   final String content;

//   Post(this.category, this.imageUrl, this.title, this.content);
// }

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          // Imagem do post
          SizedBox(
            width: 120,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(post.imageBase64,
                  fit: BoxFit.cover), // Imagem do conteúdo
            ),
          ),
          // Conteúdo do post
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Categoria do post
                  Text(
                    post.tags,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Título do post
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Início do conteúdo
                  Text(post.content,
                      maxLines: 3, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

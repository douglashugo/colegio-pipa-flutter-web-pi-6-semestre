import 'dart:convert'; // Para lidar com Base64
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Post {
  final String tags;
  final String imageBase64;
  final String title;
  final String content;

  Post(this.tags, this.imageBase64, this.title, this.content);

  factory Post.fromMap(Map<String, dynamic> data) {
    return Post(
      data['tags']['title'] ?? 'Sem tag', // Título da tag associada
      data['images']['image'] ?? '', // Base64 da imagem do join com images
      data['title'] ?? 'Sem título',
      data['description'] ?? '',
    );
  }
}

class ContentPageList extends StatefulWidget {
  const ContentPageList({super.key});

  @override
  _ContentPageListState createState() => _ContentPageListState();
}

class _ContentPageListState extends State<ContentPageList> {
  final List<Post> _posts = [];
  bool _isLoading = true;
  String? _errorMessage; // Para exibir erros

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    try {
      final response = await Supabase.instance.client
          .from('posts_categories')
          .select('*, tags(title), images(image)') // Join com tags e images
          .neq('cat_id', 5);

      if (response == null) {
        throw response;
      }

      final data = response as List<dynamic>?;

      if (data == null || data.isEmpty) {
        // Se não houver dados, ajuste o estado
        setState(() {
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _posts.clear();
        _posts.addAll(data.map((e) => Post.fromMap(e)).toList());
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Erro inesperado: $e';
      });
      print('Erro inesperado: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todos os conteúdos',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                )
              : _posts.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhum conteúdo encontrado.',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(16),
                      child: ListView.builder(
                        itemCount: _posts.length,
                        itemBuilder: (context, index) {
                          final post = _posts[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            elevation: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (post.imageBase64.isNotEmpty)
                                  Image.memory(
                                    base64Decode(post.imageBase64),
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        post.title,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        post.content,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(height: 8),
                                      Chip(
                                        label: Text(post.tags),
                                        backgroundColor: Colors.blue.shade100,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
    );
  }
}

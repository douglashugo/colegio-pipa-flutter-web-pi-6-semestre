import 'dart:math';

import 'package:flutter/material.dart';

import '../domain/model/post_model.dart';
import 'aviso_register.dart';
import 'content_register.dart';
import 'register_responsavel.dart';
import 'widgets/m3card.dart';

class HomeContentView extends StatelessWidget {
  const HomeContentView({
    super.key,
    required this.avisos,
    required this.lembretes,
  });

  final List<PostModel> avisos;
  final List<PostModel> lembretes;

 @override
Widget build(BuildContext context) {
  return CustomScrollView(
    slivers: [
      SliverAppBar(
        pinned: true,
        title: Row(
          children: [
            // Exibe o logo do colégio
            
            Image.asset(
              'assets/images/logo.png', // Substitua pelo caminho correto do arquivo do logo
              height: 40, // Altura da imagem
            ),
            const SizedBox(width: 16),
            const Text(
              'Central de controle | Colégio Pipa',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Botão Novo Aviso
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterNoticePage(),
                  ),
                );
                },
                icon: const Icon(Icons.add),
                label: const Text('Novo aviso'),
              ),
              const SizedBox(height: 16), // Espaçamento entre os botões
              // Botão Novo Conteúdo
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterContentPage(),
                  ),
                );
                },
                icon: const Icon(Icons.add),
                label: const Text('Novo conteúdo'),
              ),
              const SizedBox(height: 16),
              // Botão Novo Usuário
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterResponsiblePage(),
                  ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Novo usuário'),
              ),
            ],
          ),
        ),
      ),
      const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
          child: Text(
            'Avisos',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: avisos.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              PostModel aviso = avisos[index];
              return M3Card(
                post: aviso,
                width: 400,
                title: '',
                content: '',
              );
            },
          ),
        ),
      ),
      const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
          child: Text(
            'Conteúdos',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: avisos.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              PostModel aviso = avisos[index];
              return M3Card(
                post: aviso,
                width: 400,
                title: '',
                content: '',
              );
            },
          ),
        ),
      ),
    ],
  );
}

} 
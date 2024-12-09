import 'dart:math';
import 'package:flutter/material.dart';
import '../domain/model/post_model.dart';
import 'aviso_register.dart';
import 'content_register.dart';
import 'register_responsavel.dart';
import 'widgets/m3card.dart';

class HomeContentView extends StatelessWidget {
  HomeContentView(
      {super.key,
      required List<PostModel> lembretes,
      required List<PostModel> avisos});

  // Lista estática de Avisos
  final List<PostModel> avisos = [
    PostModel(
        title: 'II Arriá Pipa!',
        content: 'Prepare-se para uma tarde cheia de diversão no nosso Arraiá!',
        imageUrl:
            'https://media.istockphoto.com/id/2158431114/pt/foto/traditional-straw-hat-for-decoration-brazilian-festival-of-s%C3%A3o-jo%C3%A3o-and-festa-junina.jpg?s=2048x2048&w=is&k=20&c=vcZ6EcyV7-b8gt4mOZaw6pY8-Mq29Qj4rsV6cs2OqkA='),
    PostModel(
        title: 'Ajude-nos a fazer a diferença! 🌟',
        content: 'Somos ponto de coleta!',
        imageUrl:
            'https://media.istockphoto.com/id/1372606861/pt/foto/volunteers-hand-giving-donations-to-a-person-at-a-community-center.jpg?s=2048x2048&w=is&k=20&c=8U-U1VTyCNZlKLHRu4gOD8jZYoZp5cq3V5C9EhhDHf8='),
    PostModel(
        title: 'Volta às aulas',
        content: 'Nosso ano letivo iniciará normalmente amanhã, dia 15/02.',
        imageUrl:
            'https://images.unsplash.com/photo-1513542789411-b6a5d4f31634?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
  ];

  // Lista estática de Lembretes
  final List<PostModel> lembretes = [
    PostModel(
        title: 'Brincadeiras com bolas ajudam no Desenvolvimento Infantil',
        content: '09/12/2024',
        imageUrl:
            'https://images.pexels.com/photos/8034610/pexels-photo-8034610.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
    PostModel(
        title:
            'Atividades divertidas que aceleram o Desenvolvimento das Crianças',
        content: '08/12/2024',
        imageUrl:
            'https://images.pexels.com/photos/296301/pexels-photo-296301.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
    PostModel(
        title: 'Lanches Saudáveis: Opções nutritivas para o dia a dia',
        content: '07/12/2024',
        imageUrl:
            'https://images.pexels.com/photos/1092730/pexels-photo-1092730.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          title: Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 40,
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
                const SizedBox(height: 16),
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
                  title: aviso.title,
                  content: aviso.content,
                  imagePath: aviso.imageUrl,
                );
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
            child: Text(
              'Lembretes',
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
              itemCount: lembretes.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                PostModel lembrete = lembretes[index];
                return M3Card(
                  post: lembrete,
                  width: 400,
                  title: lembrete.title,
                  content: lembrete.content,
                  imagePath: lembrete.imageUrl,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

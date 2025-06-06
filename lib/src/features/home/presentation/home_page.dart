import 'package:flutter/material.dart';
import '../domain/model/post_model.dart';
import 'aviso_register.dart';
import 'content_register.dart';
import 'home_content_view.dart';
import 'list_avisos.dart';
import 'list_contents.dart';
import 'register_responsavel.dart';
import 'upload_cardapio.dart';
import 'view_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Lista de páginas
  final List<Widget> pages = [
    HomeContentView(
      avisos: [
        PostModel(
          title: 'Aviso 1',
          content: 'Este é o conteúdo do aviso 1.',
          imageUrl: 'https://picsum.photos/200/300',
        ),
        PostModel(
          title: 'Aviso 2',
          content: 'Este é o conteúdo do aviso 2.',
          imageUrl: 'https://picsum.photos/200/300',
        ),
        PostModel(
          title: 'Aviso 3',
          content: 'Este é o conteúdo do aviso 3.',
          imageUrl: 'https://picsum.photos/200/300',
        ),
      ],
      lembretes: [
        PostModel(
          title: 'Lembrete 1',
          content: 'Este é o conteúdo do lembrete 1.',
          imageUrl: 'https://picsum.photos/200/300',
        ),
        PostModel(
          title: 'Lembrete 2',
          content: 'Este é o conteúdo do lembrete 2.',
          imageUrl: 'https://picsum.photos/200/300',
        ),
        PostModel(
          title: 'Lembrete 3',
          content: 'Este é o conteúdo do lembrete 3.',
          imageUrl: 'https://picsum.photos/200/300',
        ),
      ],
    ),
    NoticesPage(),
    RegisterNoticePage(),
    ContentPageList(),
    RegisterContentPage(),
    RegisterResponsiblePage(),
    CardapioUploadScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Navigation Rail
          NavigationRail(
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo.png'),
                maxRadius: 35,
              ),
            ),
            trailing: Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [],
              ),
            ),
            selectedIndex: _selectedIndex,
            labelType: NavigationRailLabelType.all,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index; // Atualiza a página selecionada
              });
            },
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                selectedIcon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.notification_important),
                selectedIcon: Icon(Icons.notification_important),
                label: Text('Avisos'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.notification_add_rounded),
                selectedIcon: Icon(Icons.notification_add_rounded),
                label: Text('Novo aviso'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.article),
                selectedIcon: Icon(Icons.article),
                label: Text('Conteúdos'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add_circle_sharp),
                selectedIcon: Icon(Icons.add_circle_sharp),
                label: Text('Novo Conteúdo'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add_reaction_rounded),
                selectedIcon: Icon(Icons.add_reaction_rounded),
                label: Text('Adicionar usuário'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.upload_file),
                selectedIcon: Icon(Icons.upload_file),
                label: Text('Upload de Cardápio'),
              ),
            ],
          ),

          // Divider between Navigation Rail and Content
          const VerticalDivider(thickness: 2, width: 2),

          // Page Content
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: pages,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_pipa_web/src/core/contants.dart';
import 'package:flutter_application_pipa_web/src/pages/create_post.dart';
import 'package:flutter_application_pipa_web/src/pages/login.dart';
import 'package:flutter_application_pipa_web/src/pages/register_user.dart';
import 'package:flutter_application_pipa_web/src/pages/user_edit.dart';
import 'package:flutter_application_pipa_web/src/pages/user_management.dart';
import 'package:flutter_application_pipa_web/src/providers/app_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Colégio PIPA Web',
      theme: ref.watch(themeSwitchProvider) ? kLightTheme : kDarkTheme,
      home: UserManagementPage(), // Página inicial
    );
  }
}

class UserManagementPage extends StatefulWidget {
  @override
  _UserManagementPageState createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  List<User> users = [
    User(id: 1, name: 'João Silva', email: 'joao.silva@example.com'),
    User(id: 2, name: 'Maria Oliveira', email: 'maria.oliveira@example.com'),
    User(id: 3, name: 'Carlos Souza', email: 'carlos.souza@example.com'),
  ];

  void _editUser(User user) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditUserPage(user: user), // Navegação para edição
      ),
    );
  }

  void _viewUser(User user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Detalhes do Usuário'),
          content: Text('Nome: ${user.name}\nEmail: ${user.email}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  void _deleteUser(int userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Exclusão'),
          content: Text('Você tem certeza que deseja excluir este usuário?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  users.removeWhere((user) => user.id == userId);
                });
                Navigator.of(context).pop();
              },
              child: Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Gerenciar Usuários')),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: () => _viewUser(user), // Visualizar usuário
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editUser(user), // Editar usuário
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteUser(user.id), // Deletar usuário
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class EditUserPage extends StatelessWidget {
  final User user;

  EditUserPage({required this.user}); // Requer um usuário

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Usuário')),
      body: Center(child: Text('Editar ${user.name}')),
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});
}

import 'package:flutter/material.dart';
import 'package:flutter_application_pipa_web/src/core/contants.dart';
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
    User(id: 1, name: 'João Silva', email: 'joao.silva@example.com', phone_number: '', cpf: '', password: ''),
    User(id: 2, name: 'Maria Oliveira', email: 'maria.oliveira@example.com', phone_number: '', cpf: '', password: ''),
    User(id: 3, name: 'Carlos Souza', email: 'carlos.souza@example.com', phone_number: '', cpf: '', password: ''),
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isLargeScreen = constraints.maxWidth > 800;
          return Center(
            child: Container(
              width: isLargeScreen ? 800 : double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
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
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class EditUserPage extends StatefulWidget {
  final User user;

  EditUserPage({required this.user}); // Requer um usuário

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nomeController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _handleUpdate() {
    if (_formKey.currentState!.validate()) {
      // Atualiza os dados do usuário
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário atualizado com sucesso!')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Usuário')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isLargeScreen = constraints.maxWidth > 600;
          return Center(
            child: Container(
              width: isLargeScreen ? 600 : double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _nomeController,
                      decoration: InputDecoration(labelText: 'Nome'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, insira o nome do usuário.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, insira um email.';
                        } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Por favor, insira um email válido.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _handleUpdate,
                      child: Text('Salvar Alterações'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String phone_number;
  final String cpf;
  final String password;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone_number,
    required this.cpf,
    required this.password,
  });
}

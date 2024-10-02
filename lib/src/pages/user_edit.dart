import 'package:flutter/material.dart';

class EditUserPage extends StatefulWidget {
  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final _formKey = GlobalKey<FormState>();

  // Dados mockados para o usuário
  final User _mockUser = User(
    id: 1,
    name: 'João Silva',
    email: 'joao.silva@example.com',
    phone_number: '11999999999',
    cpf: '12345678901',
    password: '123456',
  );

  late TextEditingController _nomeController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _cpfController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    // Inicializa os controladores com os dados mockados do usuário
    _nomeController = TextEditingController(text: _mockUser.name);
    _emailController = TextEditingController(text: _mockUser.email);
    _phoneController = TextEditingController(text: _mockUser.phone_number);
    _cpfController = TextEditingController(text: _mockUser.cpf);
    _passwordController = TextEditingController(text: _mockUser.password);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cpfController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleUpdate() {
    if (_formKey.currentState!.validate()) {
      // Atualiza os dados do usuário (mockado) com os valores dos campos
      setState(() {
        _mockUser.name = _nomeController.text;
        _mockUser.email = _emailController.text;
        _mockUser.phone_number = _phoneController.text;
        _mockUser.cpf = _cpfController.text;
        _mockUser.password = _passwordController.text;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário atualizado com sucesso!')),
      );

      Navigator.of(context).pop(); // Volta para a tela anterior após editar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Editar Usuário')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Usando LayoutBuilder para ajustar o layout com base no tamanho da tela
          bool isLargeScreen = constraints.maxWidth > 600;

          return Center(
            child: Container(
              width: isLargeScreen ? 600 : double.infinity,
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _nomeController,
                      decoration: InputDecoration(labelText: 'Nome'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, insira um nome.';
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
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(labelText: 'Telefone'),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, insira um número de telefone.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _cpfController,
                      decoration: InputDecoration(labelText: 'CPF'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, insira o CPF.';
                        } else if (value.length != 11) {
                          return 'O CPF deve ter 11 dígitos.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'Senha'),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, insira uma senha.';
                        } else if (value.length < 6) {
                          return 'A senha deve ter pelo menos 6 caracteres.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _handleUpdate,
                      child: Text('Atualizar'),
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

// Classe do modelo User com dados mockados
class User {
  int id;
  String name;
  String email;
  String phone_number;
  String cpf;
  String password;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone_number,
    required this.cpf,
    required this.password,
  });
}

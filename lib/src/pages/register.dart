import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _repetirSenhaController = TextEditingController();

  bool passwordError = false;
  bool cadastroSucesso = false;
  bool erroCadastro = false;
  String formError = '';
  String permissionSelecionada = '';
  List<String> permission = ["Comum", "Admin"];

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _cpfController.dispose();
    _senhaController.dispose();
    _repetirSenhaController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    setState(() {
      formError = '';
    });

    if (_nomeController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _telefoneController.text.isEmpty ||
        _cpfController.text.isEmpty ||
        permissionSelecionada.isEmpty ||
        _senhaController.text.isEmpty ||
        _repetirSenhaController.text.isEmpty) {
      setState(() {
        formError = 'Por favor, preencha todos os campos';
      });
      return;
    }

    if (_senhaController.text != _repetirSenhaController.text) {
      setState(() {
        passwordError = true;
      });
      return;
    }

    Map<String, dynamic> requestBody = {
      'name': _nomeController.text,
      'email': _emailController.text,
      'phone_number': _telefoneController.text,
      'cpf': _cpfController.text,
      'permission_id': _getPermissionId(permissionSelecionada),
      'password': _senhaController.text,
    };

    try {
      final response = await http.post(
        Uri.parse('https://colegiopipabackend.brunorisso.com/api/users'),
        body: jsonEncode(requestBody),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        setState(() {
          cadastroSucesso = true;
          erroCadastro = false;
        });
      } else {
        setState(() {
          erroCadastro = true;
          cadastroSucesso = false;
        });
      }
    } catch (error) {
      setState(() {
        erroCadastro = true;
        cadastroSucesso = false;
      });
    }
  }

  int? _getPermissionId(String tipoUsuario) {
    Map<String, int> permissionId = {
      "Admin": 1,
      "Comum": 2,
    };
    return permissionId[tipoUsuario];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Cadastrar Usuário')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: screenWidth < 600
                        ? screenWidth * 0.9
                        : 800, // Responsivo para Web e Mobile
                  ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nomeController,
                      decoration: InputDecoration(labelText: 'Nome'),
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextFormField(
                      controller: _telefoneController,
                      decoration: InputDecoration(labelText: 'Telefone'),
                    ),
                    TextFormField(
                      controller: _cpfController,
                      decoration: InputDecoration(labelText: 'CPF'),
                    ),
                    DropdownButtonFormField<String>(
                      value: permissionSelecionada.isEmpty
                          ? null
                          : permissionSelecionada,
                      decoration: InputDecoration(labelText: 'Tipo de Usuário'),
                      items: permission.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          permissionSelecionada = newValue!;
                        });
                      },
                    ),
                    TextFormField(
                      controller: _senhaController,
                      decoration: InputDecoration(labelText: 'Senha'),
                      obscureText: true,
                    ),
                    TextFormField(
                      controller: _repetirSenhaController,
                      decoration: InputDecoration(
                        labelText: 'Repetir Senha',
                        errorText: passwordError ? 'Senhas divergentes!' : null,
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _handleSubmit,
                      child: Text('Cadastrar'),
                    ),
                    if (cadastroSucesso)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Usuário cadastrado com sucesso!',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    if (erroCadastro)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Ocorreu um erro ao cadastrar o usuário.',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    if (formError.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          formError,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

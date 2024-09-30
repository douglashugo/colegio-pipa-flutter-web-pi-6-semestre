import 'package:flutter/material.dart';

class EditUserPage extends StatefulWidget {
  final User user;

  EditUserPage(Set<dynamic> set, {required this.user});

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
      // Aqui você pode fazer a lógica para atualizar os dados do usuário
      print('Atualizando usuário: ${_nomeController.text}, ${_emailController.text}');
      // Depois de atualizar, talvez você queira retornar à página anterior
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Editar Usuário')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
  }
}

class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});
}

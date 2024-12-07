import 'package:flutter/material.dart';

import 'register_aluno.dart';

class RegisterResponsiblePage extends StatefulWidget {
  const RegisterResponsiblePage({super.key});

  @override
  State<RegisterResponsiblePage> createState() =>
      _RegisterResponsiblePageState();
}

class _RegisterResponsiblePageState extends State<RegisterResponsiblePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _homeAddressController = TextEditingController();
  final TextEditingController _workAddressController = TextEditingController();
  final TextEditingController _primaryContactController =
      TextEditingController();
  final TextEditingController _secondaryContactController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro do Responsável'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome completo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome completo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dobController,
                decoration: const InputDecoration(labelText: 'Data de nascimento'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a data de nascimento';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cpfController,
                decoration: const InputDecoration(labelText: 'CPF'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o CPF';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _homeAddressController,
                decoration: const InputDecoration(labelText: 'Endereço residencial'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o endereço residencial';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _workAddressController,
                decoration: const InputDecoration(
                    labelText: 'Endereço comercial (opcional)'),
              ),
              TextFormField(
                controller: _primaryContactController,
                decoration: const InputDecoration(labelText: 'Contato principal'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o contato principal (WhatsApp/Celular) ';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _secondaryContactController,
                decoration: const InputDecoration(
                    labelText: 'Contato secundário (opcional)'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email principal'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o email principal';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterStudentPage(
                          responsibleName: _nameController.text,
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Continuar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

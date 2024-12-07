import 'package:flutter/material.dart';

class RegisterStudentPage extends StatefulWidget {
  final String responsibleName;

  const RegisterStudentPage({super.key, required this.responsibleName});

  @override
  State<RegisterStudentPage> createState() => _RegisterStudentPageState();
}

class _RegisterStudentPageState extends State<RegisterStudentPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _homeAddressController = TextEditingController();
  final TextEditingController _primaryContactController =
      TextEditingController();
  final TextEditingController _secondaryContactController =
      TextEditingController();
  final TextEditingController _healthObservationsController =
      TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _responsible2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro do Aluno'),
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
                decoration: const InputDecoration(labelText: 'CPF (opcional)'),
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
                controller: _primaryContactController,
                decoration: const InputDecoration(labelText: 'Contato principal'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o contato principal';
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
                controller: _healthObservationsController,
                decoration: const InputDecoration(
                    labelText: 'Observações de saúde (opcional)'),
                maxLines: 3,
              ),
              TextFormField(
                controller: _classController,
                decoration: const InputDecoration(labelText: 'Turma'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a turma';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Lógica de salvar no banco
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cadastro realizado com sucesso!')),
                    );
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }
                },
                child: const Text('Finalizar Cadastro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

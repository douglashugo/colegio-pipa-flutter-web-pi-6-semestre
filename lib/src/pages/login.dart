import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  bool _passwordVisible = false;

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // Lógica de autenticação
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Realizado com Sucesso')));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Pegando a largura total da tela
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Image.asset('../assets/images/logo-pipa.png'), // Imagem do logo
              ),
              const SizedBox(height: 20),
              // Usando ConstrainedBox para limitar o tamanho máximo do formulário
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: screenWidth < 600 ? screenWidth * 0.9 : 400, // Responsivo para Web e Mobile
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Usuário',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira seu usuário';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _username = value ?? '';
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                            ),
                            obscureText: !_passwordVisible,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira sua senha';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _password = value ?? '';
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _submit,
                            child: const Text('Login'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 50), // Botão ocupa a largura inteira
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

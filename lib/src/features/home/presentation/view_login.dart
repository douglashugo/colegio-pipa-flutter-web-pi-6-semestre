import 'package:f290_ldmp_web_desktop_playground/src/features/home/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  bool _passwordVisible = false;

  final SupabaseClient _supabaseClient = SupabaseClient(
    dotenv.env['SB_URL']!,
    dotenv.env['SB_ANON_KEY']!,
  );

  void _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      try {
        // Verifica o login
        final response = await _supabaseClient
            .from('users')
            .select()
            .eq('email', _username)
            .eq('senha', _password)
            .maybeSingle();

        final user = response;

        if (user == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Credenciais inválidas')),
          );
          return;
        }

        // Consulta as permissões do usuário
        final rolesResponse = await _supabaseClient
            .from('user_roles')
            .select('roles(name)')
            .eq('user_id', user['id']);

        final rolesData = rolesResponse as List<dynamic>;

        if (rolesData.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Nenhuma permissão atribuída ao usuário')),
          );
          return;
        }

        // Extrai as permissões
        final roles = rolesData.map((role) => role['roles']['name']).toList();

        // Cria um objeto com o usuário e as permissões
        final userWithRoles = {
          'user': user,
          'roles': roles,
        };

        // Redireciona com base na permissão
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao fazer login: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Login',
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Image.asset('assets/images/logo.png'),
              ),
              const SizedBox(height: 20),
              Card(
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
                            minimumSize: const Size(
                                double.infinity, 50), // Largura total
                          ),
                        ),
                      ],
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

import 'package:flutter/material.dart';

class RegisterNoticePage extends StatefulWidget {
  @override
  _RegisterNoticePageState createState() => _RegisterNoticePageState();
}

class _RegisterNoticePageState extends State<RegisterNoticePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String? _imagePath;
  bool _isSubmitSuccess = false;

  // Função para simular o envio ao banco de dados
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Suponha que aqui conectamos ao banco de dados e enviamos as informações
      print('Título: ${_titleController.text}');
      print('Conteúdo: ${_contentController.text}');
      print('Imagem: $_imagePath');
      setState(() {
        _isSubmitSuccess = true; // Mostrar a mensagem de sucesso
      });
      // Aqui entraria o código para salvar no banco de dados
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      appBar: AppBar(
        title: Text(''),
         
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título da página
                      Center(
                        child: Text(
                          'Cadastrar novo aviso',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 16),
                      // Campo para título
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Título do Aviso',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Por favor, insira o título do aviso'
                            : null,
                      ),
                      SizedBox(height: 16),
                      // Campo para conteúdo (sem formatação)
                      TextFormField(
                        controller: _contentController,
                        maxLines: 8,
                        decoration: InputDecoration(
                          labelText: 'Conteúdo do Aviso',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Por favor, insira o conteúdo do aviso'
                            : null,
                      ),
                      SizedBox(height: 16),
                      // Campo para upload de imagem 
                      ElevatedButton.icon(
                        onPressed: () {
                          // Implementar o upload de imagem 
                          setState(() {
                            _imagePath = 'imagem_teste.jpg'; // Simulação
                          });
                        },
                        icon: Icon(Icons.upload),
                        label: Text('Fazer upload da imagem'),
                        style: ElevatedButton.styleFrom(
                        ),
                      ),
                      if (_imagePath != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Imagem selecionada: $_imagePath'),
                        ),
                      SizedBox(height: 16),
                      // Botão de enviar
                      Center(
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          child: Text('Enviar'),
                          style: ElevatedButton.styleFrom(
                          ),
                        ),
                      ),
                      if (_isSubmitSuccess)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            'Aviso enviado com sucesso!',
                            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

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
      print('Título: ${_titleController.text}');
      print('Conteúdo: ${_contentController.text}');
      print('Imagem: $_imagePath');
      setState(() {
        _isSubmitSuccess = true; // Mostrar a mensagem de sucesso
      });
    }
  }

  // Função para abrir o FilePicker e selecionar uma imagem
  Future<void> _selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _imagePath = result.files.single.path!;
      });
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
                      ElevatedButton.icon(
                        onPressed: _selectImage,
                        icon: Icon(Icons.upload),
                        label: Text('Fazer upload da imagem'),
                      ),
                      if (_imagePath != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Imagem selecionada: $_imagePath'),
                        ),
                      SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          child: Text('Enviar'),
                        ),
                      ),
                      if (_isSubmitSuccess)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            'Aviso enviado com sucesso!',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
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

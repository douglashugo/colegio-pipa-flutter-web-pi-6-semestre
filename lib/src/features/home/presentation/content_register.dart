import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class RegisterContentPage extends StatefulWidget {
  @override
  _RegisterContentPageState createState() => _RegisterContentPageState();
}

class _RegisterContentPageState extends State<RegisterContentPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _youtubeLinkController = TextEditingController(); // Novo controlador
  String? _imagePath;

  // Lista de categorias
  final _categories = [
    'Educação',
    'Lazer',
    'Desenvolvimento',
    'Higiene',
    'Brincadeiras',
    'Dúvidas',
  ];

  // Função para simular envio ao banco de dados
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Simulação de envio
      print('Categoria: $_selectedCategory');
      print('Título: ${_titleController.text}');
      print('Conteúdo: ${_contentController.text}');
      print('Link do YouTube: ${_youtubeLinkController.text}');
      print('Imagem: $_imagePath');
    }
  }

  // Função para selecionar uma imagem
  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _imagePath = result.files.first.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
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
                          'Cadastrar novo conteúdo',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 16),
                      // Dropdown para categoria
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Categoria',
                          border: OutlineInputBorder(),
                        ),
                        value: _selectedCategory,
                        items: _categories
                            .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        validator: (value) => value == null
                            ? 'Por favor, selecione uma categoria'
                            : null,
                      ),
                      SizedBox(height: 16),
                      // Campo para título
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Título',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Por favor, insira um título'
                            : null,
                      ),
                      SizedBox(height: 16),
                      // Campo para conteúdo
                      TextFormField(
                        controller: _contentController,
                        maxLines: 8,
                        decoration: InputDecoration(
                          labelText: 'Conteúdo',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Por favor, insira o conteúdo'
                            : null,
                      ),
                      SizedBox(height: 16),
                      // Novo campo para link do YouTube
                      TextFormField(
                        controller: _youtubeLinkController,
                        decoration: InputDecoration(
                          labelText: 'Link do YouTube',
                          border: OutlineInputBorder(),
                          hintText: 'https://www.youtube.com/watch?v=...',
                        ),
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            final urlPattern = RegExp(
                                r'^(https?\:\/\/)?(www\.youtube\.com|youtu\.?be)\/.+$');
                            if (!urlPattern.hasMatch(value)) {
                              return 'Por favor, insira um link válido do YouTube.';
                            }
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      // Botão para upload de imagem
                      ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: Icon(Icons.image),
                        label: Text('Selecionar Imagem'),
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
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green,
                          ),
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

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert'; // Para manipulação de base64

class RegisterContentPage extends StatefulWidget {
  @override
  _RegisterContentPageState createState() => _RegisterContentPageState();
}

class _RegisterContentPageState extends State<RegisterContentPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedtag;
  int? _selectedTagId; // Para armazenar o ID da tag selecionada
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String? _imageBase64;
  int? _imageId;

  // Lista de tags será carregada do banco de dados
  List<Map<String, dynamic>> _tags = [];

  // Função para carregar as tags do banco de dados (Supabase)
  Future<void> _loadTags() async {
    final response =
        await Supabase.instance.client.from('tags').select('id, title');

    if (response != null) {
      final data = response as List<dynamic>;
      setState(() {
        _tags = data
            .map((tag) => {'id': tag['id'], 'title': tag['title']})
            .toList();
      });
    } else {
      print('Erro ao carregar as tags: ${response}');
    }
  }

  Future<void> _uploadImage() async {
    if (_imageBase64 != null) {
      final data = {
        'image': _imageBase64,
        'create_at': DateTime.now().toUtc().toIso8601String(),
        'update_at': DateTime.now().toUtc().toIso8601String(),
      };

      final response =
          await Supabase.instance.client.from('images').insert(data).select();

      if (response != null) {
        final data = response as List<dynamic>;
        setState(() {
          _imageId = data[0]['id']; // Atribui o ID da imagem retornado
        });
        print('Imagem carregada com sucesso, ID: $_imageId');
      } else {
        print('Erro ao carregar imagem: ${response}');
      }
    }
  }

  void _submitForm() async {
    if (_selectedTagId == null) {
      print("Por favor, selecione uma tag válida.");
      return; // Evitar inserir se nenhuma tag foi selecionada
    }

    if (_imageId == null) {
      print("Por favor, faça upload de uma imagem.");
      return; // Evitar inserir se a imagem não foi carregada
    }

    final data = {
      'title': _titleController.text,
      'description': _contentController.text,
      'cat_id': 3, // Categoria fixa para conteúdo
      'tag_id': _selectedTagId,
      'img_id': _imageId,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    };

    // A inserção no Supabase não deve incluir o id, pois o banco vai gerar automaticamente
    final response = await Supabase.instance.client
        .from('posts_categories')
        .insert(data)
        .select();

    if (response != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Conteúdo cadastrado com sucesso!'),
      ));
      print("Conteúdo cadastrado com sucesso!");
    } else {
      print('Erro ao cadastrar: ${response}');
    }
  }

  // Função para selecionar uma imagem e converter em base64
  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      final bytes = file.bytes;
      if (bytes != null) {
        setState(() {
          _imageBase64 = base64Encode(bytes); // Converte a imagem para base64
        });
        // Chama a função para fazer o upload da imagem
        await _uploadImage();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadTags(); // Carrega as tags do banco quando a tela for carregada
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
                      // Dropdown para categoria (tags carregadas do banco)
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Tag',
                          border: OutlineInputBorder(),
                        ),
                        value: _selectedtag,
                        items: _tags
                            .map((category) => DropdownMenuItem<String>(
                                  value: category['title'] as String,
                                  child: Text(category['title'] as String),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedtag = value;
                            // Buscar o id correspondente à tag selecionada
                            _selectedTagId = _tags.firstWhere(
                                (tag) => tag['title'] == value)['id'];
                          });
                        },
                        validator: (value) => value == null
                            ? 'Por favor, selecione uma tag'
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
                      // Botão para upload de imagem
                      ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: Icon(Icons.image),
                        label: Text('Selecionar Imagem'),
                      ),
                      if (_imageBase64 != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Imagem selecionada'),
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

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';

class RegisterNoticePage extends StatefulWidget {
  @override
  _RegisterNoticePageState createState() => _RegisterNoticePageState();
}

class _RegisterNoticePageState extends State<RegisterNoticePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String? _imageBase64;
  int? _imageId; // ID da imagem carregada

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
          _imageId = data[0]['id']; // Armazena o ID da imagem no estado
        });
        print('Imagem carregada com sucesso, ID: $_imageId');
      } else {
        print('Erro ao carregar imagem: $response');
      }
    }
  }

  void _submitForm() async {
    if (_imageId == null) {
      print("Por favor, faça upload de uma imagem.");
      return;
    }

    final data = {
      'title': _titleController.text,
      'description': _contentController.text,
      'cat_id': 5, // Categoria fixa para aviso
      'img_id': _imageId,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    };

    final response = await Supabase.instance.client
        .from('posts_categories')
        .insert(data)
        .select();

    if (response != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Aviso cadastrado com sucesso!'),
      ));
      print("Aviso cadastrado com sucesso!");
    } else {
      print('Erro ao cadastrar: $response');
    }
  }

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
          _imageBase64 = base64Encode(bytes); // Converte para base64
        });
        await _uploadImage(); // Faz o upload da imagem
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Aviso'),
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
                      Center(
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          child: Text('Enviar'),
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

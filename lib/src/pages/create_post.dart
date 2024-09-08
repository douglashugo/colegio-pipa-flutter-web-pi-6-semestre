import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // Para formData
import 'dart:html' as html; // Para acessar upload de arquivo no Flutter Web

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _formKey = GlobalKey<FormState>();
  String _titulo = '';
  String _descricao = '';
  String? _categoriaSelecionada;
  String? _tagSelecionada;
  html.File? _imagem;
  bool _imageLoaded = false;
  String? _formError;
  bool _showSuccessAlert = false;

  final List<String> categorias = ['Dicas', 'Avisos'];
  final List<String> tags = ['Alimentação', 'Atividade física'];

  final Map<String, String> categoriaParaId = {
    'Dicas': '1',
    'Avisos': '2',
  };

  final Map<String, String> tagsParaId = {
    'Alimentação': '1',
    'Atividade física': '2',
  };

  void handleSubmit() async {
    setState(() {
      _formError = null;
    });

    if (_titulo.isEmpty ||
        _descricao.isEmpty ||
        _categoriaSelecionada == null) {
      setState(() {
        _formError = "Por favor, preencha todos os campos";
      });
      return;
    }

    if (!_imageLoaded) {
      setState(() {
        _formError = "Por favor, carregue uma imagem";
      });
      return;
    }

    try {
      // Simulação de dados enviados
      final simulatedResponse = {
        'status': 'success',
        'message': 'Conteúdo publicado com sucesso!',
      };

      // Aqui substituímos a chamada real da API por um mock
      await Future.delayed(
          Duration(seconds: 2)); // Simula o tempo de resposta da API

      if (simulatedResponse['status'] == 'success') {
        setState(() {
          _showSuccessAlert = true;
          _titulo = '';
          _descricao = '';
          _categoriaSelecionada = null;
          _tagSelecionada = null;
          _imagem = null;
          _imageLoaded = false;
        });
      } else {
        setState(() {
          _formError = "Erro ao enviar o conteúdo. Por favor, tente novamente.";
        });
      }
    } catch (error) {
      setState(() {
        _formError = "Erro ao enviar o conteúdo. Por favor, tente novamente.";
      });
      print('Erro ao enviar conteúdo: $error');
    }
  }

  void handleImageChange(html.File? selectedImage) {
    if (selectedImage != null) {
      setState(() {
        _imagem = selectedImage;
        _imageLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Pegando a largura total da tela
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Conteúdo'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                //SizedBox(height: 20),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: screenWidth < 600
                        ? screenWidth * 0.9
                        : 800, // Responsivo para Web e Mobile
                  ),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Campo Título
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Título',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _titulo = value;
                                });
                              },
                            ),
                            SizedBox(height: 20),
                            // Campo Descrição
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Descrição',
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 4,
                              onChanged: (value) {
                                setState(() {
                                  _descricao = value;
                                });
                              },
                            ),
                            SizedBox(height: 20),
                            // Dropdown Categoria
                            DropdownButtonFormField<String>(
                              value: _categoriaSelecionada,
                              decoration: InputDecoration(
                                labelText: 'Categoria',
                                border: OutlineInputBorder(),
                              ),
                              items: categorias
                                  .map((categoria) => DropdownMenuItem(
                                        child: Text(categoria),
                                        value: categoria,
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _categoriaSelecionada = value;
                                });
                              },
                            ),
                            SizedBox(height: 20),
                            // Dropdown Tags
                            DropdownButtonFormField<String>(
                              value: _tagSelecionada,
                              decoration: InputDecoration(
                                labelText: 'Tags',
                                border: OutlineInputBorder(),
                              ),
                              items: tags
                                  .map((tag) => DropdownMenuItem(
                                        child: Text(tag),
                                        value: tag,
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _tagSelecionada = value;
                                });
                              },
                            ),
                            SizedBox(height: 20),
                            // Upload Imagem
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    html.FileUploadInputElement uploadInput =
                                        html.FileUploadInputElement();
                                    uploadInput.accept = 'image/*';
                                    uploadInput.click();

                                    uploadInput.onChange.listen((e) {
                                      final file = uploadInput.files!.first;
                                      handleImageChange(file);
                                    });
                                  },
                                  child: Text('Carregar imagem'),
                                ),
                                SizedBox(width: 10),
                                if (_imageLoaded && _imagem != null)
                                  Text(
                                    '${_imagem!.name} carregado com sucesso!',
                                    style: TextStyle(color: Colors.green),
                                  ),
                              ],
                            ),
                            SizedBox(height: 20),
                            // Botão de Publicar
                            ElevatedButton(
                              onPressed: handleSubmit,
                              child: Text('Publicar'),
                            ),
                            if (_formError != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(
                                  _formError!,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            if (_showSuccessAlert)
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(
                                  'Conteúdo publicado com sucesso!',
                                  style: TextStyle(color: Colors.green),
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
      ),
    );
  }
}

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CardapioUploadScreen extends StatefulWidget {
 @override
 _CardapioUploadScreenState createState() => _CardapioUploadScreenState();
}

class _CardapioUploadScreenState extends State<CardapioUploadScreen> {
 final TextEditingController _dataController = TextEditingController();
 Uint8List? _fileBytes;
 String? _fileName;

 Future<void> _selectFile() async {
 final result = await FilePicker.platform
 .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
 if (result != null && result.files.single.bytes != null) {
 setState(() {
 _fileBytes = result.files.single.bytes!;
 _fileName = result.files.single.name;
 });
 }
 }

 Future<void> _uploadFile() async {
 if (_fileBytes == null || _dataController.text.isEmpty) {
 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
 content: Text('Por favor, selecione um arquivo e informe a data.'),
 ));
 return;
 }

 try {
 // Upload do arquivo para o bucket
 await Supabase.instance.client.storage
 .from('bucket_pipa')
 .uploadBinary('uploads/$_fileName', _fileBytes!);

 // Obter URL pública do arquivo carregado
 final fileUrlResponse = Supabase.instance.client.storage
 .from('bucket_pipa')
 .getPublicUrl('uploads/$_fileName');

 final fileUrl = fileUrlResponse; // URL pública gerada

 // Dados a serem inseridos na tabela
 final data = {
 'file_path': fileUrl, // Salva a URL pública do arquivo
 'data_cardapio': _dataController.text,
 };

 // Inserção na tabela "cardapios"
 final insertResponse = await Supabase.instance.client
 .from('cardapios')
 .insert(data)
 .select();

 // Verificar se houve sucesso
 if (insertResponse.isEmpty) {
 throw 'Nenhum dado foi inserido.';
 }

 // Mostrar mensagem de sucesso
 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
 content: Text('Upload realizado com sucesso!'),
 ));
 } catch (e) {
 debugPrint(e.toString());
 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
 content: Text('Erro ao fazer upload: $e'),
 ));
 }
 }

 @override
 Widget build(BuildContext context) {
 return Scaffold(
 appBar: AppBar(
 title: const Text('Upload de Cardápio'),
 ),
 body: Padding(
 padding: const EdgeInsets.all(16.0),
 child: Column(
 children: [
 TextField(
 controller: _dataController,
 decoration: const InputDecoration(
 labelText: 'Data do Cardápio',
 hintText: 'Ex: 06/12/2024',
 border: OutlineInputBorder(),
 ),
 ),
 const SizedBox(height: 16),
 ElevatedButton.icon(
 onPressed: _selectFile,
 icon: const Icon(Icons.attach_file),
 label: Text(_fileName != null ? _fileName! : 'Selecionar PDF'),
 ),
 const SizedBox(height: 16),
 ElevatedButton(
 onPressed: _uploadFile,
 child: const Text('Fazer Upload'),
 ),
 ],
 ),
 ),
 );
 }
}


import 'package:flutter/material.dart';

class NoticePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Aviso'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Botão "Apagar" com ícone de lixeira
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _showDeleteConfirmationDialog(context);
                      },
                    ),
                    Text(
                      'Apagar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Card com o conteúdo do aviso
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // Imagem
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            'https://via.placeholder.com/400', // Imagem fictícia
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 16),
                        // Título
                        Text(
                          'Título do Aviso',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black87,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        // Data
                        Text(
                          '12/12/2024', // Exemplo de data
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                        ),
                        SizedBox(height: 16),
                        // Conteúdo
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla vehicula, erat ac suscipit condimentum, ligula felis dictum libero, eget dignissim lectus odio in nisi. Quisque scelerisque eros sed augue dignissim, nec vestibulum leo facilisis. Fusce sed ex euismod, volutpat urna et, condimentum nisi.',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                              ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
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

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Exclusão'),
          content: Text('Tem certeza de que deseja apagar este aviso?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Ação de apagar o aviso
                Navigator.of(context).pop(); // Fecha o diálogo
                _deleteNotice(context);
              },
              child: Text(
                'Apagar',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteNotice(BuildContext context) {
    // Substitua esta lógica pelo código para apagar o conteúdo no banco de dados
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Aviso apagado com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );
    // Exemplo: Redirecionar para outra página após apagar
    Navigator.pop(context);
  }
}

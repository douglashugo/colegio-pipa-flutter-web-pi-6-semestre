import 'package:flutter/material.dart';


class ContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
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
                    // Se houver imagem, exibe acima do título
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
                    // Título em negrito
                    Text(
                      'Título do Conteúdo',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    // Data abaixo do título
                    Text(
                      '12/12/2024', // Exemplo de data
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                    ),
                    SizedBox(height: 16),
                    // Conteúdo principal
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
          ),
        ),
      ),
    );
  }
}
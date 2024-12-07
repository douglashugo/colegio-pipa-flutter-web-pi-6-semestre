import 'package:flutter/material.dart';

import 'view_avisos.dart';

// Classe de aviso
class Notice {
  final String date; // Data do aviso
  final String title; // Título do aviso
  final String content; // Conteúdo do aviso

  Notice(this.date, this.title, this.content);
}

// Dados de exemplo
List<Notice> notices = [
  Notice('2024-12-06', 'Aviso Importante', 'Este é um aviso importante para todos.'),
  Notice('2024-12-05', 'Reunião da equipe', 'Reunião com todos os membros da equipe amanhã.'),
  Notice('2024-12-04', 'Novo horário de atendimento', 'A partir de agora, o horário de atendimento será das 9h às 18h.'),
];

// Página principal de avisos
class NoticesPage extends StatefulWidget {
  const NoticesPage({super.key});

  @override
  _NoticesPageState createState() => _NoticesPageState();
}

class _NoticesPageState extends State<NoticesPage> {
  @override
  Widget build(BuildContext context) {
    // Ordenar os avisos para garantir que o mais recente apareça primeiro
    notices.sort((a, b) {
      return b.date.compareTo(a.date); // Ordem decrescente (mais recente primeiro)
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos os avisos',
            style: TextStyle(
              fontWeight: FontWeight.w900,
            )),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: notices.length, // Exibe a quantidade de avisos
          itemBuilder: (context, index) {
            final notice = notices[index]; // Pega o aviso na posição atual
            return InkWell(
              onTap: () {
                // Navegar para a página de visualização do aviso
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoticePage(),
                  ),
                );
              },
              child: NoticeCard(notice: notice), // Exibe o Card do aviso
            );
          },
        ),
      ),
    );
  }
}

// Card de aviso
class NoticeCard extends StatelessWidget {
  final Notice notice;

  const NoticeCard({super.key, required this.notice});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Data do aviso
            Text(
              notice.date,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            // Título do aviso
            Text(
              notice.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Conteúdo do aviso
            Text(notice.content),
          ],
        ),
      ),
    );
  }
}


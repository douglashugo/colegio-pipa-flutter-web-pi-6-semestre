import 'package:flutter/material.dart';  

class Notice {
  final String date;  // Data do aviso
  final String title; // Título do aviso
  final String content; // Conteúdo do aviso

  Notice(this.date, this.title, this.content);
}


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
                color: Colors.grey[600],
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

import 'package:f290_ldmp_web_desktop_playground/src/features/home/domain/model/post_model.dart';
import 'package:flutter/material.dart';

class M3Card extends StatelessWidget {
  const M3Card({
    super.key,
    required this.title,
    required this.content,
    this.imagePath = '', // Parâmetro opcional para o caminho da imagem
    this.width = 0,
    this.height = 0, required PostModel post,
  });

  final String title;
  final String content;
  final String imagePath; // Parâmetro opcional para o caminho da imagem
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imagePath.isNotEmpty
                        ? NetworkImage(imagePath)
                        : const AssetImage('assets/placeholder.png') as ImageProvider, // Placeholder
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  child: Text(
                    content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

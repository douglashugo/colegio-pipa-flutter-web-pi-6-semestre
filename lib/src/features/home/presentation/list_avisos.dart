import 'package:f290_ldmp_web_desktop_playground/src/features/home/presentation/view_avisos.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Classe de aviso
class Notice {
  final String date; // Data do aviso
  final String title; // Título do aviso
  final String content; // Conteúdo do aviso

  Notice({required this.date, required this.title, required this.content});

  // Método para converter do JSON
  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      date: json['created_at'] ?? '',
      title: json['title'] ?? '',
      content: json['description'] ?? '',
    );
  }
}

// Página principal de avisos
class NoticesPage extends StatefulWidget {
  const NoticesPage({super.key});

  @override
  _NoticesPageState createState() => _NoticesPageState();
}

class _NoticesPageState extends State<NoticesPage> {
  final SupabaseClient _client =
      Supabase.instance.client; // Obtem o cliente padrão do Supabase
  List<Notice> notices = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNotices();
  }

  Future<void> _fetchNotices() async {
    try {
      final response = await _client
          .from('posts_categories')
          .select('title, description, created_at')
          .eq('cat_id', 5) // Filtro para categoria com ID 5
          .order('created_at', ascending: false);

      if (response == null) {
        throw response;
      }

      final data = response as List<dynamic>;
      setState(() {
        notices = data.map((e) => Notice.fromJson(e)).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar avisos: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todos os avisos',
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : notices.isEmpty
              ? const Center(child: Text('Nenhum aviso encontrado.'))
              : ListView.builder(
                  itemCount: notices.length,
                  itemBuilder: (context, index) {
                    final notice = notices[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NoticePage(),
                          ),
                        );
                      },
                      child: NoticeCard(notice: notice),
                    );
                  },
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

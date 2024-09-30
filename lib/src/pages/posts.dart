import 'package:flutter/material.dart';

class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlogHomePage(),
    );
  }
}

class BlogHomePage extends StatelessWidget {
  final List<Map<String, String>> posts = [
    {
      'title': 'First Blog Post',
      'description': 'This is the first blog post description. It contains more than three lines of text to demonstrate the truncation feature. The full text will not be shown here.',
      'tag': 'Technology',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'title': 'Second Blog Post',
      'description': 'This is the second blog post. It also has a description that might be too long, but only three lines will be shown.',
      'tag': 'Lifestyle',
      'image': 'https://via.placeholder.com/150',
    },
    // Add more posts here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Conteúdos'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: screenWidth < 600 ? screenWidth * 0.9 : 800,
                  ),
                  child: BlogPostCard(post: posts[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class BlogPostCard extends StatelessWidget {
  final Map<String, String> post;

  BlogPostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Display the image if available
            if (post['image'] != null)
              Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.only(right: 16),
                child: Image.network(
                  post['image']!,
                  fit: BoxFit.cover,
                ),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post['title']!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    post['tag']!,
                    style: TextStyle(
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    post['description']!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      // Navigate to the full post page
                    },
                    child: Text(
                      'Read more',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

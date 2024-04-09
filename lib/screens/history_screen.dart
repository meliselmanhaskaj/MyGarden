import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> history;

  const HistoryScreen({Key? key, required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Identified Plants History',
          style: TextStyle(color: Colors.white), // Imposta il colore del testo
        ),
      ),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final plantName = history[index]['plantName'];
          final score = (history[index]['score'] * 100).toStringAsFixed(2);
          final imageIndex = history[index]['imageIndex'];

          final bool newImage = index == 0 || history[index - 1]['imageIndex'] != imageIndex;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (newImage)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: Text(
                      'Image ${imageIndex + 1}',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 18),
                    ),
                  ),
                ),
              ListTile(
                title: Text(
                  'Plant: $plantName',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Score: $score%'),
              ),
              if (newImage) const Divider(),
            ],
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'data_transfer_screen.dart';
import 'details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle =
        Theme.of(context).textTheme.headlineMedium ??
            const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(title: const Text('Beranda')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Flutter Navigation Demo', style: titleStyle),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text('Kirim Data'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DataTransferScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.info),
              label: const Text('Detail Info'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DetailsScreen(
                      title: 'Informasi',
                      description:
                      'Contoh penggunaan Navigator.push() dan Navigator.pop()',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

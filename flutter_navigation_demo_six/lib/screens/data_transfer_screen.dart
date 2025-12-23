import 'package:flutter/material.dart';
import 'details_screen.dart';

class DataTransferScreen extends StatefulWidget {
  const DataTransferScreen({super.key});

  @override
  State<DataTransferScreen> createState() => _DataTransferScreenState();
}

class _DataTransferScreenState extends State<DataTransferScreen> {
  final _nameController = TextEditingController();
  final _messageController = TextEditingController();

  void _sendData() {
    if (_nameController.text.isEmpty ||
        _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap isi semua field')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailsScreen(
          title: 'Data Terkirim',
          description:
          'Nama: ${_nameController.text}\n'
              'Pesan: ${_messageController.text}',
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kirim Data')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(labelText: 'Pesan'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _sendData,
              child: const Text('Kirim'),
            ),
          ],
        ),
      ),
    );
  }
}

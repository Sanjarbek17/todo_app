import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/main_provider.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  // create title controller
  final TextEditingController _titleController = TextEditingController();
  // create description controller
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // title text field
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            // description text field
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            // add button
            ElevatedButton(
              onPressed: () {
                // get list provider
                final listProvider = Provider.of<ListProvider>(context, listen: false);
                // add to list
                listProvider.addToList(
                  _titleController.text,
                  _descriptionController.text,
                );
                // pop page
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}

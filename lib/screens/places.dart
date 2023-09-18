import 'package:flutter/material.dart';

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return const ListTile(
            title: Text('title'),
            contentPadding: EdgeInsets.all(8),
          );
        },
      ),
    );
  }
}

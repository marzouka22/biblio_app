import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Messages'),
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        actions: [
          IconButton(icon: const Icon(Icons.edit_square), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: CircleAvatar(
              backgroundColor: colorScheme.primaryContainer,
              child: Text(
                'U${index + 1}',
                style: TextStyle(color: colorScheme.onPrimaryContainer),
              ),
            ),
            title: Text(
              'Membre Bibliothèque ${index + 1}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Bonjour, est-ce que le livre est disponible ?',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
            trailing: Text('10:30', style: theme.textTheme.labelSmall),
            onTap: () {},
          );
        },
      ),
    );
  }
}

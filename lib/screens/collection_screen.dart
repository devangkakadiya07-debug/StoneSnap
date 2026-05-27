import 'dart:io';

import 'package:flutter/material.dart';

import '../models/rock.dart';
import '../services/rocks_database.dart';
import 'result_screen.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  late Future<List<Rock>> _rocksFuture;

  @override
  void initState() {
    super.initState();
    _rocksFuture = RocksDatabase.instance.fetchRocks();
  }

  Future<void> _refresh() async {
    setState(() {
      _rocksFuture = RocksDatabase.instance.fetchRocks();
    });
    await _rocksFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Collection'),
      ),
      body: FutureBuilder<List<Rock>>(
        future: _rocksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final rocks = snapshot.data ?? [];
          if (rocks.isEmpty) {
            return const Center(
              child: Text('No rocks saved yet.'),
            );
          }
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: rocks.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final rock = rocks[index];
                final imageFile = File(rock.imagePath);
                return ListTile(
                  tileColor: Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: imageFile.existsSync()
                        ? Image.file(
                            imageFile,
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 56,
                            height: 56,
                            color: Colors.black26,
                            child: const Icon(Icons.image_not_supported),
                          ),
                  ),
                  title: Text(rock.name),
                  subtitle: Text('${rock.type} • ${rock.color}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ResultScreen(
                          rock: rock,
                          allowSave: false,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

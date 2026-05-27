import 'dart:io';

import 'package:flutter/material.dart';

import '../models/rock.dart';
import '../services/rocks_database.dart';
import 'result_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  late Future<List<Rock>> _resultsFuture;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _resultsFuture = RocksDatabase.instance.fetchRocks();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateSearch(String query) {
    final trimmed = query.trim();
    setState(() {
      _query = trimmed;
      _resultsFuture = trimmed.isEmpty
          ? RocksDatabase.instance.fetchRocks()
          : RocksDatabase.instance.searchRocks(trimmed);
    });
  }

  Future<void> _refresh() async {
    final future = _query.isEmpty
        ? RocksDatabase.instance.fetchRocks()
        : RocksDatabase.instance.searchRocks(_query);
    setState(() {
      _resultsFuture = future;
    });
    await future;
  }

  Widget _buildEmptyState() {
    if (_query.isEmpty) {
      return const Center(child: Text('No rocks saved yet.'));
    }
    return const Center(child: Text('No matches found.'));
  }

  Widget _buildRockTile(Rock rock) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: _updateSearch,
              decoration: InputDecoration(
                hintText: 'Search rock names',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _controller.text.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Clear',
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          _updateSearch('');
                        },
                      ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Rock>>(
                future: _resultsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final rocks = snapshot.data ?? [];
                  if (rocks.isEmpty) {
                    return _buildEmptyState();
                  }
                  return RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView.separated(
                      padding: const EdgeInsets.only(bottom: 16),
                      itemCount: rocks.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return _buildRockTile(rocks[index]);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

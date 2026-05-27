import 'dart:io';

import 'package:flutter/material.dart';

import '../models/rock.dart';
import '../services/rocks_database.dart';

class ResultScreen extends StatefulWidget {
  final Rock rock;
  final bool allowSave;

  const ResultScreen({
    super.key,
    required this.rock,
    required this.allowSave,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late Rock _rock;
  bool _isSaving = false;
  bool _saved = false;

  @override
  void initState() {
    super.initState();
    _rock = widget.rock;
    _saved = widget.rock.id != null;
  }

  Future<void> _saveRock() async {
    setState(() => _isSaving = true);
    try {
      final saved = await RocksDatabase.instance.saveRock(_rock);
      if (!mounted) {
        return;
      }
      setState(() {
        _rock = saved;
        _saved = true;
        _isSaving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved to your collection.')),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save rock: $error')),
      );
    }
  }

  Widget _buildDetailCard(String title, String value) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageFile = File(_rock.imagePath);
    final imageAvailable = imageFile.existsSync();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rock Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: imageAvailable
                ? Image.file(
                    imageFile,
                    height: 220,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 220,
                    color: Colors.black26,
                    child: const Center(
                      child: Icon(Icons.image_not_supported, size: 48),
                    ),
                  ),
          ),
          const SizedBox(height: 24),
          Text(
            _rock.name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          _buildDetailCard('Type', _rock.type),
          _buildDetailCard('Color', _rock.color),
          _buildDetailCard('Hardness', _rock.hardness),
          _buildDetailCard('Description', _rock.description),
          const SizedBox(height: 16),
          if (widget.allowSave)
            FilledButton.icon(
              onPressed: _saved || _isSaving ? null : _saveRock,
              icon: _isSaving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.bookmark_add),
              label: Text(_saved ? 'Saved' : 'Save to Collection'),
            ),
        ],
      ),
    );
  }
}

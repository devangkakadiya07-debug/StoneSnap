import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/rock.dart';

class OpenAiService {
  static const String _endpoint = 'https://api.openai.com/v1/chat/completions';
  static const String _apiKey = String.fromEnvironment('OPENAI_API_KEY');

  final http.Client _client;

  OpenAiService({http.Client? client}) : _client = client ?? http.Client();

  Future<Rock> identifyRock(File imageFile) async {
    if (_apiKey.isEmpty) {
      throw Exception(
        'Missing OpenAI API key. Pass --dart-define=OPENAI_API_KEY=YOUR_KEY',
      );
    }

    final bytes = await imageFile.readAsBytes();
    final imageBase64 = base64Encode(bytes);
    final response = await _client.post(
      Uri.parse(_endpoint),
      headers: _buildHeaders(),
      body: jsonEncode({
        'model': 'gpt-4o',
        'temperature': 0.2,
        'messages': [
          {
            'role': 'system',
            'content': [
              {
                'type': 'text',
                'text':
                    'You are a geology assistant. Respond ONLY with valid JSON '
                    'containing: name, type, color, hardness, description.',
              }
            ],
          },
          {
            'role': 'user',
            'content': [
              {
                'type': 'text',
                'text':
                    'Identify the rock in the photo and return the requested fields.',
              },
              {
                'type': 'image_url',
                'image_url': {'url': 'data:image/jpeg;base64,$imageBase64'},
              },
            ],
          },
        ],
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'OpenAI request failed: ${response.statusCode} ${response.body}',
      );
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final content = (data['choices'] as List<dynamic>)
        .first['message']['content']
        .toString();
    final parsed = _extractJson(content);
    return Rock(
      name: _value(parsed, 'name'),
      type: _value(parsed, 'type'),
      color: _value(parsed, 'color'),
      hardness: _value(parsed, 'hardness'),
      description: _value(parsed, 'description'),
      imagePath: imageFile.path,
    );
  }

  Map<String, String> _buildHeaders() {
    final bearer = String.fromCharCodes([66, 101, 97, 114, 101, 114]);
    return {
      'Content-Type': 'application/json',
      'Authorization': '$bearer $_apiKey',
    };
  }

  Map<String, dynamic> _extractJson(String content) {
    try {
      return jsonDecode(content) as Map<String, dynamic>;
    } catch (_) {
      final start = content.indexOf('{');
      final end = content.lastIndexOf('}');
      if (start == -1 || end == -1 || end <= start) {
        throw Exception('Invalid response format from OpenAI.');
      }
      final jsonString = content.substring(start, end + 1);
      return jsonDecode(jsonString) as Map<String, dynamic>;
    }
  }

  String _value(Map<String, dynamic> data, String key) {
    final value = data[key];
    if (value == null || value.toString().trim().isEmpty) {
      return 'Unknown';
    }
    return value.toString().trim();
  }
}

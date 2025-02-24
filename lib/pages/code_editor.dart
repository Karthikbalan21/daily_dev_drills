import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:highlight/languages/java.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CodeEditorPage extends StatefulWidget {
  @override
  _CodeEditorPageState createState() => _CodeEditorPageState();
}

class _CodeEditorPageState extends State<CodeEditorPage> {
  late CodeController _controller;
  String output = '';
  String selectedLanguage = 'python';

  @override
  void initState() {
    super.initState();
    _controller = CodeController(
      text: '',
      language: python,
      
    );
  }

  Future<void> runCode() async {
    final url = Uri.parse('https://emkc.org/api/v2/piston/execute');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'language': selectedLanguage,
      'version': '*',
      'files': [{'content': _controller.text}]
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          output = data['run']['stdout'] ?? 'No output';
        });
      } else {
        setState(() {
          output = 'Error: Unable to execute the code';
        });
      }
    } catch (e) {
      setState(() {
        output = 'Error: $e';
      });
    }
  }

  void updateLanguage(String language) {
    setState(() {
      selectedLanguage = language;
      _controller.language = language == 'python'
          ? python
          : language == 'java'
              ? java
              : language == 'cpp'
                  ? cpp
                  : cpp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Code Editor')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton<String>(
                value: selectedLanguage,
                onChanged: (newValue) {
                  updateLanguage(newValue!);
                },
                items: ['python', 'c', 'cpp', 'java'].map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value.toUpperCase()),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              Expanded(
                child: CodeTheme(
                  data: CodeThemeData(styles: monokaiSublimeTheme),
                  child: CodeField(controller: _controller),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: runCode,
                  child: Text('Run Code'),
                ),
              ),
              SizedBox(height: 10),
              Text('Output:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SingleChildScrollView(
                  child: Text(output),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SurveyCreationScreen extends StatefulWidget {
  @override
  _SurveyCreationScreenState createState() => _SurveyCreationScreenState();
}

class _SurveyCreationScreenState extends State<SurveyCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _questionController = TextEditingController();
  final surveyBox = Hive.box('surveyBox');

  List<String> _questions = [];

  void _createSurvey() {
    if (_formKey.currentState?.validate() ?? false) {
      surveyBox.add({
        'title': _titleController.text,
        'description': _descriptionController.text,
        'questions': _questions,
      });
      Navigator.pop(context);
    }
  }

  void _addQuestion() {
    if (_questionController.text.isNotEmpty) {
      setState(() {
        _questions.add(_questionController.text);
        _questionController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Survey'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _questionController,
                decoration: InputDecoration(labelText: 'Add Question'),
              ),
              ElevatedButton(
                onPressed: _addQuestion,
                child: Text('Add Question'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _questions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_questions[index]),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _createSurvey,
                child: Text('Create Survey'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

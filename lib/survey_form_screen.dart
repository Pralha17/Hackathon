import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SurveyFormScreen extends StatelessWidget {
  final int surveyId;
  SurveyFormScreen({required this.surveyId});

  final _formKey = GlobalKey<FormState>();
  final _responseController = TextEditingController();
  final surveyBox = Hive.box('surveyBox');

  void _submitResponse() {
    if (_formKey.currentState?.validate() ?? false) {
      final survey = surveyBox.getAt(surveyId);
      if (survey['responses'] == null) {
        survey['responses'] = [];
      }
      survey['responses'].add(_responseController.text);
      surveyBox.putAt(surveyId, survey);
    }
  }

  @override
  Widget build(BuildContext context) {
    final survey = surveyBox.getAt(surveyId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Survey Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(survey['title']),
              Text(survey['description']),
              ...survey['questions'].map<Widget>((question) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(question),
                    TextFormField(
                      controller: _responseController,
                      decoration: InputDecoration(labelText: 'Your Response'),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter a response';
                        }
                        return null;
                      },
                    ),
                  ],
                );
              }).toList(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitResponse,
                child: Text('Submit Response'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

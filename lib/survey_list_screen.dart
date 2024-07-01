import 'package:flutter/material.dart';
import 'survey_creation_screen.dart';
import 'survey_form_screen.dart';
import 'package:hive/hive.dart';

class SurveyListScreen extends StatefulWidget {
  @override
  _SurveyListScreenState createState() => _SurveyListScreenState();
}

class _SurveyListScreenState extends State<SurveyListScreen> {
  final surveyBox = Hive.box('surveyBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey List'),
      ),
      body: ListView.builder(
        itemCount: surveyBox.length,
        itemBuilder: (context, index) {
          final survey = surveyBox.getAt(index);
          return ListTile(
            title: Text(survey['title']),
            subtitle: Text(survey['description']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SurveyFormScreen(surveyId: index)),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SurveyCreationScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AnalyticsScreen extends StatelessWidget {
  final surveyBox = Hive.box('surveyBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics'),
      ),
      body: ListView.builder(
        itemCount: surveyBox.length,
        itemBuilder: (context, index) {
          final survey = surveyBox.getAt(index);
          return ListTile(
            title: Text(survey['title']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(survey['description']),
                Text('Responses: ${survey['responses']?.length ?? 0}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

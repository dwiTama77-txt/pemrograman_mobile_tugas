import 'package:flutter/material.dart';
import 'pages/feedback_form_page.dart';
import 'pages/feedback_result_page.dart';

void main() {
  runApp(const FormFeedbackAppFour());
}

class FormFeedbackAppFour extends StatelessWidget {
  const FormFeedbackAppFour({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Feedback App Four',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FeedbackFormPage(),
      routes: {
        '/result': (context) => const FeedbackResultPage(),
      },
    );
  }
}

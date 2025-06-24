import 'package:flutter/material.dart';

void main() {
  runApp(NEETPrepApp());
}

class NEETPrepApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NEET Prep Meter',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      darkTheme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<String> subjects = ['Physics', 'Chemistry', 'Biology'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEET Prep Meter'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          return SubjectCard(subject: subjects[index]);
        },
      ),
    );
  }
}

class SubjectCard extends StatefulWidget {
  final String subject;

  SubjectCard({required this.subject});

  @override
  _SubjectCardState createState() => _SubjectCardState();
}

class _SubjectCardState extends State<SubjectCard> {
  double progress = 0.0;
  List<bool> chapterCompleted = List.filled(5, false);

  void updateProgress() {
    int completed = chapterCompleted.where((c) => c).length;
    setState(() {
      progress = completed / chapterCompleted.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.subject,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(value: progress),
            SizedBox(height: 10),
            Column(
              children: List.generate(5, (index) {
                return CheckboxListTile(
                  title: Text('Chapter ${index + 1}'),
                  value: chapterCompleted[index],
                  onChanged: (value) {
                    setState(() {
                      chapterCompleted[index] = value ?? false;
                      updateProgress();
                    });
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
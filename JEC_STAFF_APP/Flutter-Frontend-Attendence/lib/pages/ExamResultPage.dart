import 'package:flutter/material.dart';

class ExamResultPage extends StatefulWidget {
  const ExamResultPage({super.key});

  @override
  _ExamResultPageState createState() => _ExamResultPageState();
}

class _ExamResultPageState extends State<ExamResultPage> {
  final TextEditingController _examNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String? selectedBatch;
  String? selectedSubject;
  String? uploadedFile;

  final List<String> batches = [
    'CSE - 3rd Year',
    'ECE - 2nd Year',
    'MECH - 4th Year'
  ];
  final List<String> subjects = ['Mathematics', 'Physics', 'Computer Science'];

  void _submitResult() {
    if (_examNameController.text.isEmpty ||
        _dateController.text.isEmpty ||
        selectedBatch == null ||
        selectedSubject == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please fill all fields before submitting."),
            backgroundColor: Colors.red),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text("Exam result announced successfully!"),
          backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Announce Exam Results",
            style: TextStyle(color: Colors.purple)),
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.purple),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _examNameController,
              decoration: const InputDecoration(labelText: "Exam Name"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _dateController,
              decoration:
                  const InputDecoration(labelText: "Exam Date (DD/MM/YYYY)"),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedBatch,
              items: batches.map((batch) {
                return DropdownMenuItem(value: batch, child: Text(batch));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedBatch = value;
                });
              },
              decoration: const InputDecoration(labelText: "Select Batch"),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedSubject,
              items: subjects.map((subject) {
                return DropdownMenuItem(value: subject, child: Text(subject));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSubject = value;
                });
              },
              decoration: const InputDecoration(labelText: "Select Subject"),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submitResult,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  backgroundColor: const Color(0xFF6A1B9A),
                  foregroundColor: Colors.white,
                  shadowColor: Colors.blueAccent,
                ),
                child: const Text("Announce Result",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

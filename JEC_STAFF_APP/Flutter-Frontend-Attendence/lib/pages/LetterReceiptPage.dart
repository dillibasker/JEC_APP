import 'package:flutter/material.dart';

class LetterReceiptPage extends StatelessWidget {
  final String requestType;
  final bool isStaff;

  const LetterReceiptPage({
    super.key,
    required this.requestType,
    required this.isStaff,
  });

  @override
  Widget build(BuildContext context) {
    if (!isStaff) {
      return Scaffold(
        appBar: AppBar(title: const Text("Access Denied")),
        body: const Center(
          child: Text(
            "You do not have permission to access this page.",
            style: TextStyle(fontSize: 18, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$requestType Form",
          style: const TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.purple),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEmailFormat(requestType),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Request sent to HOD successfully!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color(0xFF6A1B9A),
                  foregroundColor: Colors.white,
                  shadowColor: Colors.blueAccent,
                ),
                child: const Text(
                  "Send Request",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailFormat(String requestType) {
    DateTime now = DateTime.now();
    String date = "${now.day}/${now.month}/${now.year}";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Date: $date",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        const Text("From: Jai Ganesh H\nFaculty ID: ST12345\nCSE - 3rd Year",
            style: TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        const Text(
            "To: The Principal\nABC College of Engineering\nCity - 123456",
            style: TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        const Text(
          "Subject: Application for Permission",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline),
        ),
        const SizedBox(height: 16),
        const Text("Respected Sir/Madam,", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        _buildRequestSpecificContent(requestType),
        const SizedBox(height: 16),
        const Text(
            "I kindly request you to consider my application and grant me permission.",
            style: TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        const Text("Thank you for your consideration.",
            style: TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        const Text("Yours sincerely,\nJai Ganesh H",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildRequestSpecificContent(String requestType) {
    switch (requestType) {
      case "OD Request":
        return const Text(
          "I am writing to request On Duty (OD) permission for [Event/Reason] which is scheduled on [Date] at [Venue/Location]. I will be participating in this event as [Role/Responsibility].",
          style: TextStyle(fontSize: 16),
        );
      case "Leave Request":
        return const Text(
          "I am writing to request leave from [Start Date] to [End Date] due to [Reason for leave]. During my absence, I will ensure that I complete all pending academic work upon my return.",
          style: TextStyle(fontSize: 16),
        );
      case "Gate Pass Request":
        return const Text(
          "I am writing to request a gate pass for [Date] during [Time] as I need to [Reason for gate pass]. I will return to the campus by [Return Time].",
          style: TextStyle(fontSize: 16),
        );
      default:
        return const Text(
          "I am writing to request permission for [specify your request details here].",
          style: TextStyle(fontSize: 16),
        );
    }
  }
}

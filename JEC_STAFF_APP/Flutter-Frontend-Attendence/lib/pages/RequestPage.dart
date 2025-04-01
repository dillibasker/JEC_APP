// Modify the RequestPage.dart file

import 'package:flutter/material.dart';
// Import the new page
import 'package:flutter_project_app/pages/LetterReceiptPage.dart'; // Adjust the import path based on your project structure

class RequestPage extends StatelessWidget {
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> requestOptions = [
      {
        "icon": Icons.event_available,
        "label": "OD Request",
        "color": Colors.purple,
      },
      {
        "icon": Icons.beach_access,
        "label": "Leave Request",
        "color": Colors.blue,
      },
      {
        "icon": Icons.logout,
        "label": "Gate Pass Request",
        "color": Colors.deepPurple,
      },
      // Add more options here if needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Requests",
          style: TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF5F6FA),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Request Type",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: requestOptions.length,
                itemBuilder: (context, index) {
                  final option = requestOptions[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the LetterReceiptPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LetterReceiptPage(
                            requestType: option["label"],
                            isStaff: true,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: const LinearGradient(
                            colors: [Colors.purple, Colors.blue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.9),
                              child:
                                  Icon(option['icon'], color: option['color']),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              option['label'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios,
                                size: 18, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

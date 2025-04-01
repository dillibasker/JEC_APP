import 'package:flutter/material.dart';
import 'package:flutter_project_app/pages/StudentRemarkPage.dart';

class RemarkPage extends StatelessWidget {
  // Define departments and their respective classes
  final Map<String, List<String>> departmentClasses = {
    "Computer Science": [
      "CSE I SEC A",
      "CSE I SEC B",
      "CSE II SEC A",
      "CSE II SEC B",
      "CSE III SEC A",
      "CSE III SEC B",
    ],
    "Electrical Engineering": [
      "EE I SEC A",
      "EE I SEC B",
      "EE II SEC A",
      "EE II SEC B",
      "EE III SEC A",
      "EE III SEC B",
    ],
    "Mechanical Engineering": [
      "ME I SEC A",
      "ME I SEC B",
      "ME II SEC A",
      "ME II SEC B",
      "ME III SEC A",
      "ME III SEC B",
    ],
    "Civil Engineering": [
      "CE I SEC A",
      "CE I SEC B",
      "CE II SEC A",
      "CE II SEC B",
      "CE III SEC A",
      "CE III SEC B",
    ],
  };

  RemarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Department for Remark"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: departmentClasses.keys.map((department) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                title: Text(
                  department,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                trailing:
                    const Icon(Icons.arrow_forward_ios, color: Colors.white),
                onTap: () {
                  _showClassDialog(context, department);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showClassDialog(BuildContext context, String department) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Class - $department"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: departmentClasses[department]!.map((className) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Close the dialog
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentRemarkPage(
                            department: department,
                            className: className,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          colors: [Colors.blue, Colors.purple],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          className,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

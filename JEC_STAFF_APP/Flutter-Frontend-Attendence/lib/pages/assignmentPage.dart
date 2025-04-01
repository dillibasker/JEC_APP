import 'package:flutter/material.dart';

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({super.key});

  @override
  _AssignmentPageState createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _marksController = TextEditingController();
  DateTime? _selectedDeadline;

  final List<Map<String, dynamic>> _assignments = [];

  void _pickDeadline(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDeadline = picked;
      });
    }
  }

  void _publishAssignment() {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _selectedDeadline == null ||
        _marksController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields!")),
      );
      return;
    }

    setState(() {
      _assignments.add({
        "title": _titleController.text,
        "description": _descriptionController.text,
        "deadline": _selectedDeadline,
        "marks": _marksController.text,
      });
      _titleController.clear();
      _descriptionController.clear();
      _marksController.clear();
      _selectedDeadline = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: AppBar(
        title: const Text("Assignments"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("📝 Create Assignment"),
            const SizedBox(height: 12),
            _buildTextField("Assignment Title", _titleController),
            const SizedBox(height: 12),
            _buildTextField("Description", _descriptionController, maxLines: 3),
            const SizedBox(height: 12),

            // Deadline Picker Row
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDeadline == null
                        ? "Select Deadline"
                        : "Deadline: ${_selectedDeadline!.toLocal()}"
                            .split(' ')[0],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                InkWell(
                  onTap: () => _pickDeadline(context),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.purple, Colors.blue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.calendar_today,
                            color: Colors.white, size: 18),
                        SizedBox(width: 6),
                        Text(
                          "Pick Date",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildTextField("Total Marks", _marksController, isNumber: true),
            const SizedBox(height: 20),
            _buildGradientButton("Publish Assignment", _publishAssignment),
            const SizedBox(height: 30),

            _buildSectionTitle("📚 Published Assignments"),
            const SizedBox(height: 10),
            _assignments.isEmpty
                ? const Center(child: Text("No assignments published yet."))
                : Column(
                    children: _assignments.map((assignment) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                assignment["title"],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                assignment["description"],
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today,
                                          size: 16, color: Colors.red),
                                      const SizedBox(width: 4),
                                      Text(
                                        "Deadline: ${assignment["deadline"].toLocal()}"
                                            .split(' ')[0],
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.grade,
                                          size: 16, color: Colors.blue),
                                      const SizedBox(width: 4),
                                      Text(
                                        "Marks: ${assignment["marks"]}",
                                        style: const TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1, bool isNumber = false}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        fillColor: Colors.white,
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildGradientButton(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.purple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

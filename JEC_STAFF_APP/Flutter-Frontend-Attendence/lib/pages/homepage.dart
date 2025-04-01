import 'package:flutter/material.dart';
import 'package:flutter_project_app/pages/attendencepage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_project_app/pages/remarkpage.dart';
import 'package:flutter_project_app/pages/collegeEventPage.dart';
import 'package:flutter_project_app/pages/assignmentPage.dart';
import 'package:flutter_project_app/pages/ExamTimetablePage.dart';
import 'package:flutter_project_app/pages/timetablepage.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project_app/pages/RequestPage.dart';
import 'package:flutter_project_app/pages/ExamResultPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String userName = "kumaran";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Map<String, dynamic>> categories = [
    {"icon": Icons.person_pin_rounded, "label": "Attendance"},
    {"icon": Icons.sticky_note_2, "label": "Remark"},
    {"icon": Icons.event, "label": "Events"},
    {"icon": Icons.assignment, "label": "Assignment"},
    {"icon": Icons.access_time_filled_rounded, "label": "Timetable"},
    {"icon": Icons.note_alt_sharp, "label": "Request"},
    {"icon": Icons.pending_actions, "label": "Exams"},
    {"icon": Icons.list_alt, "label": "Circular"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleSection(userName),
              _buildCategoryGrid(),
              _buildAttendanceBarChart(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  void _showTimetableDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Timetable"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTimetableDialogButton(context, "Class Timetable"),
              const SizedBox(height: 10),
              _buildTimetableDialogButton(context, "Exam Timetable"),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimetableDialogButton(BuildContext context, String type) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        if (type == "Class Timetable") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ClassTimetablePage()),
          );
        } else if (type == "Exam Timetable") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ExamTimetablePage()),
          );
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            type,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      toolbarHeight: 90,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          child: SizedBox(
            width: 120,
            height: 100,
            child: Image.asset("assets/images/logo2.png", fit: BoxFit.contain),
          ),
        ),
      ),
      title: const Text(
        "Dashboard",
        style: TextStyle(
          color: Colors.purple,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      actions: [
        IconButton(icon: const Icon(Icons.account_circle), onPressed: () {})
      ],
    );
  }

  Padding _buildTitleSection(String userName) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        " Welcome, $userName! 👋",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double itemWidth = (constraints.maxWidth - (12 * 3)) / 4;
          double itemHeight = itemWidth * 1.1;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: itemWidth / itemHeight,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];

              return GestureDetector(
                onTap: () {
                  if (category["label"] == "Attendance") {
                    _showAttendanceDialog(context);
                  } else if (category["label"] == "Remark") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RemarkPage()),
                    );
                  } else if (category["label"] == "Events") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CollegeEventPage()),
                    );
                  } else if (category["label"] == "Assignment") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AssignmentPage()),
                    );
                  } else if (category["label"] == "Timetable") {
                    _showTimetableDialog(context);
                  } else if (category["label"] == "Request") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RequestPage()),
                    );
                  } else if (category["label"] == "Exams") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ExamResultPage()),
                    );
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: itemWidth * 0.8,
                      height: itemWidth * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        gradient: const LinearGradient(
                          colors: [Colors.purple, Colors.blue],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child:
                          Icon(category["icon"], size: 30, color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      category["label"],
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showAttendanceDialog(BuildContext context) {
    final List<String> departments = [
      "Computer Science",
      "Electrical Engineering",
      "Mechanical Engineering",
      "Civil Engineering"
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Department"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: departments.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: _buildDepartmentButton(context, departments[index]),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildDepartmentButton(BuildContext context, String department) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        _showClassSectionDialog(context, department);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            department,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _showClassSectionDialog(BuildContext context, String department) {
    final List<Map<String, String>> classSections = [
      {"class": "I Year", "section": "A"},
      {"class": "I Year", "section": "B"},
      {"class": "II Year", "section": "A"},
      {"class": "II Year", "section": "B"},
      {"class": "III Year", "section": "A"},
      {"class": "III Year", "section": "B"},
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Class & Section - $department"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: classSections.length,
              itemBuilder: (context, index) {
                final classSection = classSections[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: _buildClassSectionButton(
                    context,
                    department,
                    classSection["class"]!,
                    classSection["section"]!,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildClassSectionButton(BuildContext context, String department,
      String className, String section) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                  "Select Attendance Session\n$className - Section $section"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSessionButton(
                      context, "Morning", department, className, section),
                  const SizedBox(height: 10),
                  _buildSessionButton(
                      context, "Afternoon", department, className, section),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            "$className - Section $section",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSessionButton(BuildContext context, String session,
      String department, String className, String section) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AttendancePage(
              session: session,
              department: department,
              className: className,
              section: section,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            session,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceBarChart() {
    final int totalStudents = 400;
    final int presentToday = 320;
    final int absentToday = 80;
    final String currentDate =
        DateFormat('EEEE, MMMM d, y').format(DateTime.now());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Overall Attendance 📊",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Date: $currentDate",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: 300,
            child: BarChart(
              BarChartData(
                maxY: totalStudents.toDouble(),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                      interval: 50,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        switch (value.toInt()) {
                          case 0:
                            return _buildLabel("Total");
                          case 1:
                            return _buildLabel("Present");
                          case 2:
                            return _buildLabel("Absent");
                          default:
                            return Container();
                        }
                      },
                    ),
                  ),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                      interval: 50,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  checkToShowHorizontalLine: (value) => value % 50 == 0,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.shade300,
                    strokeWidth: 1,
                  ),
                ),
                barGroups: [
                  _buildBar(0, totalStudents.toDouble(), Colors.blue,
                      Colors.blueAccent),
                  _buildBar(1, presentToday.toDouble(), Colors.green,
                      Colors.lightGreen),
                  _buildBar(
                      2, absentToday.toDouble(), Colors.red, Colors.redAccent),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }

  BarChartGroupData _buildBar(
      int x, double value, Color color, Color backgroundColor) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          width: 35,
          color: color,
          borderRadius: BorderRadius.circular(8),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 400,
            color: backgroundColor.withOpacity(0.3),
          ),
        ),
      ],
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Logout"),
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }
}
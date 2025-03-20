import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_project_app/pages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> loginUser() async {
  setState(() {
    isLoading = true;
  });

  final String apiUrl = "http://192.168.129.136:5000/api/register"; 
  
  try {
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
    }),
  );

  print("Response Status: ${response.statusCode}");
  print("Response Body: ${response.body}");  // Debugging line

  if (response.statusCode == 201) {

    final data = jsonDecode(response.body);
      String userId = data["userId"];
      // Save user ID in SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("userId", userId);
      
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data["message"] ?? "Login failed")),
    );
  }
} catch (e) {
  print("Error: $e");
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Network error! Please try again.")),
  );
}
   setState(() {
    isLoading = false;
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/logo.png", width: 250, height: 250),
                  const SizedBox(height: 20),
                  const Text(
                    "Welcome !",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  const Text("Login to continue", style: TextStyle(fontSize: 18, color: Colors.white70)),
                  const SizedBox(height: 30),
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon: Icon(Icons.email, color: Colors.purple),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: Icon(Icons.lock, color: Colors.purple),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: isLoading ? null : loginUser,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: const LinearGradient(
                                  colors: [Colors.blue, Colors.purple],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Center(
                                child: isLoading
                                    ? CircularProgressIndicator(color: Colors.white)
                                    : const Text(
                                        "Login",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text("Developed by Team STARFIRE 🚀", style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

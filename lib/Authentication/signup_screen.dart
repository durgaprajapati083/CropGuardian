import 'dart:developer';
import 'package:croupguardiandurgaprajapati/responsive_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import 'controller/signupcontroller.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // 1. Controllers
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userPhoneController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();

  final GlobalKey<FormState> _FormKey = GlobalKey<FormState>();
  bool obscureText = true;

  // 2. State for safe animation
  bool _isAppearing = false;

  @override
  void initState() {
    super.initState();
    // Start animation safely after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isAppearing = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsivePage(
      child: Scaffold(
        // Nature-themed Background
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1B5E20), Color(0xFF388E3C)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            opacity: _isAppearing ? 1.0 : 0.0,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Form(
                  key: _FormKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 70),

                      // Logo Section
                      Container(
                        height: 110,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 15)],
                        ),
                        child: Image.asset('assets/images/flogo.png'),
                      ),

                      const SizedBox(height: 25),
                      const Text(
                        "CropGuardian",
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white),
                      ),
                      const Text(
                        "Register Your Farm • पंजीकरण करें",
                        style: TextStyle(fontSize: 14, color: Colors.white70, letterSpacing: 1),
                      ),

                      const SizedBox(height: 40),

                      // Inputs wrapped in a clean "Glass" card
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          children: [
                            _buildField(userNameController, "Name", Icons.person, RequiredValidator(errorText: "Required").call),
                            const SizedBox(height: 15),
                            _buildField(userPhoneController, "Phone", Icons.phone, null),
                            const SizedBox(height: 15),
                            _buildField(userEmailController, "Email", Icons.email, null),
                            const SizedBox(height: 15),

                            // Password Field
                            TextFormField(
                              controller: userPasswordController,
                              obscureText: obscureText,
                              obscuringCharacter: "*",
                              decoration: InputDecoration(
                                hintText: "Password",
                                prefixIcon: const Icon(Icons.lock, color: Color(0xFF1B5E20)),
                                suffixIcon: IconButton(
                                  icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                                  onPressed: () => setState(() => obscureText = !obscureText),
                                ),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 35),

                      // THE SIGNUP BUTTON (Logic kept exactly as yours)
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFC6FF00),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            elevation: 10,
                          ),
                          onPressed: () {
                            if (_FormKey.currentState!.validate()) {
                              _performSignup();
                            }
                          },
                          child: const Text("SIGN UP", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Login Link
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(text: "Already have an account? ", style: TextStyle(color: Colors.white, fontSize: 16)),
                                TextSpan(text: "Login", style: TextStyle(color: Color(0xFFC6FF00), fontWeight: FontWeight.bold, fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // UI Helper: Field Builder
  Widget _buildField(TextEditingController controller, String label, IconData icon, dynamic validator) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF1B5E20)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  // BACKEND LOGIC (Kept exactly as per your source code)
  void _performSignup() {
    var userName = userNameController.text.trim();
    var userPhone = userPhoneController.text.trim();
    var userEmail = userEmailController.text.trim();
    var userPassword = userPasswordController.text.trim();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator(color: Colors.white)),
    );

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: userEmail, password: userPassword)
        .then((value) {
      log("User Created");
      Fluttertoast.showToast(msg: "Account Created!", backgroundColor: Colors.green);
      SignUpUser(userName, userPhone, userEmail, userPassword);
      Navigator.pop(context); // Close loading
      Get.off(() => const LoginScreen());
    }).catchError((error) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: error.toString(), backgroundColor: Colors.red);
    });
  }
}
import 'package:croupguardiandurgaprajapati/responsive_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast, Toast, ToastGravity;
import 'package:get/get.dart';

import '../Screens/dashboard/dashboard_screen.dart';
import 'forgot_password.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  bool obscureText = true;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    // Safe entrance animation trigger
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _isVisible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsivePage(
      child: Scaffold(
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
            opacity: _isVisible ? 1.0 : 0.0,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    const SizedBox(height: 80),
      
                    // Brand Logo
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
                      "Welcome Back",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white),
                    ),
                    const Text(
                      "Smart Farming Starts Here • लॉगिन करें",
                      style: TextStyle(fontSize: 14, color: Colors.white70, letterSpacing: 1),
                    ),
      
                    const SizedBox(height: 40),
      
                    // Login Form Card (Matches Signup exactly)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        children: [
                          // Email Field with Outlined Border
                          TextFormField(
                            controller: loginEmailController,
                            decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: const Icon(Icons.email, color: Color(0xFF1B5E20)),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
      
                          const SizedBox(height: 15),
      
                          // Password Field with Outlined Border
                          TextFormField(
                            controller: loginPasswordController,
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
                          SizedBox(height: 10,),
      
                          // Forgot Password Link
                          Align(
                            alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => const ForgotPasswordScreen())),
                                child: Text("Forgot Password?", style: TextStyle(color: Color(0xFF1B5E20),fontWeight: FontWeight.w500)),
                              ),
                            ),
                        ],
                      ),
                    ),
      
                    const SizedBox(height: 35),
      
                    // Action Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC6FF00),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 8,
                        ),
                        onPressed: _performLogin,
                        child: const Text("LOGIN", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                    ),
      
                    const SizedBox(height: 25),
      
                    // Signup Redirect Card
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen()));
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
                              TextSpan(text: "Don't have an account? ", style: TextStyle(color: Colors.white, fontSize: 16)),
                              TextSpan(text: "Signup", style: TextStyle(color: Color(0xFFC6FF00), fontWeight: FontWeight.bold, fontSize: 16)),
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
    );
  }

  // --- Logic remain exactly same as your source code ---
  void _performLogin() async {
    var loginEmail = loginEmailController.text.trim();
    var loginPassword = loginPasswordController.text.trim();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator(color: Colors.white)),
    );

    try {
      final User? firebaseUser = (await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: loginEmail, password: loginPassword))
          .user;

      Navigator.pop(context); // Close loading dialog

      if (firebaseUser != null) {
        Get.offAll(() => const DashboardScreen());
        Fluttertoast.showToast(
          msg: "User LoggedIn",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(msg: "Please register your account", backgroundColor: Colors.redAccent);
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error: $e", backgroundColor: Colors.redAccent);
    }
  }
}
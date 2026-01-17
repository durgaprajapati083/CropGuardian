import 'dart:async';
import 'package:croupguardiandurgaprajapati/Screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class VibrantFarmerSplash extends StatefulWidget {
  const VibrantFarmerSplash({super.key});

  @override
  State<VibrantFarmerSplash> createState() => _VibrantFarmerSplashState();
}

class _VibrantFarmerSplashState extends State<VibrantFarmerSplash>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _rotationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // 1. Entrance Controller (Bounce & Fade)
    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _mainController, curve: const Interval(0.0, 0.5, curve: Curves.easeIn)),
    );

    // 2. Background Rotation Controller (Sunlight Glow)
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _mainController.forward();

    // 3. Navigation
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Dynamic Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1B5E20), // Deep Earth Green
                  Color(0xFF4CAF50), // Fresh Leaf Green
                  Color(0xFFFFB300), // Harvest Gold
                ],
              ),
            ),
          ),

          // Animated Rotating "Sun Rays" behind logo
          Center(
            child: RotationTransition(
              turns: _rotationController,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Colors.yellow.withOpacity(0.4),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Bouncing Logo Container
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        backgroundImage: const AssetImage('assets/images/flogo.png'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Animated Text with 3D Effect
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      const Text(
                        "CROP GUARDIAN",
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 2,
                          shadows: [
                            Shadow(color: Colors.black45, offset: Offset(3, 3), blurRadius: 6),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white.withOpacity(0.5)),
                        ),
                        child: const Text(
                          "Your Harvest, Our Priority",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Floating Particles (Eco Icons)
          ...List.generate(8, (index) => _buildFloatingIcon(index)),
        ],
      ),
    );
  }

  Widget _buildFloatingIcon(int index) {
    double startTop = (index * 120.0) % 600;
    return AnimatedBuilder(
      animation: _rotationController,
      builder: (context, child) {
        return Positioned(
          top: startTop + (math.sin(_rotationController.value * 2 * math.pi + index) * 20),
          left: (index * 60.0 + (_rotationController.value * 200)) % MediaQuery.of(context).size.width,
          child: Opacity(
            opacity: 0.3,
            child: Icon(Icons.eco, color: Colors.white, size: 20.0 + (index * 5)),
          ),
        );
      },
    );
  }
}
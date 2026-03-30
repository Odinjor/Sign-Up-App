import 'package:flutter/material.dart';
import 'package:signup_app/main.dart';
import 'package:signup_app/screens/signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> with TickerProviderStateMixin{

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final WelcomeScreenData _page = 
    WelcomeScreenData(
      title: "Welcome to the Sign-Up App!",
      subtitle: "Sign-Up right now and become a memeber today!",
      illustrationIcon: Icons.handshake,
      illustrationLabel: " ",
      accentColor: const Color.fromARGB(255, 6, 153, 33),
      gradientColors: [const Color(0xFF1A1A3E), const Color(0xFF0F0F1A)],
      );

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _fadeAnimation,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.03),
                  end: Offset.zero,
                ).animate(_fadeAnimation),
                child: child,
              ),
            );
          },
          child: _buildWelcomeSection(),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildWelcomeSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(_page.illustrationIcon, size: 80, color: _page.accentColor),
          const SizedBox(height: 24),
          Text(
            _page.title,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            _page.subtitle,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignupScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _page.accentColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Get Started',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}



class WelcomeScreenData {
  final String title;
  final String subtitle;
  final IconData illustrationIcon;
  final String illustrationLabel;
  final Color accentColor;
  final List<Color> gradientColors;

  WelcomeScreenData({
    required this.title,
    required this.subtitle,
    required this.illustrationIcon,
    required this.illustrationLabel,
    required this.accentColor,
    required this.gradientColors,
  });
}
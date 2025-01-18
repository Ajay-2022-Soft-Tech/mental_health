import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _imageSlideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    // Slide animation for the floating image
    _imageSlideAnimation = Tween<Offset>(
      begin: Offset(0, -1),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    // Start the animations
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade300,
                  Colors.blue.shade700,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Floating Character Image
          SlideTransition(
            position: _imageSlideAnimation,
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100), // Rounded border
                  child: Image.asset(
                    'assets/images/floating_character.png', // Replace with your image
                    height: 200,
                    width: 200, // Ensure circular shape
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          // Main Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 240), // Space for floating image

                // Welcome Text
                Text(
                  "Welcome to DeepBreathe",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Your journey to mindfulness starts here. Sign in to begin.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 32),

                // Google Sign-In Button
                InteractiveButton(
                  onTap: () {
                    // Add Google Sign-In logic
                  },
                  label: "Sign in with Google",
                  imagePath: 'assets/images/google_icon.png',
                ),
                SizedBox(height: 16),

                // Microsoft Sign-In Button
                InteractiveButton(
                  onTap: () {
                    // Add Microsoft Sign-In logic
                  },
                  label: "Sign in with Microsoft",
                  imagePath: 'assets/images/microsoft_icon.png',
                ),
                SizedBox(height: 16),

                // Guest Button
                InteractiveButton(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/question');
                  },
                  label: "Continue as Guest",
                  imagePath: 'assets/images/guest_icon.png',
                  isPrimary: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InteractiveButton extends StatefulWidget {
  final VoidCallback onTap;
  final String label;
  final String imagePath;
  final bool isPrimary;

  const InteractiveButton({
    required this.onTap,
    required this.label,
    required this.imagePath,
    this.isPrimary = true,
  });

  @override
  _InteractiveButtonState createState() => _InteractiveButtonState();
}

class _InteractiveButtonState extends State<InteractiveButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller for scaling effect
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
      lowerBound: 0.95,
      upperBound: 1.0,
    );

    _scaleAnimation = _controller.drive(Tween(begin: 1.0, end: 0.95));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _controller.reverse();
      },
      onTapUp: (_) {
        _controller.forward();
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: widget.isPrimary ? Colors.white : Colors.transparent,
            border: widget.isPrimary
                ? null
                : Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.imagePath,
                height: 24,
              ),
              SizedBox(width: 12),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 16,
                  color: widget.isPrimary ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

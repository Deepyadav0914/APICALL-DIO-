import 'package:flutter/material.dart';
import 'datescreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 5,
        title: const Text(
          "Home Screen",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWideScreen = constraints.maxWidth > 600;

          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(isWideScreen ? 30 : 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.lightBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: isWideScreen ? 40 : 20),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.home_outlined,
                        size: 100,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Welcome to Home Screen!",
                        style: TextStyle(
                          fontSize: isWideScreen ? 30 : 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Click the button below to proceed to the next screen.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                // Next Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: isWideScreen ? 50 : 40,
                        vertical: isWideScreen ? 20 : 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      backgroundColor: Colors.blue,
                      elevation: 8,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Datescreen(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.arrow_forward, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          "Get Started",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

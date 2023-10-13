import 'package:flutter/material.dart';
import './pages/about_us.dart'; 
import './pages/control_panel_page.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  final List<Widget> _pages = [ControlPanelPage(), AboutUsPage()]; // Include AboutUsPage()

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            debugShowCheckedModeBanner: false, // Set this to false to remove the debug banner

      title: 'ESP32 Control App',
      theme: ThemeData(
        // Your theme settings
      ),
      home: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
      
            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb), // Icon for Control Panel
              label: 'Control Panel',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info), // Icon for About Us
              label: 'About Us',
            ),
          ],
        ),
      ),
    );
  }
}

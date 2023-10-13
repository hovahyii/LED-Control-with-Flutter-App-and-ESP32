import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/logo.png', // Use the resized logo image
              width: 150, // Adjust the width as needed
              height: 150, // Adjust the height as needed
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Club Description:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'UMP Robocon Team consists of Mechanical, Electronics, and Programming Department. The team was established in 2018, and our team members are UMP students from various faculties in Universiti Malaysia Pahang (UMP).',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 20), // Add spacing

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // Open the website when the text is tapped
                        launch('https://umpbot.vercel.app/');
                      },
                      child: Text(
                        'Website',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20), // Add spacing

                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/qr_code.png', // Use the resized QR code image
                          width: 200, // You may adjust this width if needed
                          height: 200, // You may adjust this height if needed
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20), // Add spacing

                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Developed by ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Open Hovah's website when the text is tapped
                            launch('https://hovahyii.vercel.app/');
                          },
                          child: Text(
                            'Hovah',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class ControlPanelPage extends StatefulWidget {
  final String esp32Url = 'http://192.168.207.188'; // Replace with your ESP32 IP address: http://192.168.228.188 

  @override
  _ControlPanelPageState createState() => _ControlPanelPageState();
}

class _ControlPanelPageState extends State<ControlPanelPage> {
  bool redLedOn = false; // Changed the variable name to redLed
  bool greenLedOn = false;
  bool blueLedOn = false;

  Future<void> _sendControlRequest(int ledPin, bool ledState) async {
    String endpoint;
    switch (ledPin) {
      case 12:
        endpoint = ledState ? 'red/on' : 'red/off';
        setState(() {
          redLedOn = ledState;
        });
        break;
      case 13:
        endpoint = ledState ? 'green/on' : 'green/off';
        setState(() {
          greenLedOn = ledState;
        });
        break;
      case 14:
        endpoint = ledState ? 'blue/on' : 'blue/off';
        setState(() {
          blueLedOn = ledState;
        });
        break;
      default:
        // Handle unsupported LED pin
        return;
    }

    try {
      final response = await http.get(
        Uri.parse('${widget.esp32Url}/$endpoint'),
      );
      if (response.statusCode == 200) {
        // Request was successful, handle the response
        // You can update the UI or show a success message here
      } else {
        // Request failed, handle the error
        // You can update the UI or show an error message here
      }
    } catch (e) {
      // Handle exceptions like network errors
      // You can display an error message or retry the request
      print('Error: $e');
    }
  }

  Icon _getLedIcon(int ledPin) {
    Color iconColor = Colors.white;
    if (ledPin == 12 && redLedOn) {
      iconColor = Colors.red; // Change icon color to red
    } else if (ledPin == 13 && greenLedOn) {
      iconColor = Colors.green;
    } else if (ledPin == 14 && blueLedOn) {
      iconColor = Colors.lightBlue;
    }
    return Icon(Icons.lightbulb, color: iconColor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2, // Two squares per row
        mainAxisSpacing: 16, // Vertical spacing between squares
        crossAxisSpacing: 16, // Horizontal spacing between squares
        padding: EdgeInsets.all(16), // Padding around the grid
        children: <Widget>[
          Container(
            width: 150, // Square size
            height: 150, // Square size
            child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey),
              ),
              onPressed: () => _sendControlRequest(12, !redLedOn),
              icon: _getLedIcon(12),
              label: Text(redLedOn ? 'Red LED Off' : 'Red LED On'),
            ),
          ),
          Container(
            width: 150, // Square size
            height: 150, // Square size
            child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey),
              ),
              onPressed: () => _sendControlRequest(13, !greenLedOn),
              icon: _getLedIcon(13),
              label: Text(greenLedOn ? 'Green LED Off' : 'Green LED On'),
            ),
          ),
          Container(
            width: 150, // Square size
            height: 150, // Square size
            child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey),
              ),
              onPressed: () => _sendControlRequest(14, !blueLedOn),
              icon: _getLedIcon(14),
              label: Text(blueLedOn ? 'Blue LED Off' : 'Blue LED On'),
            ),
          ),
          Container(
            width: 150, // Square size
            height: 150, // Square size
            child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey),
              ),
              onPressed: () {
                // Open the GitHub link when the button is pressed
                launch('https://github.com/hovahyii/LED-Control-with-Flutter-App-and-ESP32');
              },
              icon: Icon(Icons.link, color: Colors.white, size: 60),
              label: Text('About This Project'),
            ),
          ),
        ],
      ),
    );
  }
}

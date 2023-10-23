#include <WiFi.h>
#include <WebServer.h>

const char* ssid = "iemumpss.tech";
const char* password = "hovah1234";

const int ledRedPin = 12; // GPIO12 (D6) for the red LED
const int ledGreenPin = 13; // GPIO13 (D7) for the green LED
const int ledBluePin = 14;  // GPIO14 (D5) for the blue LED

WebServer server(80);

void setup() {
  Serial.begin(115200);
  pinMode(ledRedPin, OUTPUT);
  pinMode(ledGreenPin, OUTPUT);
  pinMode(ledBluePin, OUTPUT);

  // Connect to Wi-Fi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }
  Serial.println("Connected to WiFi");



  server.on("/red/on", HTTP_GET, [](){
    digitalWrite(ledRedPin, HIGH); // Turn on the red LED
    server.send(200, "text/plain", "Red LED is ON");
  });

  server.on("/red/off", HTTP_GET, [](){
    digitalWrite(ledRedPin, LOW); // Turn off the red LED
    server.send(200, "text/plain", "Red LED is OFF");
  });

  server.on("/green/on", HTTP_GET, [](){
    digitalWrite(ledGreenPin, HIGH); // Turn on the green LED
    server.send(200, "text/plain", "Green LED is ON");
  });

  server.on("/green/off", HTTP_GET, [](){
    digitalWrite(ledGreenPin, LOW); // Turn off the green LED
    server.send(200, "text/plain", "Green LED is OFF");
  });

  server.on("/blue/on", HTTP_GET, [](){
    digitalWrite(ledBluePin, HIGH); // Turn on the blue LED
    server.send(200, "text/plain", "Blue LED is ON");
  });

  server.on("/blue/off", HTTP_GET, [](){
    digitalWrite(ledBluePin, LOW); // Turn off the blue LED
    server.send(200, "text/plain", "Blue LED is OFF");
  });

  server.begin();
}

void loop() {
  server.handleClient();
}
#include <WiFi.h>
#include <WebServer.h>
#include <LiquidCrystal_I2C.h>

const char* ssid = "iemumpss.tech";
const char* password = "hovah1234";

const int ledRedPin = 12;    // GPIO12 (D6) for the red LED
const int ledGreenPin = 13;  // GPIO13 (D7) for the green LED
const int ledBluePin = 14;   // GPIO14 (D5) for the blue LED

const int lcdAddress = 0x27; // I2C address of your LCD
const int lcdCols = 16;      // Number of columns on your LCD
const int lcdRows = 2;       // Number of rows on your LCD

LiquidCrystal_I2C lcd(lcdAddress, lcdCols, lcdRows);

WebServer server(80);

String lcdSentence = "";
unsigned long lcdDisplayStartTime = 0;
const unsigned long lcdDisplayDuration = 2000;  // 2 seconds
const unsigned long ledDisplayDuration = 5000;  // 5 seconds for LED message display

enum State {
  IDLE,
  LED_ON,
  LED_OFF
};

State currentState = IDLE;
unsigned long ledDisplayStartTime = 0;

void displayLCD(const String& sentence) {
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print(sentence.substring(0, 16));  // Display the first 16 characters on the first line

  lcd.setCursor(0, 1);
  lcd.print(sentence.substring(16));  // Display the remaining characters on the second line
}

void handleLED(State newState, int ledPin, const String& ledMessage) {
  currentState = newState;

  // Display LED message on the LCD
  displayLCD(ledMessage);

  server.send(200, "text/plain", ledMessage.c_str());
  lcdSentence = lcdSentence;
  lcdDisplayStartTime = millis();
  ledDisplayStartTime = millis();  // Start the LED display timer
}

void setup() {
  Serial.begin(115200);
  pinMode(ledRedPin, OUTPUT);
  pinMode(ledGreenPin, OUTPUT);
  pinMode(ledBluePin, OUTPUT);

  lcd.begin();

  // Connect to Wi-Fi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }
  Serial.println("Connected to WiFi");
  Serial.print("ESP32 IP address: ");
  Serial.println(WiFi.localIP());

  server.on("/red/on", HTTP_GET, []() {
    digitalWrite(ledRedPin, HIGH);  // Turn on the red LED
    handleLED(LED_ON, ledRedPin, "Red LED is ON");
  });

  server.on("/red/off", HTTP_GET, []() {
    digitalWrite(ledRedPin, LOW);  // Turn off the red LED
    handleLED(LED_OFF, ledRedPin, "Red LED is OFF");
  });

  server.on("/green/on", HTTP_GET, []() {
    digitalWrite(ledGreenPin, HIGH);  // Turn on the green LED
    handleLED(LED_ON, ledGreenPin, "Green LED is ON");
  });

  server.on("/green/off", HTTP_GET, []() {
    digitalWrite(ledGreenPin, LOW);  // Turn off the green LED
    handleLED(LED_OFF, ledGreenPin, "Green LED is OFF");
  });

  server.on("/blue/on", HTTP_GET, []() {
    digitalWrite(ledBluePin, HIGH);  // Turn on the blue LED
    handleLED(LED_ON, ledBluePin, "Blue LED is ON");
  });

  server.on("/blue/off", HTTP_GET, []() {
    digitalWrite(ledBluePin, LOW);  // Turn off the blue LED
    handleLED(LED_OFF, ledBluePin, "Blue LED is OFF");
  });

  server.on("/lcd", HTTP_POST, []() {
    lcdSentence = server.arg("sentence");
    handleLED(IDLE, -1, lcdSentence);
  });

  server.onNotFound([]() {
    server.send(404, "text/plain", "Not Found");
  });

  server.begin();
}

void loop() {
  unsigned long currentTime = millis();

  // Display LCD sentence
  if (currentState == IDLE && lcdSentence.length() > 0 && (currentTime - lcdDisplayStartTime < lcdDisplayDuration)) {
    displayLCD(lcdSentence);
  }

  // Check if it's time to return to LCD display after showing LED message
  if (currentState != IDLE && (currentTime - ledDisplayStartTime >= ledDisplayDuration)) {
    displayLCD(lcdSentence);
    currentState = IDLE;
  }

  server.handleClient();
}

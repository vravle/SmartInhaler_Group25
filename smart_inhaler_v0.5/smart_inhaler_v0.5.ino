#include <Arduino.h>
#if defined(ESP32)
  #include <WiFi.h>
#elif defined(ESP8266)
  #include <ESP8266WiFi.h>
#endif
#include <Firebase_ESP_Client.h>

//Provide the token generation process info.
#include "addons/TokenHelper.h"
//Provide the RTDB payload printing info and other helper functions.
#include "addons/RTDBHelper.h"

#define WIFI_SSID "Vidita"
#define WIFI_PASSWORD "umiya1206"
#define API_KEY "AIzaSyCWyNzv5EYUXAR4THvivL6tma5Tgc1pyWE"
#define FIREBASE_AUTH "Cd9b47bwyKY46QcrOHrWxXY0aJlnb5grVr8Gh9pz"
#define DATABASE_URL "https://smart-inhaler-nodemcu-default-rtdb.firebaseio.com"
// #define FIREBASE_HOST "smart-inhaler-nodemcu-default-rtdb.firebaseio.com"

FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

unsigned long sendDataPrevMillis = 0;
int count = 0;
bool signupOK = false;


// DHT 11 sensor
#include <DHT.h>
#define DHTPIN 0
#define DHTTYPE DHT11
DHT dht(DHTPIN, DHTTYPE);
float humidity;
float temp;

// Push Button
int buttonPin = 4;
// int buttonState = 0;
int dailyIntake = 0;
int medicineVal = 10;
int medicine_threshold = 3;

// MQ 135
int sensorValue = 0;

void setup() {
  // put your setup code here, to run once:
  pinMode(buttonPin, INPUT);
  Serial.begin(9600);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED){
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();

  /* Assign the api key (required) */
  config.api_key = API_KEY;

  /* Assign the RTDB URL (required) */
  config.database_url = DATABASE_URL;

  /* Sign up */
  if (Firebase.signUp(&config, &auth, "", "")){
    Serial.println("Sign Up : ok");
    signupOK = true;
  }
  else{
    Serial.printf("%s\n", config.signer.signupError.message.c_str());
  }

  /* Assign the callback function for the long running token generation task */
  config.token_status_callback = tokenStatusCallback; //see addons/TokenHelper.h
  
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
  // pinMode(pushButton, INPUT);
  dht.begin();
  Serial.print("Medicine Value: ");
  Serial.println(medicineVal);
}

void loop() {
  // put your main code here, to run repeatedly:
  if (Firebase.ready() && signupOK && (millis() - sendDataPrevMillis > 15000 || sendDataPrevMillis == 0)){
    sendDataPrevMillis = millis();
    if (Firebase.RTDB.setInt(&fbdo, "data/medicine value", medicineVal)){
        Serial.println("PASSED");
        Serial.println("PATH: " + fbdo.dataPath());
        Serial.println("TYPE: " + fbdo.dataType());
      }
      else {
        Serial.println("FAILED");
        Serial.println("REASON: " + fbdo.errorReason());
      }
      if (Firebase.RTDB.setInt(&fbdo, "data/daily Intake", dailyIntake)){
        Serial.println("PASSED");
        Serial.println("PATH: " + fbdo.dataPath());
        Serial.println("TYPE: " + fbdo.dataType());
      }
      else {
        Serial.println("FAILED");
        Serial.println("REASON: " + fbdo.errorReason());
      }
      if (Firebase.RTDB.setFloat(&fbdo, "data/Temperature", temp)){
        Serial.println("PASSED");
        Serial.println("PATH: " + fbdo.dataPath());
        Serial.println("TYPE: " + fbdo.dataType());
      }
      else {
        Serial.println("FAILED");
        Serial.println("REASON: " + fbdo.errorReason());
      }
      if (Firebase.RTDB.setFloat(&fbdo, "data/Humidity", humidity)){
        Serial.println("PASSED");
        Serial.println("PATH: " + fbdo.dataPath());
        Serial.println("TYPE: " + fbdo.dataType());
      }
      else {
        Serial.println("FAILED");
        Serial.println("REASON: " + fbdo.errorReason());
      }
      if (Firebase.RTDB.setFloat(&fbdo, "data/AQI", sensorValue)){
        Serial.println("PASSED");
        Serial.println("PATH: " + fbdo.dataPath());
        Serial.println("TYPE: " + fbdo.dataType());
      }
      else {
        Serial.println("FAILED");
        Serial.println("REASON: " + fbdo.errorReason());
      }
  }
    sensorValue = analogRead(A0);
    int buttonState = digitalRead(buttonPin);
    delay(1000);
    if(buttonState == HIGH){
      
      dailyIntake += 1;
      medicineVal -= 1;
      if(medicineVal < medicine_threshold){
        Serial.println("Low medicine");
      }
      if (medicineVal == 0){
        medicineVal += 10;
        Serial.println("Medicine added!");
      }
    }
      Serial.println("");
      Serial.print("Daily Intake count: ");
      Serial.println(dailyIntake);
      Serial.print("Medicine Value: ");
      Serial.println(medicineVal);
      Serial.print("Air Quality Index: ");
      Serial.println(sensorValue);
      humidity = dht.readHumidity();
      delay(1000);
      temp = dht.readTemperature();
      delay(1000);
      Serial.print("Humidity: ");
      Serial.println(humidity);
      Serial.print("Temperature: ");
      Serial.println(temp);
      delay(1000);
      
    
}

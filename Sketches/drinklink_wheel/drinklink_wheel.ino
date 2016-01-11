void setup() {
  pinMode(A0, INPUT);
}

void loop() {
  while (Serial.available()) {
    char c = Serial.read();

    if (c == '1') {
      // Drink picked up, push the button
      Bean.setLed(255, 0, 0);
      pinMode(A0, OUTPUT);
      digitalWrite(A0, LOW);
      Bean.sleep(250);
      Bean.setLed(0, 0, 0);

    } else if (c == '0') {
      // Drink set down, release the button
      Bean.setLed(0, 255, 0);
      pinMode(A0, INPUT);
      Bean.sleep(250);
      Bean.setLed(0, 0, 0);
    }
  }

  Bean.sleep(0xFFFFFFFF);
}

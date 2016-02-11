#include <Servo.h>

const char PIN_SERVO = A3;
const long SERVO_MOVE_TIME = 1000;  // ms

Servo servo;

void setup() {
  servo.attach(PIN_SERVO);
}

void loop() {
  while (Serial.available()) {
    char c = Serial.read();

    if (c == '1') {
      // Open bay door
      Bean.setLed(0, 255, 0);
      servo.write(90);
      delay(SERVO_MOVE_TIME);
      Bean.setLed(0, 0, 0);

    } else if (c == '0') {
      // Close bay door
      Bean.setLed(255, 0, 0);
      servo.write(180);
      delay(SERVO_MOVE_TIME);
      Bean.setLed(0, 0, 0);
    }
  }

  Bean.sleep(0xFFFFFFFF);
}

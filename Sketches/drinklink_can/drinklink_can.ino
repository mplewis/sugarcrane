bool was_drinking = false;

void setup() {
  Bean.setAccelerationRange(2);
}

void loop() {
  Bean.setLed(0, 0, 0);

  AccelerationReading accel = Bean.getAcceleration();
  bool drinking;
  if (accel.yAxis < 230) {
    drinking = true;
  } else {
    drinking = false;
  }

  if (drinking && !was_drinking) {
    // user picked up their drink
    Serial.println("1");
    Bean.setLed(255, 0, 0);
  } else if (!drinking && was_drinking) {
    // user put their drink down
    Bean.setLed(0, 255, 0);
    Serial.println("0");
  }

  was_drinking = drinking;
  Bean.sleep(250);
}

int pin_sonsor = 0;  // analog pin for Motion Sensor
int pin_led = 12;    // digital pin for LED

unsigned short sensor_val        = 0;
unsigned char  sensor_status     = LOW;
unsigned char  old_sensor_status = LOW;

void setup() {
  Serial.begin(9600);
  pinMode(pin_led, OUTPUT);
}

void loop() {
  // read value from sensor
  sensor_val = analogRead(pin_sonsor);

  // set sensor status. 1:ON, 0:OFF
  sensor_status =  sensor_val > 500 ? HIGH : LOW;

  // set LED status
  if (sensor_status) digitalWrite(pin_led, HIGH);
  else               digitalWrite(pin_led, LOW);

  // send status string, if status is changed.
  if (sensor_status != old_sensor_status && sensor_status) {
    Serial.println("ON");
  }

  old_sensor_status = sensor_status;
  
  delay(100);
}

int pin_sonsor = 0;  // analog pin for Motion Sensor
int pin_led = 11;    // digital pin for LED

unsigned short sensor_val        = 0;
unsigned char  sensor_status     = LOW;
unsigned char  old_sensor_status = LOW;

unsigned char count = 0;
unsigned char init_count = 30;
unsigned char init_count_half = init_count / 2;

void setup() {
  Serial.begin(9600);
  pinMode(pin_led, OUTPUT);
}

void loop() {
  // read value from sensor
  sensor_val = analogRead(pin_sonsor);

  // set sensor status. 1:ON, 0:OFF
  sensor_status =  sensor_val > 500 ? HIGH : LOW;

  // send status string, if status is changed.
  if (sensor_status != old_sensor_status && sensor_status) {
    Serial.println("ON");
  }

  // led
    // set LED status
    
    
    
  if (sensor_status) analogWrite(pin_led, 50);
  else               analogWrite(pin_led, 0);


  if (count > init_count / 2) {
    float p = (count - init_count/2) /
  }

  old_sensor_status = sensor_status;
  
  delay(100);
}

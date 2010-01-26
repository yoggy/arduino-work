int pin_servo = 3;
int count_for_serial_buf_clear = 100;

int angle = 1000;

void setup(){
  pinMode(pin_servo,OUTPUT);
  Serial.begin(38400);
}

int serial_buf_counter = 0;
int tmp_count = 0;
void loop(){
  int val = analogRead(0);
  
  int t = 700 + (int)(1800.0 * (val / 1023.0));
  
  // servo control
  digitalWrite(pin_servo, HIGH);
  delayMicroseconds(t);
  digitalWrite(pin_servo, LOW);
  delayMicroseconds(10000 - t); // max 16383
  delayMicroseconds(10000);

  tmp_count++;
  if (tmp_count > 10) {
    Serial.println(t);
    tmp_count = 0;
  }
}

char serial_buf[7];
int serial_buf_size = 7;
int serial_buf_pos = 0;

void clear_serial() {
  Serial.println("clear_serial");
  Serial.flush();
  serial_buf_pos = 0;
}

void read_serial() {
  int d;

  d = Serial.read();
  if (d != 'n') return;
  serial_buf[0] = d;
  serial_buf_pos ++;
    
  while(1) {
    d = Serial.read();
     
    if (serial_buf_pos < serial_buf_size) {
      serial_buf[serial_buf_pos] = (char)d;
      serial_buf_pos++;
    }
    else {
      break;
    }
  }
  
  Serial.print("serial_buf_pos=");
  Serial.println(serial_buf_pos);
  parse_command();
  serial_buf_pos = 0;  
}

// n0a1000
void parse_command() {
  Serial.println("parse_command()");
  //checkn
  if (serial_buf[0] != 'n') return;
  if (serial_buf[2] != 'a') return;
//  if (serial_buf[7] != 0xd) return;
//  if (serial_buf[8] != 0xa) return;

  int num = serial_buf[1] - '0';

  int angle_4 = serial_buf[3] - '0';
  int angle_3 = serial_buf[4] - '0';
  int angle_2 = serial_buf[5] - '0';
  int angle_1 = serial_buf[6] - '0';

  angle = angle_4 * 1000 + angle_3 * 100 + angle_2 * 10 + angle_1;
  
  Serial.print("angle");
  Serial.println(angle);
}


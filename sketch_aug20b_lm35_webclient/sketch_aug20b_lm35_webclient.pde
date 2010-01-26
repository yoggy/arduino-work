#include <Ethernet.h>

// client id (for cgi)
int client_id = 100;

// ethernet
byte mac[] = { 0x00, 0x50, 0xC2, 0x97, 0x21, 0xE3 };
byte ip[] = { 192, 168, 7, 17 };
byte gateway[] = { 192, 168, 7, 254 };
byte subnet[] = { 255, 255, 255, 0 };
byte server[] = {210,253,120,132};
Client client(server, 80);

// temperature
int pin_in_lm35 = 0;
int t_count_max = 60; //sec?

void setup() {
  Ethernet.begin(mac, ip, gateway, subnet);
  analogReference(INTERNAL);
  delay(1000);
  
  Serial.begin(9600);
  Serial.println("200 startup temperature logger.");
}

void loop() {
  float temp = get_temperature();
  send_data(temp);
}

float get_temperature() {
  float total = 0.0;
  for (int i = 0; i < t_count_max; ++i) {
    int val = analogRead(pin_in_lm35);    
    float lm35_vout_volt = val * 1.1 / 1024;
    float t = lm35_vout_volt * 100.0;
    total += t;
    delay(1000);
  }
  float temp = total / t_count_max;
  return temp;
}

void send_data(float temp) {
  // HTTP  
  if (client.connect()) {
    Serial.println("200 connected.");
    client.print("GET /envlogger/envlogger.cgi?");
    client.print("client_id=");
    client.print(client_id);
    client.print("&");
    client.print("t=");
    client.print(temp);
    client.println(" HTTP/1.0");
    client.println("Host: www.sabamiso.net");
    client.println();
  } else {
    Serial.println("500 connection failed.");
  }
  
  delay(3000);
  
  while (client.available()) {
    char c = client.read();
    //Serial.print(c);
  }
  
  if (!client.connected()) {
    Serial.println("200 disconnect.");
    client.stop();
  }
  
  // for debug...
  Serial.print("201 ");
  Serial.print("temp=");
  Serial.print(temp);
  Serial.print(" ");
  Serial.println();
}




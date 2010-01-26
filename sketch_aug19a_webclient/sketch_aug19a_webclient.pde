#include <Ethernet.h>

byte mac[] = { 0x00, 0x50, 0xC2, 0x97, 0x21, 0xE3 };
byte ip[] = { 192, 168, 7, 17 };
byte gateway[] = { 192, 168, 7, 254 };
byte subnet[] = { 255, 255, 255, 0 };

byte server[] = {210,253,120,132};

Client client(server, 80);

void setup()
{
  Ethernet.begin(mac, ip, gateway, subnet);
  Serial.begin(9600);  
}

void loop()
{
  delay(3000);
  
  Serial.println("connecting...");
  
  if (client.connect()) {
    Serial.println("connected");
    client.println("GET /arduino HTTP/1.0");
    client.println();
  } else {
    Serial.println("connection failed");
  }

  while (client.available()) {
    char c = client.read();
    Serial.print(c);
  }
  
  if (!client.connected()) {
    Serial.println();
    Serial.println("disconnecting.");
    client.stop();
  }
}

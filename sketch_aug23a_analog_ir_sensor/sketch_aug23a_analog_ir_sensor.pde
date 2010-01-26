// 秋月の焦電型赤外線モーションセンサで検知したらLEDを点灯するサンプル
//
// 焦電型赤外線モーションセンサ
//   赤:5V, 茶色：GND、黒：Alerm。Alermはオープンコレクタ接続
//   Alermは5VとGNDで4.7kΩで接続。
//
//  5v   ----+
//       4.7オーム
//  alerm----+---- Arduinoのアナログ0番
//       4.7オーム
//  GNC   ----+
//

int count = 0;

void setup() {
 Serial.begin(9600); 
}
 
void loop() {
  int val = analogRead(0);
//  Serial.println(val);

  if (val < 400) count = 10 * 1000; // about 10s??

  if (count > 0) {
    analogWrite(11, 100); 
  }
  else {
    analogWrite(11, 0); 
  }
  
  if (count > 0) {
    count --;
  }

  delay(1);
}
 

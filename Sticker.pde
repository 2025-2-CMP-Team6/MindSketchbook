// Sticker.pde
// Owner: [Team Member's Name]

class Sticker {
  float x, y;
  PImage img;
  // w, h 변수는 이제 필요 없으므로 삭제 가능
  
  Sticker(float tempX, float tempY, PImage tempImg) {
    x = tempX;
    y = tempY;
    img = tempImg;
  }
  
  void display() {
    imageMode(CENTER);
    image(img, x, y);
  }
  
  // 마우스가 스티커 위에 있는지 확인 (표시될 크기를 인자로 받음)
  boolean isMouseOver(float displayWidth, float displayHeight) {
    float halfW = displayWidth / 2;
    float halfH = displayHeight / 2;
    return (mouseX > x - halfW && mouseX < x + halfW &&
            mouseY > y - halfH&& mouseY < y + halfH);
  }
}

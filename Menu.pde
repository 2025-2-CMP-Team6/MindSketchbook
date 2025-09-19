// Menu.pde

void drawMenu() {
  background(200, 230, 255); // 밝은 하늘색 배경
  
  // 제목 텍스트
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(50);
  text("마음 스케치북", width/2, height/3);
// 버튼 영역 확인
  float btnX = width/2;
  float btnY = height/2 + 50;
  float btnW = 400;
  float btnH = 100;
  
  isMouseOverStartBtn = mouseHober(btnX - btnW/2, btnY - btnH/2, btnW, btnH);
  
  // 마우스 위치에 따라 다른 색 그리기
  rectMode(CENTER);
  if (isMouseOverStartBtn) {
    fill(150,150,150);
  } else {
    fill(200,200,200);
  }
  rect(btnX,btnY,btnW,btnH,130);
}

void handleMenuMouse() {
  if (isMouseOverStartBtn) {
    currentState = STATE_DIARY;
  }
}

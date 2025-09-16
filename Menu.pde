// Menu.pde
// Owner: [Team Member's Name]

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
  float btnW = startBtnNormal.width;
  float btnH = startBtnNormal.height;
  
  isMouseOverStartBtn = (mouseX > btnX - btnW/2 && mouseX < btnX + btnW/2 &&
                         mouseY > btnY - btnH/2 && mouseY < btnY + btnH/2);
  
  // 마우스 위치에 따라 다른 이미지 그리기
  if (isMouseOverStartBtn) {
    image(startBtnHover, btnX, btnY);
  } else {
    image(startBtnNormal, btnX, btnY);
  }
}

void handleMenuMouse() {
  if (isMouseOverStartBtn) {
    currentState = STATE_DIARY;
  }
}

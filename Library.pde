// Library.pde
// Owner: [Team Member's Name]

void drawLibrary() {
  background(220, 240, 220); // 배경 먼저 그리기
  imageMode(CENTER); // <<< 추가
  rectMode(CENTER);  // <<< 추가
  

  // --- UI 요소들을 먼저 그립니다 (루프 바깥에서 한 번만) ---
  
  // 제목
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(40);
  text("스티커 보관함", width/2, 60);
  
  // '뒤로가기' 버튼
  fill(200);
  rectMode(CENTER); // rectMode는 한 번만 설정해도 됩니다.
  rect(width - 100, 50, 150, 50);
  fill(0);
  textSize(20);
  text("일기장으로", width - 100, 50);

  // '새 스티커 만들기' 버튼
  fill(220, 220, 150);
  rect(width/2, height - 80, 250, 60);
  fill(0);
  textSize(30);
  text("+ 새 스티커 만들기", width/2, height - 80);

  // --- 스티커 목록을 그립니다 (한 개의 루프만 사용) ---

  float boxSize = 150;   // 스티커가 들어갈 칸의 최대 크기
  int spacing = 180;
  int startX = 200;
  int startY = 200;
  int cols = 5;

  for (int i = 0; i < stickerLibrary.size(); i++) {
    Sticker s = stickerLibrary.get(i);
    int c = i % cols;
    int r = i / cols;
    
    s.x = startX + c * spacing;
    s.y = startY + r * spacing;
    
    // 원본 비율을 유지하는 새로운 너비와 높이 계산
    float w = s.img.width;
    float h = s.img.height;
    float newW, newH;
    
    if (w > h) { // 이미지가 가로로 넓다면
      newW = boxSize;
      newH = h * (boxSize / w);
    } else { // 이미지가 세로로 길거나 정사각형이라면
      newH = boxSize;
      newW = w * (boxSize / h);
    }

    // 계산된 새 크기로 이미지 그리기
    image(s.img, s.x, s.y, newW, newH);
    
    // 마우스 영역 확인
    if (s.isMouseOver(newW, newH)) {
      fill(255,255,255,1);
      rect(s.x, s.y, newW, newH); // 테두리도 새 크기에 맞게 그립니다.
      fill(0);
    }
    
  } // for 루프의 끝
} // drawLibrary() 함수의 끝


void handleLibraryMouse() {
  // '뒤로가기' 버튼 클릭 확인
  if (mouseX > width - 175 && mouseX < width - 25 && mouseY > 25 && mouseY < 75) {
    currentState = STATE_DIARY;
    return;
  }
  
  // '새 스티커 만들기' 버튼 클릭 확인
  if (mouseX > width/2 - 125 && mouseX < width/2 + 125 && 
      mouseY > height - 110 && mouseY < height - 50) {
    setupCreator(); 
    currentState = STATE_CREATOR;
    return;
  }
  
  // 스티커 클릭 확인 로직 (한 개의 루프만 사용)
  float boxSize = 150.0;
  for (Sticker s : stickerLibrary) {
    float w = s.img.width;
    float h = s.img.height;
    float newW, newH;
    
    if (w > h) {
      newW = boxSize;
      newH = h * (boxSize / w);
    } else {
      newH = boxSize;
      newW = w * (boxSize / h);
    }

    if (s.isMouseOver(newW, newH)) {
      Sticker newSticker = new Sticker(width/2, height/2, s.img);
      placedStickers.add(newSticker);
      currentState = STATE_DIARY;
      break; 
    }
  }
} // handleLibraryMouse() 함수의 끝

// Creator.pde
// Owner: [Team Member's Name]

PGraphics stickerCanvas; // 스티커를 그릴 보이지 않는 캔버스(투명 종이)
int canvasSize = 720; // 정사각형 캔버스 크기
int canvasX, canvasY; // 캔버스가 그려질 화면상의 위치
color selectedColor = color(0); // 현재 선택된 그리기 색상
float brushSize = 20; // 브러시 크기

// 이 함수는 setup() 또는 '새 스티커 만들기' 버튼을 누를 때 호출됩니다.
void setupCreator() {
  // 화면과 똑같은 크기의 그래픽 버퍼를 생성
  stickerCanvas = createGraphics(canvasSize, canvasSize);
  canvasX = (width - canvasSize) / 2; // (1280 - 720) / 2 = 280
  canvasY = (height - canvasSize) / 2; // (720 - 720) / 2 = 0
  stickerCanvas.beginDraw();
  stickerCanvas.background(255, 0); // 중요: 완전히 투명한 배경으로 시작
  stickerCanvas.endDraw();
}

void drawCreator() {
  imageMode(CORNER); // <<< 추가 (캔버스를 (0,0)에 제대로 그리기 위함)
  background(50); // 어두운 배경
  // 중앙에 정사각형 캔버스 그리기
  image(stickerCanvas, canvasX, canvasY);
  
  // 남는 공간(예: 왼쪽 0~280px)에 UI 도구 그리기

  // --- UI 그리기 ---
  // 팔레트
  fill(0); rect(50, 50, 50, 50);
  fill(255, 0, 0); rect(50, 110, 50, 50);
  fill(0, 0, 255); rect(50, 170, 50, 50);

  // '저장' 버튼
  fill(150, 255, 150); rect(width - 100, 50, 150, 50);
  fill(0); textSize(25); text("저장", width - 100, 50);
}

void handleCreatorMouse() {
  // 색상 선택
  if (mouseY > 25 && mouseY < 75) {
    if (mouseX > 25 && mouseX < 75) selectedColor = color(0);
    if (mouseX > 85 && mouseX < 135) selectedColor = color(255, 0, 0);
    if (mouseX > 145 && mouseX < 195) selectedColor = color(0, 0, 255);
  }

  // '저장' 버튼 클릭
  if (mouseX > width - 175 && mouseX < width - 25 && mouseY > 25 && mouseY < 75) {
    // 1. 현재까지 그린 캔버스를 PImage로 변환
    PImage newStickerImg = stickerCanvas.get();
    // 2. 새 스티커 객체 생성
    Sticker newSticker = new Sticker(0, 0, newStickerImg);
    // 3. 라이브러리에 추가
    stickerLibrary.add(newSticker);
    // 4. 라이브러리 화면으로 돌아가기
    currentState = STATE_LIBRARY;
  }
}


void handleCreatorDrag() {
  // 마우스가 캔버스 안쪽에 있을 때만 그리도록 제한
  if (mouseX > canvasX && mouseX < canvasX + canvasSize &&
      mouseY > canvasY && mouseY < canvasY + canvasSize) {
    
    // 화면 좌표를 캔버스 내부 좌표로 변환
    float canvasMouseX = mouseX - canvasX;
    float canvasMouseY = mouseY - canvasY;
        
    stickerCanvas.beginDraw();
    stickerCanvas.noStroke();
    stickerCanvas.fill(selectedColor);
    stickerCanvas.ellipse(canvasMouseX, canvasMouseY, brushSize, brushSize);
    stickerCanvas.endDraw();
  }
}

// Creator.pde
import java.util.LinkedList;
import java.util.Queue;


PGraphics stickerCanvas; // 캔버스 
int canvasSize = 680; // 정사각형 캔버스 크기
int canvasX, canvasY; // 캔버스가 그려질 화면상의 위치
// 그리기 도구
String tool = "brush"; // 현재 선택된 도구
float toolGab = 72; // 도구 간격
int toolPos[] = {128,104};  // 도구 좌표

PImage brushImg;  // 브러쉬 이미지
PImage paintImg;  // 페인트 이미지

PImage brushCursor;  // 브러쉬 커서
PImage paintCursor;  // 페인트 커서


color selectedColor = color(0); // 현재 선택된 그리기 색상
// 브러쉬
float brushSize = 20; // 브러시 크기
// 채우기 
float fillTolerance = 255; // 색상 오차 허용 범위 (0~255, 숫자가 클수록 관대해짐)

// 컬러 팔레트
boolean isPalleteOpen = true;  //  팔레트 열림
int[] colorPos = {1128,104}; // 색의 좌표
int colorSize = 64; // 색의 크기
float colorGab = 72; // 색의 간격
color[] palleteColor = {color(255, 0, 0),color(0, 255, 0),color(0, 0, 255), color(255, 255, 0), color(255, 0, 255), color(0, 255, 255), color(128, 128, 128), color(0, 0, 0), color(255, 255, 255)}; // 팔레트 저장 색
boolean colorToggle = false;




// 이 함수는 setup() 또는 새 스티커 만들기 버튼을 누를 때 호출
void setupCreator() {
  // 정사각형 크기의 그래픽 버퍼를 생성
  stickerCanvas = createGraphics(canvasSize, canvasSize);
  canvasX = (width - canvasSize) / 2; 
  canvasY = (height - canvasSize) / 2; 
  strokeJoin(ROUND); // 선이 만나는 부분을 둥글게
  strokeCap(ROUND);  // 선의 끝부분을 둥글게

  stickerCanvas.beginDraw();
  stickerCanvas.clear();
  stickerCanvas.endDraw();

  // 도구 아이콘
 brushImg = loadImage("brush.png");
 paintImg = loadImage("paint.png");

 // 도구 커서
 brushCursor = loadImage("brush.png");
 paintCursor = loadImage("paint.png");
}

void drawCreator() {
  stickerCanvas.endDraw();
  imageMode(CORNER);
  background(225); // 배경
  rectMode(CORNER);
  fill(255,255,255);
  rect(canvasX, canvasY, canvasSize, canvasSize); // 캔버스 사각형 그리기
  // 중앙에 정사각형 캔버스 그리기
  image(stickerCanvas, canvasX, canvasY);
  
  // --- UI ---
  // 도구
  imageMode(CORNER);
  image(brushImg, toolPos[0], toolPos[1]);
  image(paintImg, toolPos[0], toolPos[1] + toolGab);


  // 팔레트
  if (isPalleteOpen) {
    for (int i = 0; i < palleteColor.length; i++) {
      fill(palleteColor[i]);
      circle(colorPos[0], colorPos[1]+i*colorGab, colorSize);
    }
  }
  // 저장
  fill(0); textSize(25); text("저장", width - 100, 50);
}

void handleCreatorMouse() {
  // 저장
  if (mouseHober(width - 175, 25, 150, 50)) {
    PImage newStickerImg = stickerCanvas.get(); // 캔버스를 PImage로 변환
    Sticker newSticker = new Sticker(0, 0, newStickerImg);  // 스티커 객체 생성
    stickerLibrary.add(newSticker); // 라이브러리 ArrayList에 추가
    currentState = STATE_LIBRARY; // 라이브러리 화면으로
  }
  // 도구 선택
    for (int i = 0; i < 2; i++) {
      if (mouseHober(toolPos[0], toolPos[1] + i * toolGab, 64, 64)) {
        switch (i) {
          case 0:
            tool = "brush";
            cursor(brushCursor,0,0);
            break;
          case 1:
            tool = "paint";
            cursor(paintCursor,0,0);
            break;
        }
        return; // 도구가 선택되었으면 함수 종료
        }
    }
  // 채우기
  if (mouseHober(canvasX, canvasY, canvasSize, canvasSize)) {
      
  if (tool.equals("paint")) {
    float canvasMouseX = mouseX - canvasX;
    float canvasMouseY = mouseY - canvasY;
    
    stickerCanvas.loadPixels(); // 중요: 픽셀 배열을 불러옴
    
    int targetColor = stickerCanvas.get(int(canvasMouseX), int(canvasMouseY)); // 클릭한 지점의 색
    // 클릭한 지점의 색과 채울 색이 다를 때만 실행 (같은 색이면 무한루프 방지)
    if (targetColor != selectedColor) {
      floodFill(round(canvasMouseX), round(canvasMouseY), targetColor, selectedColor);
      stickerCanvas.updatePixels(); // 중요: 변경된 픽셀 정보를 캔버스에 업데이트
    }
  }
}

  // 색상 선택
    for (int i = 0; i < palleteColor.length; i++) {
      // 마우스와 색상 원 중심 사이의 거리
      float d = dist(mouseX, mouseY, colorPos[0], colorPos[1] + i * colorGab);
      if (d < colorSize / 2) {  // 거리가 반지름보다 작을경우
        selectedColor = palleteColor[i];
        return; // 색상이 선택되었으면 함수 종료
      }
    }
}

void floodFill(int startX, int startY, color targetColor, color fillColor) {
 return;
}
void handleCreatorDrag() {
  if (tool.equals("brush")) {
    // 마우스가 캔버스 안쪽에 있을 때만 그리도록 제한
    if (mouseHober(canvasX, canvasY, canvasSize, canvasSize)) {
      
      // 화면 좌표를 캔버스 내부 좌표로 변환
      float canvasMouseX = mouseX - canvasX;
      float canvasMouseY = mouseY - canvasY;
      float pcanvasMouseX = pmouseX - canvasX;
      float pcanvasMouseY = pmouseY - canvasY;
      stickerCanvas.beginDraw();  // 그림을 그릴 캔버스
      stickerCanvas.stroke(selectedColor);    // 선 색상  = 선택한 색
      stickerCanvas.strokeWeight(brushSize);  // 선 굵기
      stickerCanvas.strokeJoin(ROUND); // 선 연결부 둥글게
      stickerCanvas.strokeCap(ROUND);  // 선 끝 둥글게
      stickerCanvas.noFill();
      stickerCanvas.line(pcanvasMouseX, pcanvasMouseY, canvasMouseX, canvasMouseY); // 선 그리기
      stickerCanvas.endDraw();
    }
  }
}

// MindSketchbook.pde

// 프로그램의 현재 상태
final int STATE_MENU = 0;
final int STATE_DIARY = 1;
final int STATE_LIBRARY = 2;
final int STATE_CREATOR = 3;
int currentState = STATE_MENU; // 시작시 매뉴

boolean isMouseOverStartBtn = false; // 마우스가 버튼 위에 있는지 여부

PFont myFont; // 폰트

// 스티커 ArrayList
ArrayList<Sticker> stickerLibrary; // 보관함에 있는 모든 스티커
ArrayList<Sticker> placedStickers; // 일기장에 붙인 스티커

Sticker currentlyDraggedSticker = null; // 현재 드래그 중인 스티커
float offsetX, offsetY; // 스티커를 잡은 지점과 스티커 중심 사이의 간격


void setup() {
  size(1280, 720); // 윈도우 크기
PImage happyStickerImg;
PImage sadStickerImg;

    imageMode(CENTER);
  stickerLibrary = new ArrayList<Sticker>();
  placedStickers = new ArrayList<Sticker>();
  
  // data 폴더에서 이미지 불러오기
  happyStickerImg = loadImage("happy.png");
  sadStickerImg = loadImage("sad.png");
  myFont = loadFont("NanumGothic-48.vlw");

  // 폰트 설정
  textFont(myFont); 
  
  // 불러온 이미지로 스티커 객체를 만들어 보관함에 추가
  stickerLibrary.add(new Sticker(0, 0, happyStickerImg));
  stickerLibrary.add(new Sticker(0, 0, sadStickerImg));
  setupCreator();
}

void draw() {
  // 현재 상태(currentState)에 따라 적절한 함수를 호출
  switch (currentState) {
    case STATE_MENU:
      drawMenu();
      break;
    case STATE_DIARY:
      drawDiary();
      break;
    case STATE_LIBRARY:
      drawLibrary();
      break;
      case STATE_CREATOR:
      drawCreator();
      break;
    default :
    break;
    }
    fill(0);
    textAlign(LEFT, TOP);
    textSize(14);
    text("마우스 : "+mouseX + ", " + mouseY + ", 색상 : "+ get(int(mouseX), int(mouseY)), 10, 10); // 디버깅용 마우스 좌표
}

// 마우스 클릭
void mousePressed() {
  switch (currentState) {
    case STATE_MENU:
      handleMenuMouse();
      break;
    case STATE_DIARY:
      handleDiaryMouse();
      break;
    case STATE_LIBRARY:
      handleLibraryMouse();
      break;
      case STATE_CREATOR:
      handleCreatorMouse();
      break;
  }
}
// 마우스 드래그
void mouseDragged() {
  if (currentState == STATE_DIARY) {
    handleDiaryDrag();
  }
  if (currentState == STATE_CREATOR) {
    handleCreatorDrag();
  }
}

// 마우스 놓을때
void mouseReleased() {
  if (currentState == STATE_DIARY) {
    handleDiaryRelease();
  }
}
// 마우스 호버링
boolean mouseHober(float x, float y, float w, float h) {
  if ((mouseY > y && mouseY < y+h) && (mouseX > x && mouseX < x+w)) {
    return true;
  }
  else {
    return false;
  }
}

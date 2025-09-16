// MindSketchbook.pde
// Owner: [Your Name]

// 프로그램의 현재 상태를 관리하는 변수 (State Machine)
final int STATE_MENU = 0;
final int STATE_DIARY = 1;
final int STATE_LIBRARY = 2;
final int STATE_CREATOR = 3;
int currentState = STATE_MENU; // 앱 시작 시 메뉴 화면으로 설정

// 버튼 이미지 
PImage startBtnNormal, startBtnHover;
boolean isMouseOverStartBtn = false; // 마우스가 버튼 위에 있는지 확인

PFont myFont; // 1. 폰트를 담을 변수를 전역으로 선언

// 스티커들을 관리할 ArrayList 선언
ArrayList<Sticker> stickerLibrary; // 보관함에 있는 모든 스티커
ArrayList<Sticker> placedStickers; // 일기장에 붙인 스티커

Sticker currentlyDraggedSticker = null; // 현재 드래그 중인 스티커를 저장할 변수
float offsetX, offsetY; // 스티커를 잡은 지점과 스티커 중심 사이의 간격


void setup() {
  size(1280, 720); // 윈도우 크기 설정
PImage happyStickerImg;
PImage sadStickerImg;

    imageMode(CENTER);
startBtnNormal = loadImage("button_start_normal.png");
startBtnHover = loadImage("button_start_hover.png");
  stickerLibrary = new ArrayList<Sticker>();
  placedStickers = new ArrayList<Sticker>();
  
  // data 폴더에서 이미지 불러오기
  happyStickerImg = loadImage("happy.png");
  sadStickerImg = loadImage("sad.png");
  // 파일 이름은 폰트 생성 시 결정한 이름과 크기로 정확히 적어야 합니다.
  myFont = loadFont("NanumGothic-48.vlw");
  // 3. 프로그램의 기본 폰트로 설정합니다.
  textFont(myFont); 
  
  // 불러온 이미지로 스티커 객체를 만들어 보관함에 추가
  // 화면에 바로 그리는 게 아니므로, 위치(x, y)는 일단 0, 0으로 둡니다.
  stickerLibrary.add(new Sticker(0, 0, happyStickerImg));
  stickerLibrary.add(new Sticker(0, 0, sadStickerImg));
  // 여기에 더 많은 기본 스티커를 추가할 수 있습니다.
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
  }
}

// 마우스 클릭 이벤트를 현재 상태에 맞게 전달
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
  void mouseDragged() {
  if (currentState == STATE_DIARY) {
    handleDiaryDrag();
  }
  if (currentState == STATE_CREATOR) {
    handleCreatorDrag();
  }
}

// <<< 추가: 마우스 버튼에서 손을 뗄 때 호출되는 함수 >>>
void mouseReleased() {
  if (currentState == STATE_DIARY) {
    handleDiaryRelease();
  }
}

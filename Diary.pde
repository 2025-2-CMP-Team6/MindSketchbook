// Diary.pde
// Owner: [Team Member's Name]

void drawDiary() {
  background(255, 250, 220);
  
  // UI: '스티커 보관함' 버튼
  fill(200, 220, 255);
  rectMode(CENTER);
  rect(120, 60, 200, 60);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(25);
  text("스티커 보관함", 120, 60);

  // 일기장에 붙여진 스티커들을 모두 그리기
// 일기장에 붙여진 스티커들을 모두 그리기
  float defaultStickerSize = 200.0; // 일기장에 표시될 스티커의 기본 최대 크기

  for (Sticker s : placedStickers) {
    // 라이브러리에서 했던 것처럼, 여기서도 비율에 맞는 크기를 계산합니다.
    float w = s.img.width;
    float h = s.img.height;
    float displayW, displayH;

    if (w > h) {
      displayW = defaultStickerSize;
      displayH = h * (defaultStickerSize / w);
    } else {
      displayH = defaultStickerSize;
      displayW = w * (defaultStickerSize / h);
    }

    // 계산된 크기로 스티커를 그립니다. (s.display() 대신 image() 직접 사용)
    imageMode(CENTER);
    image(s.img, s.x, s.y, displayW, displayH);
  }
}

void handleDiaryMouse() { // 이 함수는 마우스를 "처음 눌렀을 때만" 호출됩니다.
  // '스티커 보관함' 버튼 클릭 확인
  if (mouseX > 20 && mouseX < 220 && mouseY > 30 && mouseY < 90) {
    currentState = STATE_LIBRARY;
    return; // 버튼을 눌렀으면 스티커 잡기 로직은 실행하지 않음
  }
  
 // 스티커 위에서 마우스를 눌렀는지 확인 (보이는 크기와 클릭 영역을 일치)
  float defaultStickerSize = 200.0; // 위 drawDiary와 동일한 크기 사용
  
  for (int i = placedStickers.size() - 1; i >= 0; i--) {
    Sticker s = placedStickers.get(i);
    
    // 표시되는 크기를 다시 계산
    float w = s.img.width;
    float h = s.img.height;
    float displayW, displayH;

    if (w > h) {
      displayW = defaultStickerSize;
      displayH = h * (defaultStickerSize / w);
    } else {
      displayH = defaultStickerSize;
      displayW = w * (defaultStickerSize / h);
    }
    
    // 계산된 크기를 기준으로 마우스 위치를 확인합니다.
    if (s.isMouseOver(displayW, displayH)) {
      currentlyDraggedSticker = s;
      offsetX = mouseX - s.x;
      offsetY = mouseY - s.y;
      break;
    }
  }
}

// <<< 추가: 드래그하는 동안 계속 호출될 함수 >>>
void handleDiaryDrag() {
  // 현재 잡고 있는 스티커가 있다면
  if (currentlyDraggedSticker != null) {
    // 스티커의 위치를 마우스 위치로 업데이트 (오프셋 적용)
    currentlyDraggedSticker.x = mouseX - offsetX;
    currentlyDraggedSticker.y = mouseY - offsetY;
  }
}

// <<< 추가: 마우스에서 손을 떼면 호출될 함수 >>>
void handleDiaryRelease() {
  // 잡고 있던 스티커를 '놓아준다'
  currentlyDraggedSticker = null;
}

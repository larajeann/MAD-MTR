import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

enum Level { Hard, Medium, Easy }

List<String> fillSourceArray() {
  return [
    'assets/animalspics/kare.png',
    'assets/animalspics/kare.png',
    'assets/animalspics/sinigang.png',
    'assets/animalspics/sinigang.png',
    'assets/animalspics/adobo.png',
    'assets/animalspics/adobo.png',
    'assets/animalspics/dingdong.png',
    'assets/animalspics/dingdong.png',
    'assets/animalspics/leah.png',
    'assets/animalspics/leah.png',
    'assets/animalspics/luna.png',
    'assets/animalspics/luna.png',
    'assets/animalspics/rizal.png',
    'assets/animalspics/rizal.png',
    'assets/animalspics/wang.png',
    'assets/animalspics/wang.png',
    'assets/animalspics/manny.png',
    'assets/animalspics/manny.png',
  ];
}

List<String> fillSourceArrayM() {
  return [
    'assets/animalspics/dingdong.png',
    'assets/animalspics/dingdong.png',
    'assets/animalspics/leah.png',
    'assets/animalspics/leah.png',
    'assets/animalspics/luna.png',
    'assets/animalspics/luna.png',
    'assets/animalspics/rizal.png',
    'assets/animalspics/rizal.png',
    'assets/animalspics/wang.png',
    'assets/animalspics/wang.png',
    'assets/animalspics/manny.png',
    'assets/animalspics/manny.png',
  ];
}
List<String> fillSourceArrayH() {
  return [
    'assets/animalspics/1.png',
    'assets/animalspics/1.png',
    'assets/animalspics/2.png',
    'assets/animalspics/2.png',
    'assets/animalspics/3.png',
    'assets/animalspics/3.png',
    'assets/animalspics/4.png',
    'assets/animalspics/4.png',
    'assets/animalspics/5.png',
    'assets/animalspics/5.png',
    'assets/animalspics/6.png',
    'assets/animalspics/6.png',
    'assets/animalspics/7.png',
    'assets/animalspics/7.png',
    'assets/animalspics/8.png',
    'assets/animalspics/8.png',
    'assets/animalspics/9.png',
    'assets/animalspics/9.png',
  ];
}
List<String> getSourceArray(
  Level level,
) {
  List<String> levelAndKindList = <String>[]; 
  List<String> sourceArray = fillSourceArray().cast<String>();
  List<String> sourceArrayM = fillSourceArrayM().cast<String>();
  List<String> sourceArrayH = fillSourceArrayH().cast<String>();
  if (level == Level.Hard) {
    for (int i = 0; i < 18; i++) {
      levelAndKindList.add(sourceArrayH[i]);
    }
  } 
  else if (level == Level.Medium) {
    for (int i = 0; i < 12; i++) {
      levelAndKindList.add(sourceArrayM[i]);
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 6; i++) {
      levelAndKindList.add(sourceArray[i]);
    }
  }

  levelAndKindList.shuffle();
  return levelAndKindList;
}

List<bool> getInitialItemState(Level level) {
  List<bool> initialItemState = <bool>[]; // Explicitly specify List<bool>
  if (level == Level.Hard) {
    for (int i = 0; i < 18; i++) {
      initialItemState.add(true);
    }
  } else if (level == Level.Medium) {
    for (int i = 0; i < 12; i++) {
      initialItemState.add(true);
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 6; i++) {
      initialItemState.add(true);
    }
  }
  return initialItemState;
}

List<GlobalKey<FlipCardState>> getCardStateKeys(Level level) {
  List<GlobalKey<FlipCardState>> cardStateKeys = <GlobalKey<FlipCardState>>[]; 
  if (level == Level.Hard) {
    for (int i = 0; i < 18; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  } else if (level == Level.Medium) {
    for (int i = 0; i < 12; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 6; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  }
  return cardStateKeys;
}

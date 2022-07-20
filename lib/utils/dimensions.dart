import 'dart:ui' as ui;

class Dimensions {
  static double screenWidth =
      ui.window.physicalSize.width / ui.window.devicePixelRatio;
  static double screenHeight =
      ui.window.physicalSize.height / ui.window.devicePixelRatio;

  // Detail Page
  static double iconSize16 = screenHeight / 52.75;
  static double detailPageImageHeight = screenHeight / 1.7;
  static double detailPageBottomHeight = screenHeight / 8.03;
}



import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/painting.dart' as painting;
import 'package:flutter/services.dart';

class Utils {
  final context;
  Utils({this.context}) :super();

  static double getWidth() {
    return  ui.window.physicalSize.width;
  }
  static double getlRatio () {
    return ui.window.devicePixelRatio;
  }
  static double getHeight() {
    return  ui.window.physicalSize.height;
  }
  static  ByteData data;
  static Future initStar()async{
   data = await rootBundle.load("assets/images/star.png");
  return new Future(()=>null);
}
  static Future<ui.Image> getImage(int width,int height) async {
    Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),targetWidth: width,targetHeight: height);
    FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
}
class CanvasOffset extends Offset {
  const CanvasOffset(double width, double height) : super(width, height) ;
}
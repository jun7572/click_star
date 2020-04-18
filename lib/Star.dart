import 'dart:math';

import 'package:clickstar/Utils.dart';
import 'dart:ui' as ui;
import 'dart:ui';
class Star{
  ui.Image image;
  //初始位置
  double startX;
  double startY;
  //位置
  double positionX;
  double positionY;
  //速度
  double speedX;
  double speedY;
  //速度改变
  double speedChangeX;
  double speedChangeY;

  int Rcolor=0;
  int Gcolor=0;
  int Bcolor=0;
  int width;
  int height;
  int alpha=255;
  Future init(double startX,double startY)async{
    positionX=startX;
    positionY=startY;
    this.startX=startX;
    this.startY=startY;
    width=Random().nextInt(10)+10;
    height=width;
    speedX=(Random().nextInt(20)-10).toDouble()/1000;
    speedY=(Random().nextInt(20)-10).toDouble()/1000;

    speedChangeX=(Random().nextInt(30)-10).toDouble()/10;
    speedChangeY=(Random().nextInt(30)-10).toDouble()/10;
    Rcolor=Random().nextInt(255);
    Gcolor=Random().nextInt(255);
    Bcolor=Random().nextInt(255);

    image= await Utils.getImage(width,height);
    return new Future(()=>null);

  }
  void paint(Canvas canvas, Size size) {
    positionX+=speedX;
    positionY+=speedY;
    speedX+=speedChangeX;
    speedY+=speedChangeY;

  if((positionX>50+startX )| (positionY > 50+startY)|(positionX < -50+startX)|(positionY < -50+startY)){//超过一定距离就渐变透明
    alpha-=10;
    alpha= alpha>=255?255:alpha;
    var paint = ui.Paint();
    paint.colorFilter=ui.ColorFilter.mode(ui.Color.fromARGB(alpha, 0, 0, 0), ui.BlendMode.clear);

    canvas.drawImage(image, Offset(positionX, positionY), paint);
  }else{
    var paint = ui.Paint();
    paint.colorFilter=ui.ColorFilter.mode(ui.Color.fromARGB(255, Rcolor, Gcolor, Bcolor), ui.BlendMode.srcATop);
    canvas.drawImage(image, Offset(positionX, positionY), paint);
  }

  }
}
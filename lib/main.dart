
import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:clickstar/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Star.dart';

void main(){

  runApp(MyApp());

}

enum StarStatus { loading, loaded }
Size window_size;
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  StarStatus status=StarStatus.loading;

  @override
  Widget build(BuildContext context) {
    window_size=  MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: status==StarStatus.loading?Container():Center(
        child: Stack(
          children: <Widget>[
           GestureDetector(
             onTapDown: (detail){

               //本地坐标,非世界坐标
               genStars(detail.localPosition);

             },
             //实际应用可能要调整坐标系
             child:SizedBox(
               height: window_size.height,
               width: window_size.width,
               child: CustomPaint(

                 painter: MyPainter(stars),

               ),
             ),
           ),

          ],
        ),
      ),

    );
  }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initAssets();

  }
  //生成星星
  genStars(Offset offset)async{
    stars.clear();
    for(int i=0;i<10;i++){
      Star s= Star();
      await s.init(offset.dx,offset.dy);
      stars.add(s);
    }

    progressController.reset();
    progressController.forward();
  }
  AnimationController progressController;
  int ii=0;
  initAssets()async{


    progressController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 1000))

      ..addListener(() {

        setState(() {

        });
      })..addStatusListener((status){
        print("object=="+status.toString());
        if(status==AnimationStatus.completed){//完了就处理之后的事
          print("object==completed");
//          stars.clear();
          setState(() {

          });
        }
      });

   await Utils.initStar();
  //星星的数量
//  for(int i=0;i<30;i++){
//    Star s= Star();
//     await s.init();
//     stars.add(s);
//  }

    setState(() {
      status=StarStatus.loaded;
    });

  }
  List<Star> stars=[];
}
class MyPainter extends CustomPainter{
  Paint painter = new Paint()..isAntiAlias=true;
  List<Star> stars=[];
  MyPainter(this.stars);
  @override
  void paint(Canvas canvas, Size size) {
    //背景色
    canvas.drawColor(Colors.white, BlendMode.src);
    //各星星负责自己的位置变换
    for(int i=0;i<stars.length;i++){
      stars[i].paint(canvas, size);
    }


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {


    return true;
  }


}

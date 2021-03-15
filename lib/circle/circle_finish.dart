
import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/tszar/Desktop/program/finished/lib/circle/paint_circle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart'as ion;


class CirclePage extends StatefulWidget {

  CirclePage({
    @required this.countdownTime,
    @required this.wrong,
  });
  final int countdownTime;
  final int wrong;



  @override
  CirclePageState createState() {
    return new CirclePageState(countdown:countdownTime,wrong: wrong );
  }
}

class CirclePageState
    extends State<CirclePage> with TickerProviderStateMixin {

  CirclePageState({
    @required this.countdown,
    @required this.wrong,
  });
  final int countdown;
  final int wrong;


  MaterialColor theColor;
  Timer timer;
  int _countdownTime;
  AnimationController _animation;
  AnimationController _animation1;
  AnimationController _animation2;
  AnimationController _animation3;
  AnimationController _animation4;


  @override
  void initState() {
    super.initState();

    if(wrong>0){
      theColor=Colors.red;
    }else{
      theColor=Colors.blue;
    }

    _countdownTime = countdown;
    _animation =
    new AnimationController(vsync: this,
        duration: Duration(seconds: 7),
        upperBound: 1,
        lowerBound: 0.00);
    bool isForward = true;
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward) {
          _animation.repeat();
        }
      }
    });
    _animation1 =
    new AnimationController(vsync: this,
        duration: Duration(seconds: 6),
        upperBound: 1,
        lowerBound: 0.00);
    bool isForward1 = true;
    _animation1.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward1 = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward1) {
          _animation1.repeat();
        }
      }
    });
    _animation2 =
    new AnimationController(vsync: this,
        duration: Duration(seconds: 5),
        upperBound: 1,
        lowerBound: 0.00);
    bool isForward2 = true;
    _animation2.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward2 = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward2) {
          _animation2.repeat();
        }
      }
    });
    _animation3 =
    new AnimationController(vsync: this,
        duration: Duration(seconds: 4),
        upperBound: 1,
        lowerBound: 0.00);
    bool isForward3 = true;
    _animation3.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward3 = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward3) {
          _animation3.repeat();
        }
      }
    });
    _animation4 =
    new AnimationController(vsync: this,
        duration: Duration(seconds: 3),
        upperBound: 1,
        lowerBound: 0.0);

    bool isForward4 = true;
    _animation4.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward4 = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward4) {
          _animation4.repeat();
        }
      }
    });
  }
  @override
  void dispose() {
    _animation.dispose();
    _animation1.dispose();
    _animation2.dispose();
    _animation3.dispose();
    _animation4.dispose();
    timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('核查仪_hcy1一区域站_wxbh1',style: TextStyle(color: Color(0xFF333333)),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.arrow_back_ios,color: Color(0xFF2B313D),),
        actions: [
          Icon(ion.Ionicons.ellipsis_vertical_outline,color: Color(0xFF333333),)
        ],
      ),
      body: Card(
        child: Column(
          children: [
            Expanded(child: Container(
              child: Stack(
                alignment: Alignment.center,
                children: [

                  Container(
                    child: new AnimatedBuilder(
                      animation: _animation,
                      builder: (BuildContext context, Widget child) {
                        return Stack(
                          children: <Widget>[
                            CirclePaint(

                              color: theColor[50],
                              radius: 200.0,
                              strokeWidth: 20.0,
                              value: _animation.value,
                            ),
                          ],
                        );
                      },
                    ),
                    alignment: Alignment.center,
                  ),
                  Container(
                    child: new AnimatedBuilder(
                      animation: _animation1,
                      builder: (BuildContext context, Widget child) {
                        return Stack(
                          children: <Widget>[
                            CirclePaint(
                              color: theColor[100],
                              radius: 200.0,
                              strokeWidth: 16.0,
                              value: _animation1.value,
                            ),
                          ],
                        );
                      },
                    ),
                    alignment: Alignment.center,
                  ),
                  Container(
                    child: new AnimatedBuilder(
                      animation: _animation2,
                      builder: (BuildContext context, Widget child) {
                        return Stack(
                          children: <Widget>[
                            CirclePaint(
                              color: theColor[200],
                              radius: 200.0,
                              strokeWidth: 12.0,
                              value: _animation2.value,
                            ),
                          ],
                        );
                      },
                    ),
                    alignment: Alignment.center,

                  ),
                  Container(
                    child: new AnimatedBuilder(
                      animation: _animation3,
                      builder: (BuildContext context, Widget child) {
                        return Stack(
                          children: <Widget>[
                            CirclePaint(
                              color: theColor[300],
                              radius: 200.0,
                              strokeWidth: 8.0,
                              value: _animation3.value,
                            ),
                          ],
                        );
                      },
                    ),
                    alignment: Alignment.center,
                  ),
                  Container(
                    child: new AnimatedBuilder(
                      animation: _animation4,
                      builder: (BuildContext context, Widget child) {
                        return Stack(
                          children: <Widget>[
                            CirclePaint(
                              color: theColor,
                              radius: 200.0,
                              strokeWidth: 4.0,
                              value: _animation4.value,
                            ),
                          ],
                        );
                      },
                    ),
                    alignment: Alignment.center,
                  ),
                  Container(
                    height: 360,
                    width: 360,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: theColor[300],width: 5),
                      boxShadow: [
                        BoxShadow(
                          color: theColor[200],
                          blurRadius: 10,
                        ),
                      ],
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                  ),

                  Container(
                      child: Column(
                        children: [SizedBox(height: 190,),
                          Text('0', style: TextStyle(fontSize: 120, color: theColor),),
                          Text('正常', style: TextStyle(fontSize: 20, color: theColor),),
                          SizedBox(height: 30,),
                          Container(
                            child: Text('${_countdownTime ~/ 60 < 10
                                ? '0${_countdownTime ~/ 60}'
                                : '${_countdownTime ~/ 60}'}:${_countdownTime %
                                60 < 10
                                ? '0${_countdownTime % 60}'
                                : '${_countdownTime % 60}'}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      )
                  )
                ],
              ),
            ), flex: 2,),
            Expanded(
              child: Row(
                children: [
                  SizedBox(width: 60,),
                  Expanded(
                    child: InkWell(
                      child: Container(
                        margin: EdgeInsets.all(80),
                        child: Container(
                          height: 35,
                          width: 35,
                          alignment: Alignment.center,
                          child: Container(color: Colors.blue,),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 10,
                            ),
                          ],
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                      ),
                      onTap: () {
                        if(timer==null){
                          startCountdownTimer();
                        }else if(timer.isActive==false){
                          startCountdownTimer();
                        }
                        _animation1.forward();
                        _animation.forward();
                        _animation2.forward();
                        _animation3.forward();
                        _animation4.forward();
                      },
                    ),
                    flex: 1,),
                  Expanded(
                    child: InkWell(
                      child: Container(
                        margin: EdgeInsets.all(80),
                        child: Row(
                          children: [
                            SizedBox(width: 20,),
                            Expanded(
                              child: Container(
                                  color: Colors.blue,
                                  margin: EdgeInsets.only(
                                      top: 35, bottom: 35, left: 8, right: 8)
                              ),),
                            Expanded(child: Container(
                                color: Colors.blue,
                                margin: EdgeInsets.only(
                                    top: 35, bottom: 35, left: 8, right: 8)
                            ),),
                            SizedBox(width: 20,),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 10,
                            ),
                          ],
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                      ),
                      onTap: () {
                        print(timer.isActive);
                        timer.cancel();
                        print(timer.isActive);
                      },
                    ),
                    flex: 1,),
                  SizedBox(width: 60,),
                ],
              ), flex: 1,),
            SizedBox(height: 100,)
          ],
        ),),
    );
  }

  void startCountdownTimer() {
    const oneSec = const Duration(seconds: 1);
    var callback = (timer) => {
      setState(() {
        if (_countdownTime < 1) {
          timer.cancel();
        } else {
          _countdownTime = _countdownTime - 1;
        }
      })
    };
    timer = Timer.periodic(oneSec, callback);
  }

}


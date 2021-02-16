import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:looploop/constant.dart';
import 'package:looploop/time.dart';

import 'dart:async';
import '../time.dart';
import 'component/pause_button.dart';

// ignore: must_be_immutable
class Run extends StatefulWidget {
  final Time init;
  Time run;
  Run(this.init, this.run);

  @override
  _RunState createState() => _RunState();
}

class _RunState extends State<Run> {
  Color screenColor;
  Timer _timer;
  Time init;
  Time run;
  bool start = true;
  bool _isrest = false;
  bool _isrunning = true;
  int s = 0;

  Widget toStr(int a) {
    int k = a ~/ 60;
    int s = a % 60;
    String min = k.floor().toString().padLeft(2, '0');
    String sec = s.floor().toString().padLeft(2, '0');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 3,
          child: Text(
            min,
            style: textStyle(),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 3,
          child: Text(
            sec,
            style: textStyle(),
          ),
        ),
      ],
    );
  }

  TextStyle textStyle() {
    return TextStyle(
        fontSize: MediaQuery.of(context).size.height / 10,
        fontWeight: FontWeight.bold);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initState() {
    setinit();
    _startTimer();
    super.initState();
  }

  Future setinit() async {
    setState(() {
      init = widget.init;
      run = widget.run;
    });
  }

  Future _startTimer() async {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted)
        setState(() {
          if (start) {
            if (run.times > 0) {
              if (run.works > 0) {
                if (_isrest == true) {
                  _isrest = false;
                }
                run.works--;
                s++;
              }
              if (run.works == 0) {
                if (run.rests == 0) {
                  run.times--;
                  _isrest = false;
                  run.works = init.works;
                  run.rests = init.rests;
                } else {
                  if (_isrest == false) {
                    _isrest = true;
                  }
                  run.rests--;
                }
              }
            }
            if (run.times == 1) {
              if (run.works == 0) {
                {
                  start = false;
                  _isrunning = false;
                  _timer.cancel();
                }
              }
            }
          }
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    AudioCache audioCache = AudioCache();

    Size size = MediaQuery.of(context).size;
    return (_isrunning)
        ? Scaffold(
            bottomNavigationBar: SizedBox(
              height: size.height / 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                        child: Text(
                          '+20s',
                          style: TextStyle(
                              fontSize: size.height / 19, color: kwhiteColor),
                        ),
                        onPressed: () {
                          setState(() {
                            if (_isrest) {
                              run.rests += 20;
                            } else {
                              run.works += 20;
                            }
                          });
                        }),
                  ),
                  Expanded(
                    child: IconButton(
                        iconSize: size.height / 10,
                        icon: Icon(
                          Icons.skip_next,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_isrest) {
                              run.rests = 0;
                            } else {
                              run.works = 0;
                            }
                          });
                        }),
                  ),
                  // ignore: deprecated_member_use
                ],
              ),
            ),
            backgroundColor: (_isrest) ? kgreenColor : kblueColor,
            appBar: AppBar(
              centerTitle: true,
              title: (_isrest)
                  ? Text(
                      'REST',
                    )
                  : Text(
                      'WORK',
                    ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                (_isrest) ? toStr(run.rests) : toStr(run.works),

                Container(
                  child: Text((init.times - run.times + 1).toString() +
                      '/' +
                      init.times.toString()),
                ),
                SizedBox(
                  height: 10,
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  color: (start) ? kredColor : kstartColor,
                  onPressed: () {
                    setState(() {
                      start = !start;
                    });
                  },
                  child: PauseButton(
                    child: (start) ? 'STOP' : 'Start',
                  ),
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    toTime(s),
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 14),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isrunning = false;
                          run = init;
                        });
                        audioCache.play('End.mp3');
                        Navigator.pop(context);
                      },
                      child: Text('DONE'),
                    )
                  ])
                ]));
  }
}

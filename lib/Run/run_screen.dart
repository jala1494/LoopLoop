import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:looploop/constant.dart';
import 'package:looploop/time.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../time.dart';
import 'component/pause_button.dart';

// ignore: must_be_immutable
class Run extends StatefulWidget {
  bool _isSec;
  Time run;
  Time init;
  Run(this.run, this.init, this._isSec);

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
  bool sound = true;
  bool vibe = true;
  int s = 0;
  AudioCache audioCache = AudioCache();

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
    super.initState();
    _loadData();
    setinit();
    _startTimer();
  }

  _loadData() async {
    print('load');
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      sound = (prefs.getBool('sound') ?? true);
      vibe = (prefs.getBool('vibe') ?? true);
    });
  }

  setinit() async {
    setState(() {
      init = widget.init;
      run = widget.run;
    });
  }

  Future _startTimer() async {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) if (start) {
        soundvibe(run, init, sound, vibe);
        setState(() {
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
      }
    });
  }

  void soundvibe(Time run, Time init, bool sound, bool vibe) {
    if (sound) {
      if (run.works == init.works) {
        audioCache.play('audio/Start.mp3');
      }
      if (run.works == init.works ~/ 2) {
        audioCache.play('audio/half.mp3');
      }
      if (run.works == 1 && run.rests == init.rests) {
        if (sound) audioCache.play('audio/End.mp3');
      }
    }
    if (Platform.isAndroid) {
      if (vibe) {
        if (run.works == init.works) {
          Vibration.vibrate(
            pattern: [10, 200, 30, 300, 10, 200],
          );
        }
        if (run.works == init.works ~/ 2) {
          Vibration.vibrate(
            pattern: [10, 100, 50, 200],
          );
        }
        if (run.works == 1 && run.rests == init.rests) {
          Vibration.vibrate(pattern: [10, 1000]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          (widget._isSec) ? '+20s' : '+5m',
                          style: TextStyle(
                              fontSize: size.height / 19, color: kwhiteColor),
                        ),
                        onPressed: () {
                          setState(() {
                            if (_isrest) {
                              (widget._isSec)
                                  ? run.rests += 20
                                  : run.rests += 300;
                            } else {
                              (widget._isSec)
                                  ? run.works += 20
                                  : run.works += 300;
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

                        Navigator.pop(context);
                      },
                      child: Text('DONE'),
                    )
                  ])
                ]));
  }
}

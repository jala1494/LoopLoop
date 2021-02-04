import 'package:flutter/material.dart';
import 'package:looploop/Home/component/body.dart';
import 'package:looploop/constant.dart';

import 'dart:async';
import '../time.dart';

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
  Widget toStr(int a) {
    int k = a ~/ 60;
    int s = a % 60;
    String min = k.floor().toString().padLeft(2, '0');
    String sec = s.floor().toString().padLeft(2, '0');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 3,
          child: Text(
            min,
            style: textStyle(),
          ),
        ),
        Container(
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
    _startTimer();
    super.initState();
  }

  bool start = true;
  bool _isrest = false;
  bool _isrunning = true;
  Future _startTimer() async {
    widget.run.works = widget.init.works;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted)
        setState(() {
          if (start) {
            if (widget.run.times > 0) {
              if (widget.run.works > 0) {
                if (_isrest == true) {
                  _isrest = false;
                }
                widget.run.works--;
              }
              if (widget.run.works == 0) {
                if (widget.run.rests == 0) {
                  widget.run.times--;
                  _isrest = false;
                  widget.run.works = widget.init.works;
                  widget.run.rests = widget.init.rests;
                } else {
                  if (_isrest == false) {
                    _isrest = true;
                  }
                  widget.run.rests--;
                }
              }
            }
            if (widget.run.times == 1) {
              if (widget.run.works == 0) {
                {
                  start = false;
                  _isrunning = false;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _buildPopupDialog(context),
                  );
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
    return Scaffold(
      backgroundColor: (_isrest) ? kgreenColor : kblueColor,
      appBar: AppBar(
        title: (_isrest)
            ? Text(
                'REST',
              )
            : Text('WORK'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          (_isrest) ? toStr(widget.run.rests) : toStr(widget.run.works),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                  child: Icon(Icons.skip_next),
                  onPressed: () {
                    setState(() {
                      if (_isrest) {
                        widget.run.rests = 0;
                      } else {
                        widget.run.works = 0;
                      }
                    });
                  }),
              SizedBox(
                width: 20,
              ),
              RaisedButton(
                  child: Text('+20s'),
                  onPressed: () {
                    setState(() {
                      if (_isrest) {
                        widget.run.rests += 20;
                      } else {
                        widget.run.works += 20;
                      }
                    });
                  }),
              RaisedButton(onPressed: () {})
            ],
          ),
          Container(
            child: Text((widget.init.times - widget.run.times + 1).toString() +
                '/' +
                widget.init.times.toString()),
          )
        ],
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text('Popup example'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Hello"),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Body()));
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
}

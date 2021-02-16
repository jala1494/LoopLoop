import 'package:flutter/material.dart';
import 'package:looploop/Run/run_screen.dart';
import 'package:looploop/constant.dart';
import 'package:looploop/time.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  final bool _isSec;
  Body(this._isSec);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Time mininit = Time(1800, 600, 3);
  Time init = Time(45, 15, 5);
  Time run = Time(0, 0, 0);
  bool vibe = true;
  bool sound = true;

  @override
  void dispose() {
    super.dispose();
  }

  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    print('load');
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      init.works = (prefs.getInt('work') ?? 45);
      init.rests = (prefs.getInt('rest') ?? 15);
      init.times = (prefs.getInt('times') ?? 5);
      mininit.works = (prefs.getInt('workmin') ?? 1800);
      mininit.rests = (prefs.getInt('restmin') ?? 600);
      mininit.times = (prefs.getInt('timesmin') ?? 3);

      sound = (prefs.getBool('sound') ?? true);
      vibe = (prefs.getBool('vibe') ?? true);
    });
  }

  _saveData() async {
    print('saveCounter');
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('work', init.works);
      prefs.setInt('rest', init.rests);
      prefs.setInt('times', init.times);
      prefs.setBool('sound', sound);
      prefs.setBool('vibe', vibe);
      prefs.setInt('workmin', mininit.works);
      prefs.setInt('restmin', mininit.rests);
      prefs.setInt('timesmin', mininit.times);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Card(
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('WORK'),
                      // ignore: deprecated_member_use
                      RaisedButton(onPressed: () {
                        setState(() {
                          (widget._isSec) ? init.works++ : mininit.works += 60;
                        });
                      }),
                      Var(
                          vari: (widget._isSec)
                              ? init.works.toString()
                              : (mininit.works ~/ 60).toString()),
                      // ignore: deprecated_member_use
                      RaisedButton(onPressed: () {
                        setState(() {
                          (widget._isSec) ? init.works-- : mininit.works -= 60;
                        });
                      }),
                    ],
                  ),
                  color: kPrimaryColor,
                )),
                Expanded(
                    child: Card(
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('REST'),
                      // ignore: deprecated_member_use
                      RaisedButton(onPressed: () {
                        setState(() {
                          (widget._isSec) ? init.rests++ : mininit.rests += 60;
                        });
                      }),
                      Var(
                          vari: (widget._isSec)
                              ? init.rests.toString()
                              : (mininit.rests ~/ 60).toString()),
                      // ignore: deprecated_member_use
                      RaisedButton(onPressed: () {
                        setState(() {
                          (widget._isSec) ? init.rests-- : mininit.rests -= 60;
                        });
                      }),
                    ],
                  ),
                  color: kPrimaryColor,
                ))
              ]),
        ),
        Expanded(
            child: Row(
          children: [
            Expanded(
                child: Card(
              color: kPrimaryColor,
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('TIMES'),
                  // ignore: deprecated_member_use
                  RaisedButton(onPressed: () {
                    setState(() {
                      (widget._isSec) ? init.times++ : mininit.times++;
                    });
                  }),
                  Var(
                      vari: (widget._isSec)
                          ? init.times.toString()
                          : mininit.times.toString()),
                  // ignore: deprecated_member_use
                  RaisedButton(onPressed: () {
                    setState(() {
                      (widget._isSec) ? init.times-- : mininit.times--;
                    });
                  }),
                ],
              ),
            )),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Card(
                      color: kPrimaryColor,
                      cardChild: GestureDetector(
                        onTap: () {
                          setState(() {
                            sound = !sound;
                          });
                        },
                        child: Icon(sound ? Icons.volume_up : Icons.volume_off,
                            size: MediaQuery.of(context).size.height / 10),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      color: kPrimaryColor,
                      cardChild: GestureDetector(
                        onTap: () {
                          setState(() {
                            vibe = !vibe;
                          });
                        },
                        child: Icon(
                            vibe
                                ? Icons.vibration
                                : Icons.phonelink_erase_sharp,
                            size: MediaQuery.of(context).size.height / 10),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
        Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 6,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  onPressed: () {
                    _saveData();
                    setState(() {
                      (widget._isSec) ? run.copy(init) : run.copy(mininit);
                    });
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Run(run,
                            (widget._isSec) ? init : mininit, widget._isSec)));
                  },
                  color: Colors.red[900],
                  child: Text(
                    'START',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height / 10,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class Var extends StatelessWidget {
  const Var({
    Key key,
    @required this.vari,
  }) : super(key: key);

  final String vari;

  @override
  Widget build(BuildContext context) {
    return Text(
      vari,
      style: TextStyle(fontSize: MediaQuery.of(context).size.height / 11),
    );
  }
}

class Card extends StatelessWidget {
  Card({this.color, this.cardChild});
  final Widget cardChild;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      child: cardChild,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

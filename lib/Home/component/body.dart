import 'package:flutter/material.dart';
import 'package:looploop/Run/run_screen.dart';
import 'package:looploop/constant.dart';
import 'package:looploop/time.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
                          init.works++;
                        });
                      }),
                      Var(vari: init.works.toString()),
                      // ignore: deprecated_member_use
                      RaisedButton(onPressed: () {
                        setState(() {
                          init.works--;
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
                          init.rests++;
                        });
                      }),
                      Var(vari: init.rests.toString()),
                      // ignore: deprecated_member_use
                      RaisedButton(onPressed: () {
                        setState(() {
                          init.rests--;
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
                      init.times++;
                    });
                  }),
                  Var(vari: init.times.toString()),
                  // ignore: deprecated_member_use
                  RaisedButton(onPressed: () {
                    setState(() {
                      init.times--;
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
                      run.copy(init);
                    });
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Run(init, run)));
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

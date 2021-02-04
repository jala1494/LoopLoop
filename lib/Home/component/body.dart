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
  @override
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
    });
  }

  _saveData() async {
    print('saveCounter');
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('work', init.works);
      prefs.setInt('rest', init.rests);
      prefs.setInt('times', init.times);
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
                    children: <Widget>[
                      Text('works'),
                      RaisedButton(onPressed: () {
                        setState(() {
                          init.works++;
                        });
                      }),
                      Text(init.works.toString()),
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
                    children: <Widget>[
                      Text('rests'),
                      RaisedButton(onPressed: () {
                        setState(() {
                          init.rests++;
                        });
                      }),
                      Text(init.rests.toString()),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('times'),
                  RaisedButton(onPressed: () {
                    setState(() {
                      init.times++;
                    });
                  }),
                  Text(init.times.toString()),
                  RaisedButton(onPressed: () {
                    setState(() {
                      init.times--;
                    });
                  }),
                ],
              ),
            )),
            Expanded(
              child: Card(
                color: kPrimaryColor,
                cardChild: Column(
                  children: [
                    RaisedButton(
                      onPressed: () {},
                    ),
                  ],
                ),
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
                      fontSize: MediaQuery.of(context).size.height / 8,
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

class Card extends StatelessWidget {
  Card({this.color, this.cardChild});
  final Widget cardChild;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: cardChild,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

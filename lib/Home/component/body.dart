import 'package:flutter/material.dart';
import 'package:looploop/constant.dart';
import 'start_button.dart';
import 'package:looploop/time.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Time init = new Time(45, 15, 4);

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Expanded(
          child: Row(children: <Widget>[
            Expanded(
                child: Card(
              cardChild: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(onPressed: () {
                    setState(() {
                      init.works++;
                      init.reset();
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
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
            )),
            Expanded(
                child: Card(
              color: kPrimaryColor,
              cardChild: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
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
            )),
          ],
        )),
        StartButton()
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

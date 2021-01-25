import 'package:flutter/material.dart';

class StartButton extends StatefulWidget {
  const StartButton({
    key,
  }) : super(key: key);

  @override
  _StartButtonState createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 6,
            child: RaisedButton(
              onPressed: () {},
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
    );
  }
}

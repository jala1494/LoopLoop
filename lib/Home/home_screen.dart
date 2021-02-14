import 'package:flutter/material.dart';
import 'package:looploop/time.dart';

import 'component/body.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  Time init = new Time(45, 15, 4);
  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.menu,
        ),
        onPressed: () {},
      ),
    );
  }
}

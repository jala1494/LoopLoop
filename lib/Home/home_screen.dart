import 'package:flutter/material.dart';

import 'component/body.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
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

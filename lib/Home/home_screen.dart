import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'component/body.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSec = false;
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isSec = (prefs.getBool('_isSec') ?? false);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(),
      body: Body(_isSec),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.compare_arrows_sharp,
        ),
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          setState(() {
            _isSec = !_isSec;
            prefs.setBool('_isSec', _isSec);
          });
        },
      ),
      title: (_isSec) ? Text('Sec') : Text('Min'),
      actions: [
        TextButton(
          child: Text('AD'),
          onPressed: () {},
        )
      ],
    );
  }
}

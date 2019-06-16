import 'package:flutter/material.dart';
import 'package:instagrao/screens/login/login.screen.dart';
import 'package:instagrao/widgets/view/view.widget.dart';

class PlayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return View(
      title: 'Scanbü',
      child: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}

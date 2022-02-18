import 'package:flutter/material.dart';
import 'package:shop_app_nojson/consts/constants.dart';

import 'components/body.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: const Body(),
    );
  }
}

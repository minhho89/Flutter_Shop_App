import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _keyForm,
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(
                label: Text('Title'),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                label: Text('Price'),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                label: Text('Decoration'),
              ),
            ),
          ],
        ));
  }
}

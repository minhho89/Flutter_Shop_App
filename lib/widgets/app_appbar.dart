import 'package:flutter/material.dart';
import 'package:shop_app_nojson/widgets/app_drawer.dart';

import '../consts/constants.dart';
import 'neumorphics/neumorphic_button.dart';

class CusTomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CusTomAppBar(
      {Key? key, this.actions, required this.context, this.titleText})
      : super(key: key);

  final List<Widget>? actions;
  final BuildContext context;
  final String? titleText;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: MediaQuery.of(context).size.height * 1 / 10,
      leadingWidth: 75,
      elevation: 0,
      backgroundColor: kBackgroundColor,
      title: titleText == null
          ? const Text('')
          : Text(
              titleText!,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
      leading: buildLeadingButton(context),
      actions: [...?actions],
    );
  }

  Theme buildDrawer(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: const AppDrawer(),
    );
  }

  Padding buildLeadingButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: NeumorphicButton(
        initialBlurRadius: 5,
        tappedBlurRadius: 3,
        borderRadius: BorderRadius.circular(8.0),
        onPressed: () {
          // _key.currentState?.openDrawer();
          Scaffold.of(context).openDrawer();
        },
        child: const Icon(
          Icons.menu,
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(MediaQuery.of(context).size.height * 1 / 10);
}

Theme buildDrawer(BuildContext context) {
  return Theme(
    data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
    child: const AppDrawer(),
  );
}

import 'package:flutter/material.dart';

class LoggedUserBar extends StatefulWidget with PreferredSizeWidget {
  const LoggedUserBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  _LoggedUserBarState createState() => _LoggedUserBarState();
}

class _LoggedUserBarState extends State<LoggedUserBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer()),
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.green),
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Middle Icon'),
        ],
      ),
      elevation: 20,
    );
  }
}

import 'package:flutter/material.dart';

class RegisterBar extends StatefulWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  _RegisterBarState createState() => _RegisterBarState();
}

class _RegisterBarState extends State<RegisterBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop()),
      ),
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.green),
      centerTitle: true,
      title: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Middle Icon'),
          ],
        ),
      ),
      elevation: 20,
    );
  }
}

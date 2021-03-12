import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: Drawer(
        child: Column(
          children: [
            AppBar(
              title: Text('Drawer Menu'),
              automaticallyImplyLeading: false,
            ),
            Text('first child'),
            Divider(),
            Text('second child'),
            Divider(),
            Text('third child'),
            Divider(),
          ],
        ),
      ),
    );
  }
}

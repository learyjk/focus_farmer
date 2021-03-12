import 'package:flutter/material.dart';
import 'package:focus_farmer/screens/timer_select_screen.dart';
import 'package:focus_farmer/screens/tree_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: Drawer(
        child: Column(
          children: [
            AppBar(
              title: Text(
                'Menu',
                style: Theme.of(context).textTheme.headline6,
              ),
              automaticallyImplyLeading: false,
            ),
            ListTile(
              leading: Icon(Icons.timer),
              title: Text(
                'Timer',
                style: Theme.of(context).textTheme.headline6,
              ),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(TimerSelectScreen.routeName),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.arrow_upward),
              title: Text(
                'Your Tree',
                style: Theme.of(context).textTheme.headline6,
              ),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(TreeScreen.routeName),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.timer),
              title: Text(
                'About',
                style: Theme.of(context).textTheme.headline6,
              ),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(TimerSelectScreen.routeName),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

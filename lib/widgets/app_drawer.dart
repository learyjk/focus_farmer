import 'package:flutter/material.dart';
import 'package:focus_farmer/screens/timer_select_screen.dart';
import 'package:focus_farmer/screens/tree_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              leading: SvgPicture.asset(
                'assets/images/fruits/apple.svg',
                semanticsLabel: 'Timer Apple',
                width: 30,
                height: 30,
              ),
              title: Text(
                'Timer',
                style: Theme.of(context).textTheme.headline6,
              ),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(TimerSelectScreen.routeName),
            ),
            Divider(),
            ListTile(
              leading: SvgPicture.asset(
                'assets/images/tree.svg',
                semanticsLabel: 'Productivity Tree',
                width: 30,
                height: 30,
              ),
              title: Text(
                'Your Tree',
                style: Theme.of(context).textTheme.headline6,
              ),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(TreeScreen.routeName),
            ),
            Divider(),
            ListTile(
              leading: SvgPicture.asset(
                'assets/images/fruits/banana.svg',
                semanticsLabel: 'About Banana',
                width: 30,
                height: 30,
              ),
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

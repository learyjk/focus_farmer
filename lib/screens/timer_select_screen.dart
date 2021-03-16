import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:focus_farmer/providers/fruit_stack.dart';
import 'package:focus_farmer/providers/stack_item.dart';
import 'package:focus_farmer/screens/tree_screen.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:focus_farmer/widgets/bottom_button.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:focus_farmer/widgets/app_drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:focus_farmer/widgets/carousel_item.dart';
import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';

enum TimerResult {
  Success,
  Failure,
}

class TimerSelectScreen extends StatefulWidget {
  static const String routeName = '/timer-select-screen';

  @override
  _TimerSelectScreenState createState() => _TimerSelectScreenState();
}

class _TimerSelectScreenState extends State<TimerSelectScreen> {
  bool _isCountingDown = false;
  int _durationInMinutes = 25;
  final List<String> _availableFruitList = ['apple', 'banana', 'orange'];
  int _indexItemToGrow = 0;

  CountDownController _controller = CountDownController();

  @override
  void initState() {
    super.initState();

    // initialize the database
    FruitStack.db.database;

    //last function to call
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.restart(duration: 3); //_durationInMinutes * 60);
      _controller.pause();
    });
  }

  void numberPickerChanged(selectedMins) {
    setState(() {
      _durationInMinutes = selectedMins;
      _controller.restart(duration: _durationInMinutes * 60);
      _controller.pause();
    });
  }

  void timerStarted() {
    if (!_isCountingDown) {
      //Start has been pressed
      _controller.start();
      setState(() {
        _isCountingDown = true;
      });
    } else {
      //Give Up has been pressed
      _controller.pause();
      setState(() {
        _isCountingDown = false;
      });
      _controller.restart(duration: _durationInMinutes * 60);
      _controller.pause();
      _showMyDialog(TimerResult.Failure);
    }
  }

  void timerCompleteSuccess() {
    setState(() {
      _isCountingDown = false;
    });
    final rand = Random();
    StackItem itemToAdd = StackItem(
      //id: 1,
      label: _availableFruitList[_indexItemToGrow],
      assetPath:
          'assets/images/fruits/${_availableFruitList[_indexItemToGrow]}.svg',
      unitRadius: rand.nextDouble(),
      unitAngle: rand.nextDouble(),
      dateTime: DateTime.now().toIso8601String(),
    );

    FruitStack.db.addStackItem(itemToAdd).then((_) {
      Navigator.of(context).pushReplacementNamed(TreeScreen.routeName);
      _showMyDialog(TimerResult.Success);
    });
  }

  Future<void> _showMyDialog(TimerResult result) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            result == TimerResult.Success
                ? 'Great Job!'
                : '💀 No Fruit For You!',
            style: Theme.of(context).textTheme.headline3,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  result == TimerResult.Success
                      ? 'Your Productivity Tree has a new ${_availableFruitList[_indexItemToGrow]} now!'
                      : 'You failed to grow the ${_availableFruitList[_indexItemToGrow]}.',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                  result == TimerResult.Success ? '😁 Awesome!' : '🥺 Bummer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: !_isCountingDown ? AppDrawer() : null,
      appBar: AppBar(
        title: Center(
          child: Text(
            'Productivity Tree',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: CircularCountDownTimer(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                duration: _durationInMinutes * 60,
                controller: _controller,
                fillColor: Colors.green,
                ringColor: Colors.grey[300],
                strokeWidth: 20,
                strokeCap: StrokeCap.round,
                textStyle: Theme.of(context).textTheme.headline3,
                isReverse: true,
                autoStart: false,
                onStart: () {},
                onComplete: () => timerCompleteSuccess(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0, bottom: 20),
              child: Text(
                !_isCountingDown ? 'What do you want to grow?' : ' ',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            !_isCountingDown
                ? CarouselSlider(
                    items: _availableFruitList
                        .map((fruit) => CarouselItem(fruit))
                        .toList(),
                    options: CarouselOptions(
                      height: 120,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _indexItemToGrow = index;
                        });
                      },
                    ),
                  )
                : SvgPicture.asset(
                    'assets/images/fruits/${_availableFruitList[_indexItemToGrow]}.svg',
                    semanticsLabel: '',
                    width: 120,
                    height: 120,
                  ),
            Padding(
              padding: EdgeInsets.only(top: 40, bottom: 10),
              child: Text(
                !_isCountingDown
                    ? 'How long do you want to focus for?'
                    : 'Get to work!',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              flex: 1,
              child: !_isCountingDown
                  ? NumberPicker(
                      minValue: 10,
                      maxValue: 120,
                      itemHeight: 50,
                      step: 5,
                      axis: Axis.horizontal,
                      haptics: true,
                      textStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 35,
                        color: Colors.grey[300],
                      ),
                      selectedTextStyle:
                          TextStyle(fontFamily: 'Inter', fontSize: 50),
                      value: _durationInMinutes,
                      onChanged: (mins) => numberPickerChanged(mins),
                    )
                  : SizedBox(
                      height: 50,
                    ),
            ),
            SizedBox(
              height: 20,
            ),
            BottomButton(
                title: !_isCountingDown ? 'Start' : 'Give Up',
                color: !_isCountingDown ? Colors.green : Colors.red,
                onTap: timerStarted),
          ],
        ),
      ),
    );
  }
}

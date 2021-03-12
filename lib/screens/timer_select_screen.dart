import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:focus_farmer/constants.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:focus_farmer/widgets/bottom_button.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:focus_farmer/widgets/app_drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:focus_farmer/widgets/carousel_item.dart';

class TimerSelectScreen extends StatefulWidget {
  static const String routeName = '/timer-select-screen';

  @override
  _TimerSelectScreenState createState() => _TimerSelectScreenState();
}

class _TimerSelectScreenState extends State<TimerSelectScreen> {
  bool _isCountingDown = false;
  int _durationInMinutes = 25;
  final List<String> _availableFruitList = ['🍎', '🍌', '🍊'];
  int indexItemToGrow = 0;

  CountDownController _controller = CountDownController();

  @override
  void initState() {
    super.initState();
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
      print('You gave up!');
      _controller.pause();
      setState(() {
        _isCountingDown = false;
      });
      _controller.restart(duration: _durationInMinutes * 60);
      _controller.pause();
    }
  }

  void timerComplete() {
    print('Timer Completed!');
  }

  void updateSelectedFruit(int i, CarouselPageChangedReason reason) {
    print('selection is: $i and reason is $reason');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Focus Farmer',
          style: Theme.of(context).textTheme.headline3,
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
                fillColor: Colors.lightGreen,
                ringColor: Colors.grey[300],
                strokeWidth: 20,
                strokeCap: StrokeCap.round,
                textStyle: Theme.of(context).textTheme.headline3,
                isReverse: true,
                autoStart: false,
                onStart: () {},
                onComplete: () => timerComplete(),
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                !_isCountingDown ? 'What do you want to grow?' : ' ',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            CarouselSlider(
                items: _availableFruitList
                    .map((fruit) => CarouselItem(fruit))
                    .toList(),
                options: CarouselOptions(
                    height: 140,
                    onPageChanged: (index, reason) {
                      updateSelectedFruit(index, reason);
                    })),
            FittedBox(
              fit: BoxFit.fitWidth,
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
                color: !_isCountingDown ? Colors.lightGreen : Colors.red,
                onTap: timerStarted),
          ],
        ),
      ),
    );
  }
}

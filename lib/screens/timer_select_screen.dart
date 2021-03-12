import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:focus_farmer/constants.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:focus_farmer/widgets/bottom_button.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:focus_farmer/widgets/app_drawer.dart';

class TimerSelectScreen extends StatefulWidget {
  @override
  _TimerSelectScreenState createState() => _TimerSelectScreenState();
}

class _TimerSelectScreenState extends State<TimerSelectScreen> {
  bool _isCountingDown = false;
  int _durationInMinutes = 25;
  CountDownController _controller = CountDownController();

  @override
  void initState() {
    super.initState();
    //last function to call
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.restart(duration: _durationInMinutes * 60);
      _controller.pause();
      print(_isCountingDown);
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
      _controller.restart(duration: _durationInMinutes);
      _controller.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Focus Farmer',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: kGreen,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: CircularCountDownTimer(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                duration: _durationInMinutes * 60,
                controller: _controller,
                fillColor: kGreen,
                ringColor: Colors.grey[300],
                strokeWidth: 20,
                strokeCap: StrokeCap.round,
                textStyle: TextStyle(fontFamily: 'Inter', fontSize: 45),
                isReverse: true,
                autoStart: false,
                onStart: () {},
              ),
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                !_isCountingDown
                    ? 'How many minutes do you want to focus for?'
                    : 'Get to work!',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                ),
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
            bottomButton(
                title: !_isCountingDown ? 'Start' : 'Give Up',
                color: !_isCountingDown ? kGreen : kRed,
                onTap: timerStarted),
          ],
        ),
      ),
    );
  }
}

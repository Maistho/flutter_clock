import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_clock_helper/model.dart';

import 'binary_background.dart';
import 'digital_clock.dart';
import 'theme.dart';
import 'time_provider.dart';

class BinaryClockApp extends StatelessWidget {
  const BinaryClockApp(this.model);

  final ClockModel model;

  @override
  Widget build(BuildContext context) {
    return ColorThemeProvider(
      theme: Theme.of(context).brightness == Brightness.light
          ? const ColorTheme(
              brightness: Brightness.light,
              background: Color(0xFFF4F4FF),
              text: Color(0xFF101030),
              primary: Color(0x4F1E88E5),
            )
          : const ColorTheme(
              brightness: Brightness.dark,
              background: Color(0xFF252535),
              text: Color(0xFFFFFFFF),
              primary: Color(0x5F1E88E5),
            ),
      child: BinaryClock(model),
    );
  }
}

class BinaryClock extends StatefulWidget {
  const BinaryClock(this.model);

  final ClockModel model;

  @override
  _BinaryClockState createState() => _BinaryClockState();
}

class _BinaryClockState extends State<BinaryClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;
  final bool showSeconds = true;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
  }

  @override
  void didUpdateWidget(BinaryClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Rebuild the clock whhen the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      if (showSeconds) {
        // Update once per second, but make sure to do it at the beginning of each
        // new second, so that the clock is accurate.
        _timer = Timer(
          const Duration(seconds: 1) -
              Duration(milliseconds: _dateTime.millisecond),
          _updateTime,
        );
      } else {
        // Update once per minute.
        _timer = Timer(
          const Duration(minutes: 1) -
              Duration(seconds: _dateTime.second) -
              Duration(milliseconds: _dateTime.millisecond),
          _updateTime,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ColorThemeProvider.of(context);

    return TimeProvider(
      dateTime: _dateTime,
      model: widget.model,
      child: DefaultTextStyle.merge(
        style: TextStyle(
          color: theme.text.withOpacity(0.9),
          fontFamily: 'SourceCodePro',
        ),
        child: Stack(
          children: [
            Positioned.fill(child: Container(color: theme.background)),
            Positioned.fill(
              child: BinaryBackground(),
            ),
            Positioned.fill(
              child: DigitalClock(
                showSeconds: showSeconds,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

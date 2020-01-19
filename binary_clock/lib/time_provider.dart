import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_clock_helper/model.dart';

class TimeProvider extends InheritedWidget {
  const TimeProvider({
    Key key,
    Widget child,
    @required this.dateTime,
    @required this.model,
  })  : assert(dateTime != null),
        assert(model != null),
        super(key: key, child: child);

  final DateTime dateTime;

  String get hours {
    return DateFormat(model.is24HourFormat ? 'HH' : 'hh').format(dateTime);
  }

  String get minutes {
    return DateFormat('mm').format(dateTime);
  }

  String get seconds {
    return DateFormat('ss').format(dateTime);
  }

  final ClockModel model;

  static TimeProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TimeProvider>();
  }

  @override
  bool updateShouldNotify(TimeProvider oldWidget) {
    return oldWidget.dateTime != dateTime;
  }
}

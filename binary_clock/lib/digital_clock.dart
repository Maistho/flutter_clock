import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'theme.dart';
import 'time_provider.dart';

class DigitalClock extends StatelessWidget {
  const DigitalClock({
    Key key,
    @required this.showSeconds,
  }) : super(key: key);

  final bool showSeconds;

  @override
  Widget build(BuildContext context) {
    final theme = ColorThemeProvider.of(context);
    final time = TimeProvider.of(context);

    const timeSeparator = Text(
      ':',
      style: TextStyle(
        // There is currently a bug with the spacing on the web platform, better to leave it empty
        letterSpacing: kIsWeb ? 0 : -10,
        fontWeight: FontWeight.w600,
      ),
    );

    return Semantics(
      excludeSemantics: true,
      // I sort of wanted to add a label like 'The time is half past ten' here,
      // but realised that I would just be making it more difficult for
      // international users. I *think* that screenreaders will be able to see
      // that this is a time and read it out properly, but I'm not quite sure
      // what the best approach is.
      label: time.dateTime.toIso8601String(),
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: FittedBox(
          alignment: Alignment.center,
          fit: BoxFit.contain,
          child: DefaultTextStyle.merge(
            style: TextStyle(
              fontSize: 128,
              fontWeight: FontWeight.w700,
              shadows: [
                if (theme.brightness == Brightness.dark)
                  const Shadow(
                    blurRadius: 0,
                    color: Color(0xCF000000),
                    offset: Offset(4, 8),
                  ),
                if (theme.brightness == Brightness.light)
                  const Shadow(
                    blurRadius: 10,
                    color: Color(0xAFFFFFFF),
                    offset: Offset(0, 0),
                  ),
              ],
            ),
            child: Row(
              children: [
                Text('${time.hours}'),
                timeSeparator,
                Text('${time.minutes}'),
                if (showSeconds) ...[
                  timeSeparator,
                  Text('${time.seconds}'),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

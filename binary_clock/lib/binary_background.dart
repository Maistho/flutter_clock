import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'theme.dart';
import 'time_provider.dart';

class BinaryBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TimeProvider time = TimeProvider.of(context);

    final double gapSize =
        (MediaQuery.of(context).size.shortestSide / 40).clamp(4, 24);

    final List<int> timeAsNumbers = [
      int.parse(time.hours[0]),
      int.parse(time.hours[1]),
      int.parse(time.minutes[0]),
      int.parse(time.minutes[1]),
      int.parse(time.seconds[0]),
      int.parse(time.seconds[1]),
    ];

    return ExcludeSemantics(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: gapSize,
          right: gapSize,
        ),
        child: Row(
          children: <Widget>[
            for (int n in timeAsNumbers)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: gapSize),
                  child: _BinaryBackgroundColumn(number: n, padding: gapSize),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _BinaryBackgroundColumn extends StatelessWidget {
  const _BinaryBackgroundColumn({
    Key key,
    @required this.number,
    @required this.padding,
  })  : assert(number != null),
        assert(padding != null),
        super(key: key);

  final int number;
  final double padding;

  @override
  Widget build(BuildContext context) {
    final List<String> binaryList =
        number.toRadixString(2).padLeft(4, '0').split('');

    return Stack(
      children: [
        Column(
          children: [
            for (String s in binaryList)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: padding),
                  child: _BinaryBackgroundTile(
                    visible: s == '1',
                    borderRadius: (padding / 2).clamp(2, 8),
                  ),
                ),
              ),
          ],
        ),
        if (!kReleaseMode)
          // Added a printout for each digit/column so that I can debug any issues easier
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Opacity(
                child: Text(binaryList.join()),
                opacity: 0.75,
              ),
            ),
          ),
      ],
    );
  }
}

class _BinaryBackgroundTile extends StatelessWidget {
  const _BinaryBackgroundTile({
    Key key,
    @required this.visible,
    @required this.borderRadius,
  })  : assert(visible != null),
        assert(borderRadius != null),
        super(key: key);

  final bool visible;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = ColorThemeProvider.of(context);

    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: MediaQuery.of(context).disableAnimations
          ? Duration.zero
          : const Duration(milliseconds: 250),
      curve: Curves.easeInOutQuad,
      child: Container(
        decoration: ShapeDecoration(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          color: theme.primary,
        ),
      ),
    );
  }
}

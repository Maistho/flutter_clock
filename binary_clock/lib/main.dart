// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_clock_helper/customizer.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'binary_clock.dart';

void main() {
  // This creates a clock that enables you to customize it.
  //
  // The [ClockCustomizer] takes in a [ClockBuilder] that consists of:
  //  - A clock widget (in this case, [DigitalClock])
  //  - A model (provided to you by [ClockModel])
  // For more information, see the flutter_clock_helper package.
  //
  // Your job is to edit [DigitalClock], or replace it with your
  // own clock widget. (Look in digital_clock.dart for more details!)
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    return ClockCustomizer((ClockModel model) => BinaryClockApp(model));
  }
}

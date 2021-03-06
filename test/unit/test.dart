/**
 * Copyright (c) 2015, Michael Mitterer (office@mikemitterer.at),
 * IT-Consulting and Development Limited.
 *
 * All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

@TestOn("content-shell")

library mdl.unit.test;

import 'package:test/test.dart';

//-----------------------------------------------------------------------------
// Logging

import 'package:logging/logging.dart';
//import 'package:console_log_handler/console_log_handler.dart';
import 'package:logging_handlers/logging_handlers_shared.dart';

import "package:mdl/mdlutils.dart";

part "utils/utils_test.dart";
part "utils/observables_test.dart";

/**
 * run the test with: pub run test -p content-shell test/unit/test.dart
 */
main() async {
    //final Logger _logger = new Logger('mdl.unit.test.main');

    configLogging();

    //testDataAttribute();
    testObservables();
}

void configLogging() {
    //hierarchicalLoggingEnabled = false; // set this to true - its part of Logging SDK

    // now control the logging.
    // Turn off all logging first
    Logger.root.level = Level.INFO;
    //Logger.root.onRecord.listen(new LogHandler());
    Logger.root.onRecord.listen(new LogPrintHandler());
}
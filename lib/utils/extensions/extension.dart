import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as screenutil;
import 'package:intl/intl.dart';
import 'package:the_entrapreneu/utils/log/error_log.dart';

extension View on num {
  Widget get height => SizedBox(height: toDouble().h);

  Widget get width => SizedBox(width: toDouble().w);
}

// All Alignments Extensions

extension Alignments on Widget {
  Widget get start => Align(alignment: Alignment.centerLeft, child: this);

  Widget get end => Align(alignment: Alignment.centerRight, child: this);

  Widget get center => Align(alignment: Alignment.center, child: this);
}

// All Alignments Time Formatter Extensions
extension TimeFormater on DateTime {
  String get time => DateFormat('h:mm a').format(this);

  String get date => DateFormat('dd-MM-yyyy').format(this);

  String get dayName => DateFormat('E').format(this);

  String get checkTime {
    DateTime currentDateTime = DateTime.now();

    Duration difference = currentDateTime.difference(this);
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return ("${difference.inMinutes} minutes ago");
      } else {
        return ("${difference.inHours} hours ago");
      }
    } else {
      var createdAtTime = toIso8601String().split(".")[0];
      var date = createdAtTime.split("T")[0];
      var time = createdAtTime.split("T")[1];
      return "$date at $time";
    }
  }
}

extension AsyncTryCatch on Function() {
  tryCatch() async {
    try {
      await this();
    } catch (e, stackTrace) {
      errorLog(stackTrace.toString(), source: "Global Try Catch");
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



//basically an extension for more responsive calculation across web and mobile.
extension WebCheck on num {
  double get rh {
    return kIsWeb ? this * 1 : cal_height(this);
  }

  double get rw {
    return kIsWeb ? this * 1 : cal_width(this);
  }

  double get rt {
    return kIsWeb ? this * 1 : cal_text(this);
  }
}

double cal_height(num height) => height.h;

double cal_width(num width) => width.w;

double cal_text(num txt) => txt.sp;
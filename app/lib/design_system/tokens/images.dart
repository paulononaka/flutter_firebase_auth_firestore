import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Images {
  Images._();

  static final mainTop = Image.asset("assets/images/main_top.png");
  static final mainBottom = Image.asset("assets/images/main_bottom.png");
  static final welcome = SvgPicture.asset("assets/icons/welcome.svg");
  static final signup = SvgPicture.asset("assets/icons/signup.svg");
  static final signin = SvgPicture.asset("assets/icons/login.svg");
  static final empty = SvgPicture.asset("assets/icons/empty.svg");
  static final illness = SvgPicture.asset("assets/icons/illness.svg");
  static final healthy = SvgPicture.asset("assets/icons/happy.svg");
  static final profile = SvgPicture.asset("assets/icons/profile.svg");
  static final error = SvgPicture.asset("assets/icons/error.svg");
}

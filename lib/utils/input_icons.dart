import 'package:flutter_svg/flutter_svg.dart';
import 'package:rush/utils/colors.dart';

class InputIcons {
  static const Icons_Path = "assets/icons/";

  static final userPrefix = SvgPicture.asset(
    Icons_Path + "userPrefix.svg",
    color: AppColors.Main_Orange,
  );
  static final emailPrefix = SvgPicture.asset(
    Icons_Path + "emailPrefix.svg",
    color: AppColors.Main_Orange,
  );
  static final emailSuffix = SvgPicture.asset(
    Icons_Path + "emailSuffix.svg",
    color: AppColors.Main_Orange,
  );
  static final passwordPrefix = SvgPicture.asset(
    Icons_Path + "passwordPrefix.svg",
    color: AppColors.Main_Orange,
  );
  static final passwordSuffix = SvgPicture.asset(
    Icons_Path + "passwordSuffix.svg",
    color: AppColors.Main_Orange,
  );
  static final doneIcon = SvgPicture.asset(
    Icons_Path + "doneIcon.svg",
    color: AppColors.Main_Orange,
  );
}

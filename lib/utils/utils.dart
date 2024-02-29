import 'package:firebase_practice_code/constants/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: AppColors.defaultColor,
        textColor: AppColors.secondaryColor,
        fontSize: 16.0);
  }
}

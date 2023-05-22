import 'package:fluttertoast/fluttertoast.dart';
import '../colors.dart';

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: primary,
    textColor: tertiary,
    fontSize: 16.0,
  );
}

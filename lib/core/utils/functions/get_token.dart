import 'package:sharecars/core/service/hive_services.dart';
import 'package:sharecars/features/auth/data/model/user_model.dart';

String? mytoken() {
  UserModel? user = HiveBoxes.authBox.get(HiveKeys.user);
  final String? token ='15|pJNgoKe25RZ4rBWy7LwGBJsp0kXFd9FWMlSzNghda508ce8e';
  //  user?.token;
  return token;
}
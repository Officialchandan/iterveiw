import 'package:dio/dio.dart';
import 'package:interview/login_page/model/user_model.dart';

class Apiclass {
  static Future<Map<String, dynamic>> getUser() async {
    String url = "https://myjson.dit.upm.es/api/bins/gbt5";

    Dio _dio = Dio();
    try {
      Future<Response> response = (await _dio.get(url)) as Future<Response>;

      if (response == 200) {
        User userResponse = User.fromJson(response.toString());
        Map<String, dynamic> userList =
            userResponse.data as Map<String, dynamic>;
        return userList;
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }
}

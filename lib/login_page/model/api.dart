import 'package:interview/login_page/model/model.dart';
import 'package:interview/login_page/model/user_model.dart';

import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio = Dio();

  final _baseUrl = 'https://reqres.in/api';
  final _baseUrl1 = 'https://myjson.dit.upm.es/api/bins/gbt5';

  // Future<User?> getUser({required String id}) async {
  //   User? user;
  //   try {
  //     Response userData = await _dio.get(_baseUrl + '/users/$id');
  //     print('User Info: ${userData.data}');
  //     user = User.fromJson(userData.data);
  //   } on DioError catch (e) {
  //     if (e.response != null) {
  //       print('Dio error!');
  //       print('STATUS: ${e.response?.statusCode}');
  //       print('DATA: ${e.response?.data}');
  //       print('HEADERS: ${e.response?.headers}');
  //     } else {
  //       print('Error sending request!');
  //       print(e.message);
  //     }
  //   }
  //   return user;
  // }

  Future<DataFormUser?> dataUser(String dataFormUser) async {
    DataFormUser? dataForm;
    try {
      Response userData = await _dio.get(_baseUrl1);
      print('User Info: ${userData.data}');
      dataForm = DataFormUser.fromJson(userData.data);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
      }
    }
    return dataForm;
  }
}

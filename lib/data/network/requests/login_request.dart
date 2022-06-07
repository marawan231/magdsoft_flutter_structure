import 'package:dio/dio.dart';
import 'package:magdsoft_flutter_structure/data/remote/dio_helper.dart';

class LoginWebServices {
  Future<Map<String, dynamic>> getUserInfo(
      String username, String password) async {
    try {
      Response response = await DioHelper.postData(url: 'login', body: {
        'email': username,
        'password': password,
      });
      return response.data;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return {};
    }
  }
}

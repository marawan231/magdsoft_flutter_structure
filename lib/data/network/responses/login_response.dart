import '../../models/login_model.dart';
import '../requests/login_request.dart';

class LoginRepoistry {
  final LoginWebServices loginWebServices;

  LoginRepoistry(this.loginWebServices);

  Future<LoginModel> getUserInfo(String username, String password) async {
    final user = await loginWebServices.getUserInfo(username, password);
    return LoginModel.fromJson(user);
  }
}

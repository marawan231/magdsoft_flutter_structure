import '../../models/register_model.dart';
import '../requests/register_request.dart';

class RegisterRepoistry {
  final RegisterWebServices registerWebServices;

  RegisterRepoistry(this.registerWebServices);

  Future<RegisterModel> userRegister(username, email, password, phone) async {
    final user = await registerWebServices.userRegister(
        username, email, password, phone);
    return RegisterModel.fromJson(user);
  }
}

part of 'global_cubit.dart';

@immutable
abstract class GlobalState {}

class GlobalInitial extends GlobalState {}

class LoginSuccedded extends GlobalState {
  final LoginModel userInfo;

  LoginSuccedded(this.userInfo);
}

class LoginLoding extends GlobalState {}

class LoginErorr extends GlobalState {
  final String errorText;

  LoginErorr(this.errorText);
}

class LoginChangePasswordVisibiltyState extends GlobalState {}

class RegisterSuccedded extends GlobalState {
  final RegisterModel userInfo;

  RegisterSuccedded(this.userInfo);
}

class RegisterLoding extends GlobalState {}

class RegisterErorr extends GlobalState {
  final String errorText;

  RegisterErorr(this.errorText);
}

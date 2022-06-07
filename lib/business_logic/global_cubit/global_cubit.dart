import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/login_model.dart';
import '../../data/models/register_model.dart';
import '../../data/network/responses/login_response.dart';
import '../../data/network/responses/register_response.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit(this.loginRepoistry, this.registerRepoistry)
      : super(GlobalInitial());

  final LoginRepoistry loginRepoistry;
  final RegisterRepoistry registerRepoistry;
  Icon suffixIcon = const Icon(Icons.visibility);
  Icon confirmPassowrdSuffixIcon = const Icon(Icons.visibility);
  bool isPassowrdShown = true;
  bool isConfirmPassowrdShown = true;

  void getUserInfo({required String username, required String password}) {
    emit(LoginLoding());
    loginRepoistry.getUserInfo(username, password).then((userInfo) {
      if (userInfo.status == 200) {
        emit(LoginSuccedded(userInfo));
      } else {
        emit(LoginErorr('error try again'));
      }
    }).catchError((e) {
      emit(LoginErorr(e));
    });
  }

  void postNewAccount({
    required String username,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoding());
    registerRepoistry
        .userRegister(username, email, password, phone)
        .then((userInfo) {
      if (userInfo.status == 200) {
        emit(RegisterSuccedded(userInfo));
      } else {
        emit(RegisterErorr('error'));
      }
    }).catchError((e) {
      emit(RegisterErorr(e));
    });
  }

  void tooglePasswordVisibilty() {
    isPassowrdShown = !isPassowrdShown;
    suffixIcon = isPassowrdShown
        ? const Icon(Icons.visibility)
        : const Icon(Icons.visibility_off_outlined);
    emit(LoginChangePasswordVisibiltyState());
  }

  void toogleConfirmPasswordVisibilty() {
    isConfirmPassowrdShown = !isConfirmPassowrdShown;
    confirmPassowrdSuffixIcon = isConfirmPassowrdShown
        ? const Icon(Icons.visibility)
        : const Icon(Icons.visibility_off_outlined);
    emit(LoginChangePasswordVisibiltyState());
  }
}

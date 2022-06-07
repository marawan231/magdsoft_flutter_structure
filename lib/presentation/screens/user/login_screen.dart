// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/global_cubit/global_cubit.dart';
import 'package:magdsoft_flutter_structure/constants/strings.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';

import 'package:magdsoft_flutter_structure/presentation/widget/text_field_container.dart';

import '../../widget/custom_button.dart';
import '../../widget/loading_indicator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) {
        if (state is LoginSuccedded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('login successful'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushNamed(context, userProfile, arguments: {
            'userInfo': state.userInfo,
            'currentEmail': emailController.text,
          });
        }
        if (state is LoginErorr) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email or Password is not true'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColor.blue,
            body: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: AppColor.blue,
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/appLogo.png',
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0, top: 25.0),
                        child: Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            padding: const EdgeInsets.only(left: 17, right: 17),
                            child: const Text(
                              'عربى',
                              style:
                                  TextStyle(fontSize: 15, color: AppColor.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Form(
                        key: loginFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                DefaultContainer(
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    textAlign: TextAlign.left,
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Email',
                                      alignLabelWithHint: false,
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          !value.contains('@')) {
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                DefaultContainer(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Password',
                                      suffixIcon: IconButton(
                                        icon: BlocProvider.of<GlobalCubit>(
                                                context)
                                            .suffixIcon,
                                        onPressed: () {
                                          BlocProvider.of<GlobalCubit>(context)
                                              .tooglePasswordVisibilty();
                                        },
                                      ),
                                    ),
                                    obscureText:
                                        BlocProvider.of<GlobalCubit>(context)
                                            .isPassowrdShown,
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.length < 6) {
                                        return 'Please enter a validate password';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomButton(
                                    text: 'Register',
                                    onPress: () {
                                      Navigator.pushNamed(
                                          context, registerScreen);
                                    }),
                                state is LoginLoding
                                    ? const LoadingIndicator()
                                    : CustomButton(
                                        text: 'Login',
                                        onPress: () {
                                          if (loginFormKey.currentState!
                                              .validate()) {
                                            BlocProvider.of<GlobalCubit>(
                                                    context)
                                                .getUserInfo(
                                              username: emailController.text,
                                              password: passwordController.text,
                                            );
                                          }
                                        },
                                      ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

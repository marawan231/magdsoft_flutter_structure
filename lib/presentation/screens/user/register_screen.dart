// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/global_cubit/global_cubit.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/custom_button.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/loading_indicator.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/text_field_container.dart';

import '../../styles/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) {
        if (state is RegisterSuccedded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Register Succeeded'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacementNamed(context, '/');
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColor.blue,
          body: Column(
            children: [
              Expanded(
                child: Container(
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
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      height: size.height * 0.66,
                      decoration: const BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Form(
                          key: registerFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  DefaultContainer(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter  name please';
                                        }
                                        return null;
                                      },
                                      controller: userNameController,
                                      textAlign: TextAlign.left,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Your Name',
                                      ),
                                    ),
                                  ),
                                  DefaultContainer(
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            !value.contains('@')) {
                                          return 'Enter a valid Email';
                                        }
                                        return null;
                                      },
                                      controller: emailController,
                                      textAlign: TextAlign.left,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Email',
                                      ),
                                    ),
                                  ),
                                  DefaultContainer(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            value.length < 11) {
                                          return 'Phone number should be more than 10 numbers';
                                        }
                                        return null;
                                      },
                                      controller: phoneController,
                                      textAlign: TextAlign.left,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'phone',
                                      ),
                                    ),
                                  ),
                                  DefaultContainer(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            value.length < 6) {
                                          return 'Enter good password more than 5 characters';
                                        }
                                        return null;
                                      },
                                      controller: passwordController,
                                      obscureText:
                                          BlocProvider.of<GlobalCubit>(context)
                                              .isPassowrdShown,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Password',
                                        suffixIcon: IconButton(
                                          icon: BlocProvider.of<GlobalCubit>(
                                                  context)
                                              .suffixIcon,
                                          onPressed: () {
                                            BlocProvider.of<GlobalCubit>(
                                                    context)
                                                .tooglePasswordVisibilty();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  DefaultContainer(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            value != passwordController.text) {
                                          return 'Enter The Correct Password';
                                        }
                                        return null;
                                      },
                                      controller: confirmPasswordController,
                                      obscureText:
                                          BlocProvider.of<GlobalCubit>(context)
                                              .isConfirmPassowrdShown,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Confirm Password',
                                        suffixIcon: IconButton(
                                          icon: BlocProvider.of<GlobalCubit>(
                                                  context)
                                              .confirmPassowrdSuffixIcon,
                                          onPressed: () {
                                            BlocProvider.of<GlobalCubit>(
                                                    context)
                                                .toogleConfirmPasswordVisibilty();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  state is RegisterLoding
                                      ? const LoadingIndicator()
                                      : CustomButton(
                                          text: 'Register',
                                          onPress: () {
                                            if (registerFormKey.currentState!
                                                .validate()) {
                                              BlocProvider.of<GlobalCubit>(
                                                      context)
                                                  .postNewAccount(
                                                username:
                                                    userNameController.text,
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                                phone: phoneController.text,
                                              );
                                            }
                                          },
                                        ),
                                  CustomButton(
                                    text: 'Login',
                                    onPress: () {
                                      Navigator.pushReplacementNamed(
                                          context, '/');
                                    },
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

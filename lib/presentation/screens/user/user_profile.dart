import 'package:flutter/material.dart';
import 'package:magdsoft_flutter_structure/data/models/login_model.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/custom_button.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key, required this.accountInfo}) : super(key: key);
  final Account accountInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.blue,
        title: const Text('User Data'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  ('Name : ${accountInfo.name} '),
                  style: const TextStyle(
                    color: AppColor.blue,
                    fontSize: 25,
                  ),
                ),
                Text(
                  ('Email : ${accountInfo.email} '),
                  style: const TextStyle(
                    color: AppColor.blue,
                    fontSize: 25,
                  ),
                ),
                Text(
                  ('Phone : ${accountInfo.phone}'),
                  style: const TextStyle(
                    color: AppColor.blue,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            CustomButton(
              color: AppColor.red,
              text: 'Logout',
              onPress: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
    );
  }
}

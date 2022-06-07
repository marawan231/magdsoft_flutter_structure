import 'package:flutter/material.dart';
import 'package:magdsoft_flutter_structure/presentation/styles/colors.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPress;
  final Color color;

  const CustomButton({
    Key? key,
    this.text,
    this.onPress,
    this.color = AppColor.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.07,
      width: size.width * 0.4,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: MaterialButton(
        onPressed: onPress,
        elevation: 0,
        child: Text(
          text!,
          style: const TextStyle(color: AppColor.white, fontSize: 20),
        ),
      ),
    );
  }
}

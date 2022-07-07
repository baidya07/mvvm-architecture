import 'package:flutter/material.dart';
import 'package:mvvm_architecture/resources/colors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;

  const RoundButton(
      {required this.title,
      this.loading = false,
      required this.onPress,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
            child: loading ? const CircularProgressIndicator(color: Colors.white,) : Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Colors.white),
        )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:spacer/core/UI/Screens/CustomWidget/button_widget.dart';
import 'package:spacer/core/UI/Screens/HomeScreen/home_screen.dart';
import 'package:spacer/core/thems/app_colors.dart';
import 'package:spacer/core/thems/app_strings.dart';
import 'package:spacer/core/thems/assets/app_images.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "LoginScreen";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Image(
            image: AssetImage(AppImages.loginBackground),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: FittedBox(
                        child: Text(
                          AppString.loginText,
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ],
            ),
          ),
          ButtonWidget(
            textOfButton: AppString.exportText,
            onClick: () =>
                Navigator.pushReplacementNamed(context, HomeScreen.routeName),
          ),
        ],
      ),
    );
  }
}

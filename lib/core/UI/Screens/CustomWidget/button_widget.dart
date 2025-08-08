import 'package:flutter/material.dart';

import '../../../thems/app_colors.dart';
import '../../../thems/app_strings.dart';

class ButtonWidget extends StatelessWidget {
  final String textOfButton;
  final VoidCallback onClick;

  const ButtonWidget({
    super.key,
    required this.textOfButton,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(left: 16,bottom: 22,right: 16,top: 0),
        child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.red,
            foregroundColor: AppColors.white,
            padding:const  EdgeInsets.fromLTRB(26, 18, 26, 18),
          ),
          onPressed: onClick,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                textOfButton,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
             const  Icon(Icons.arrow_forward, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}

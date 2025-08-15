import 'package:flutter/material.dart';
import '../utils/constants.dart';

class LevelButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const LevelButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppConstants.buttonSize,
        height: AppConstants.buttonSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
          color: AppConstants.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: AppConstants.levelButtonFontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

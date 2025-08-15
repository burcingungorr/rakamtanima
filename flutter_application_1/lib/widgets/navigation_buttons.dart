import 'package:flutter/material.dart';
import '../utils/constants.dart';

class NavigationButtons extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onDone;
  final VoidCallback? onClear;
  final bool showDone;

  const NavigationButtons({
    Key? key,
    this.onBack,
    this.onDone,
    this.onClear,
    this.showDone = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (onBack != null)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.primaryColor,
              ),
              onPressed: onBack,
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          if (showDone && onDone != null)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.primaryColor,
              ),
              onPressed: onDone,
              child: const Icon(Icons.done, color: Colors.white),
            ),
          if (onClear != null)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.primaryColor,
              ),
              onPressed: onClear,
              child: const Icon(Icons.clear, color: Colors.white),
            ),
        ],
      ),
    );
  }
}

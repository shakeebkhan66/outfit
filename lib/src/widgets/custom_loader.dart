import 'package:flutter/material.dart';
import 'package:outfit/src/base/theme.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
      color: AppColors.primaryColor,
    )
   );
  }
}
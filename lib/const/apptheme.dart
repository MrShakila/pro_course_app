import 'package:flutter/material.dart';

import 'app_colors.dart';

final appTheme = ThemeData(
  primaryColor: AppColors.spaceCadet,
  scaffoldBackgroundColor: Colors.grey[300],
  appBarTheme: const AppBarTheme(backgroundColor: AppColors.spaceCadet),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.burgundy),
);

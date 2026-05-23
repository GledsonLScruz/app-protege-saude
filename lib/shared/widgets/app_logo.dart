import 'package:flutter/material.dart';

import '../constants/app_assets.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.height = 36});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      child: Image.asset(
        AppAssets.rasterLogo,
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}

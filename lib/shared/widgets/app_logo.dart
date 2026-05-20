import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_assets.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.height = 36});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssets.logoSvg,
      height: height,
      fit: BoxFit.contain,
      placeholderBuilder: (_) => Image.asset(
        AppAssets.rasterLogo,
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}

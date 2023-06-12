import 'package:flutter/material.dart';
import 'package:projectndc/app_components/colour.dart';
import 'dart:ui';
import 'package:projectndc/app_components/device_configuration.dart';

class FrostedGlass extends StatelessWidget {
  const FrostedGlass({Key? key,
    required this.glassWidth,
    required this.glassHeight,

    // required this.topmargin,
    // required this.bottommargin,
    // required this.sidemargin,
    required this.glassRadius,
    required this.glassChild,
  }) : super(key: key);

  final glassWidth;
  final glassHeight;
  // final topmargin;
  // final bottommargin;
  // final sidemargin;
  final glassRadius;
  final glassChild;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        height: glassHeight,
        width: glassWidth,
        // margin: EdgeInsets.only(top: topmargin, right: sidemargin, bottom: bottommargin, left: sidemargin),
        color: Colors.transparent,

        child: Stack(
          // 1.blur effect (bottom)
          // 2.gradient effect (middle)
          // 3.child (top)

          children: [
            //BLUR
            BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 7.0,
                  sigmaY: 7.0,
                ),
              child: Container(),
            ),

            //GRADIENT
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(glassRadius),
                border: Border.all(color: Colour.BACKGROUND_COLOR.withOpacity(0.2)),
                gradient: LinearGradient(
                    begin: Alignment. topLeft,
                    end: Alignment. bottomRight,
                    colors: [
                      Colour.BACKGROUND_COLOR.withOpacity(0.15),
                      Colour.BACKGROUND_COLOR.withOpacity(0.05)
                    ]
                ),
              ),
            ),

            //CHILD
            Container(child: glassChild,)
          ],
        ),
      ),
    );
  }
}

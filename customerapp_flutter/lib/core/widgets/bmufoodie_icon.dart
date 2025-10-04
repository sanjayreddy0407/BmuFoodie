import 'package:flutter/material.dart';

class BmuFoodieIcon extends StatelessWidget {
  final double size;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const BmuFoodieIcon({
    super.key,
    this.size = 512,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? const Color(0xFFFFD700);
    final fgColor = foregroundColor ?? Colors.white;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            bgColor,
            bgColor.withOpacity(0.8),
            const Color(0xFFFF6B35),
          ],
          stops: const [0.0, 0.6, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: bgColor.withOpacity(0.4),
            blurRadius: size * 0.05,
            offset: Offset(0, size * 0.02),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background highlight
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size * 0.22),
                gradient: RadialGradient(
                  center: const Alignment(-0.4, -0.4),
                  radius: 1.0,
                  colors: [
                    Colors.white.withOpacity(0.25),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          
          // BMU Letter Background
          Positioned(
            top: size * 0.15,
            left: size * 0.15,
            child: Text(
              'B',
              style: TextStyle(
                fontSize: size * 0.2,
                fontWeight: FontWeight.w900,
                color: fgColor.withOpacity(0.3),
                fontFamily: 'Poppins',
              ),
            ),
          ),
          
          // Main restaurant icon
          Icon(
            Icons.restaurant,
            size: size * 0.35,
            color: fgColor,
          ),
          
          // Decorative dots
          Positioned(
            top: size * 0.2,
            right: size * 0.18,
            child: Container(
              width: size * 0.08,
              height: size * 0.08,
              decoration: BoxDecoration(
                color: fgColor.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
            ),
          ),
          
          Positioned(
            bottom: size * 0.25,
            left: size * 0.22,
            child: Container(
              width: size * 0.06,
              height: size * 0.06,
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B35).withOpacity(0.8),
                shape: BoxShape.circle,
              ),
            ),
          ),
          
          // Additional small elements
          Positioned(
            top: size * 0.35,
            right: size * 0.25,
            child: Container(
              width: size * 0.04,
              height: size * 0.04,
              decoration: BoxDecoration(
                color: fgColor.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
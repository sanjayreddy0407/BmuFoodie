import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

// This is a utility to create app icon PNG files
class AppIconCreator {
  static Future<void> createAppIcon() async {
    // Create a custom painter for the app icon
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    const size = 512.0;
    
    // Background gradient
    final backgroundPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFFFD700), // BMU Yellow
          Color(0xFFFFBF00), // Darker yellow
          Color(0xFFFF6B35), // Orange
        ],
        stops: [0.0, 0.6, 1.0],
      ).createShader(const Rect.fromLTWH(0, 0, size, size));
    
    // Draw background with rounded corners
    final backgroundRect = RRect.fromRectAndRadius(
      const Rect.fromLTWH(0, 0, size, size),
      const Radius.circular(size * 0.22),
    );
    canvas.drawRRect(backgroundRect, backgroundPaint);
    
    // Highlight overlay
    final highlightPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.4, -0.4),
        radius: 1.0,
        colors: [
          Colors.white.withOpacity(0.25),
          Colors.transparent,
        ],
      ).createShader(const Rect.fromLTWH(0, 0, size, size));
    canvas.drawRRect(backgroundRect, highlightPaint);
    
    // BMU Letter in background
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'B',
        style: TextStyle(
          fontSize: size * 0.25,
          fontWeight: FontWeight.w900,
          color: Colors.white.withOpacity(0.3),
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(size * 0.15, size * 0.15));
    
    // Main restaurant icon (simplified)
    final iconPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    
    // Fork (left side)
    final forkPath = Path();
    const forkX = size * 0.4;
    const forkY = size * 0.35;
    const forkWidth = size * 0.08;
    const forkHeight = size * 0.3;
    
    // Fork handle
    forkPath.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(forkX - forkWidth/2, forkY, forkWidth, forkHeight),
      const Radius.circular(4),
    ));
    
    // Fork tines
    for (int i = 0; i < 4; i++) {
      final tineX = forkX - forkWidth/2 + (i * forkWidth/3.5);
      forkPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(tineX - 2, forkY - size * 0.08, 4, size * 0.08),
        const Radius.circular(2),
      ));
    }
    
    canvas.drawPath(forkPath, iconPaint);
    
    // Spoon (right side)
    const spoonX = size * 0.6;
    const spoonY = size * 0.35;
    const spoonWidth = forkWidth;
    const spoonHeight = forkHeight;
    
    // Spoon handle
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(spoonX - spoonWidth/2, spoonY + size * 0.05, spoonWidth, spoonHeight - size * 0.05),
        const Radius.circular(4),
      ),
      iconPaint,
    );
    
    // Spoon bowl
    canvas.drawOval(
      Rect.fromLTWH(spoonX - size * 0.06, spoonY - size * 0.08, size * 0.12, size * 0.13),
      iconPaint,
    );
    
    // Decorative dots
    canvas.drawCircle(Offset(size * 0.8, size * 0.3), size * 0.04, iconPaint..color = Colors.white.withOpacity(0.8));
    canvas.drawCircle(Offset(size * 0.25, size * 0.75), size * 0.03, iconPaint..color = const Color(0xFFFF6B35).withOpacity(0.9));
    canvas.drawCircle(Offset(size * 0.75, size * 0.65), size * 0.025, iconPaint..color = Colors.white.withOpacity(0.6));
    
    // Convert to image
    final picture = recorder.endRecording();
    final image = await picture.toImage(size.toInt(), size.toInt());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    
    if (byteData != null) {
      print('App icon created successfully!');
      // In a real app, you would save this to file
      // File('assets/icons/app_icon.png').writeAsBytesSync(byteData.buffer.asUint8List());
    }
    
    picture.dispose();
    image.dispose();
  }
}
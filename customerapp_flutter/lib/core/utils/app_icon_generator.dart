import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import '../widgets/bmufoodie_icon.dart';

class AppIconGenerator extends StatefulWidget {
  const AppIconGenerator({super.key});

  @override
  State<AppIconGenerator> createState() => _AppIconGeneratorState();
}

class _AppIconGeneratorState extends State<AppIconGenerator> {
  final GlobalKey _iconKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Icon Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Preview of the icon
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: RepaintBoundary(
                key: _iconKey,
                child: const BmuFoodieIcon(
                  size: 200,
                  backgroundColor: Color(0xFFFFD700),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _generateIcon,
              child: const Text('Generate App Icon'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Instructions:\n'
              '1. Tap "Generate App Icon" to create the icon\n'
              '2. Use online tools to create proper app icons\n'
              '3. Or use flutter_launcher_icons package',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _generateIcon() async {
    try {
      RenderRepaintBoundary boundary = _iconKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      
      if (byteData != null) {
        // In a real implementation, you would save this to files
        // For now, we'll just show a success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Icon generated! Use flutter_launcher_icons to apply.'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error generating icon: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
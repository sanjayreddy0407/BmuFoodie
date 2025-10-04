import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BmuFoodieLogo extends StatefulWidget {
  final double size;
  final bool showText;
  final Color? primaryColor;
  final Color? secondaryColor;

  const BmuFoodieLogo({
    super.key,
    this.size = 80,
    this.showText = true,
    this.primaryColor,
    this.secondaryColor,
  });

  @override
  State<BmuFoodieLogo> createState() => _BmuFoodieLogoState();
}

class _BmuFoodieLogoState extends State<BmuFoodieLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: -0.1,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.primaryColor ?? Theme.of(context).primaryColor;
    final secondaryColor = widget.secondaryColor ?? const Color(0xFFFF6B35);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo Icon
                Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.size * 0.25),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        primaryColor,
                        primaryColor.withOpacity(0.8),
                        secondaryColor,
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.3),
                        blurRadius: widget.size * 0.15,
                        offset: Offset(0, widget.size * 0.1),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background Pattern
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(widget.size * 0.25),
                            gradient: RadialGradient(
                              center: const Alignment(-0.3, -0.3),
                              radius: 1.2,
                              colors: [
                                Colors.white.withOpacity(0.2),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      // BMU Letter in Background
                      Positioned(
                        top: widget.size * 0.15,
                        left: widget.size * 0.15,
                        child: Text(
                          'B',
                          style: GoogleFonts.poppins(
                            fontSize: widget.size * 0.25,
                            fontWeight: FontWeight.w900,
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                      
                      // Main Food Icon (Fork and Spoon)
                      Icon(
                        Icons.restaurant,
                        size: widget.size * 0.4,
                        color: Colors.white,
                      ),
                      
                      // Small Food Elements
                      Positioned(
                        top: widget.size * 0.2,
                        right: widget.size * 0.2,
                        child: Container(
                          width: widget.size * 0.12,
                          height: widget.size * 0.12,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: widget.size * 0.25,
                        left: widget.size * 0.25,
                        child: Container(
                          width: widget.size * 0.08,
                          height: widget.size * 0.08,
                          decoration: BoxDecoration(
                            color: secondaryColor.withOpacity(0.9),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // App Name Text
                if (widget.showText) ...[
                  const SizedBox(height: 12),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Bmu',
                          style: GoogleFonts.poppins(
                            fontSize: widget.size * 0.25,
                            fontWeight: FontWeight.w700,
                            color: primaryColor,
                            letterSpacing: -0.5,
                          ),
                        ),
                        TextSpan(
                          text: 'Foodie',
                          style: GoogleFonts.poppins(
                            fontSize: widget.size * 0.25,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).textTheme.titleLarge?.color ?? Colors.black87,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Smart Campus Dining',
                    style: GoogleFonts.poppins(
                      fontSize: widget.size * 0.1,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7) ?? Colors.grey.shade600,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class BmuFoodieLogoIcon extends StatelessWidget {
  final double size;
  final Color? color;

  const BmuFoodieLogoIcon({
    super.key,
    this.size = 32,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return BmuFoodieLogo(
      size: size,
      showText: false,
      primaryColor: color,
    );
  }
}
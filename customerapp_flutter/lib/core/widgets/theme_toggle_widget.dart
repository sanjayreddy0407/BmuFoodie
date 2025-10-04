import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_manager.dart';

class ThemeToggleWidget extends StatelessWidget {
  const ThemeToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) {
        return Container(
          margin: const EdgeInsets.only(left: 16, top: 8),
          child: Material(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(25),
            elevation: 2,
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () => themeManager.toggleTheme(),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return RotationTransition(
                      turns: animation,
                      child: ScaleTransition(
                        scale: animation,
                        child: child,
                      ),
                    );
                  },
                  child: Icon(
                    themeManager.isDarkMode 
                        ? Icons.light_mode_outlined 
                        : Icons.dark_mode_outlined,
                    key: ValueKey(themeManager.isDarkMode),
                    color: Theme.of(context).primaryColor,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
import 'package:calculator/theme/theme_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomSwitch extends StatelessWidget {
  
  const CustomSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final value = context.watch<ThemeViewModel>().isDark;
    return GestureDetector(
      onTap: () {
        context.read<ThemeViewModel>().toggleTheme();
      },
      child: Container(
        width: 72,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: !value ? const Color(0xFFFFFFFF) : const Color(0xFF2E2F38),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Image.asset('assets/sun.png',
                      color: !value ? const Color(0xFF4B5EFC) : Colors.transparent),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.asset('assets/moon.png',
                      color: !value ? Colors.transparent : const Color(0xFF4B5EFC)),
                ),
              ],
            ),
            AnimatedAlign(
              alignment: !value ? Alignment.centerRight : Alignment.centerLeft,
              duration: const Duration(milliseconds: 200),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  margin: const EdgeInsets.all(2),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: !value ? const Color(0xFFD2D3DA) : const Color(0xFF4E505F),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class WizardProgress extends StatelessWidget {
  const WizardProgress({
    super.key,
    required this.titles,
    required this.currentIndex,
    required this.isValid,
    required this.isAccessible,
    required this.onTap,
    required this.color,
  });

  final List<String> titles;
  final int currentIndex;
  final bool Function(int index) isValid;
  final bool Function(int index) isAccessible;
  final ValueChanged<int> onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          LinearProgressIndicator(
            value: titles.isEmpty ? 0 : (currentIndex + 1) / titles.length,
            minHeight: 4,
            color: color,
            backgroundColor: const Color(0xFFE1EAE6),
          ),
          SizedBox(
            height: 68,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              itemCount: titles.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final active = index == currentIndex;
                final valid = isValid(index);
                final accessible = isAccessible(index);
                return ActionChip(
                  onPressed: accessible ? () => onTap(index) : null,
                  avatar: Icon(
                    valid
                        ? Icons.check_circle_rounded
                        : active
                        ? Icons.radio_button_checked_rounded
                        : Icons.lock_outline_rounded,
                    color: active || valid ? color : Colors.grey,
                    size: 18,
                  ),
                  label: Text(titles[index], overflow: TextOverflow.ellipsis),
                  backgroundColor: active
                      ? color.withValues(alpha: 0.12)
                      : null,
                  side: BorderSide(
                    color: active ? color : const Color(0xFFDDE6E2),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

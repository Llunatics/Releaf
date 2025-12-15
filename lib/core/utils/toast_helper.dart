import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum ToastType {
  success,
  error,
  warning,
  info,
}

class ToastHelper {
  static void show(
    BuildContext context, {
    required String message,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
    String? title,
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    
    final (Color bgColor, Color iconColor, IconData icon, List<Color> gradient) = switch (type) {
      ToastType.success => (
        const Color(0xFF10B981),
        Colors.white,
        Icons.check_circle_rounded,
        [const Color(0xFF10B981), const Color(0xFF059669)],
      ),
      ToastType.error => (
        const Color(0xFFEF4444),
        Colors.white,
        Icons.error_rounded,
        [const Color(0xFFEF4444), const Color(0xFFDC2626)],
      ),
      ToastType.warning => (
        const Color(0xFFF59E0B),
        Colors.white,
        Icons.warning_rounded,
        [const Color(0xFFF59E0B), const Color(0xFFD97706)],
      ),
      ToastType.info => (
        const Color(0xFF3B82F6),
        Colors.white,
        Icons.info_rounded,
        [const Color(0xFF3B82F6), const Color(0xFF2563EB)],
      ),
    };

    final snackBar = SnackBar(
      content: _ToastContent(
        message: message,
        title: title,
        icon: icon,
        iconColor: iconColor,
        gradient: gradient,
        onAction: onAction,
        actionLabel: actionLabel,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      duration: duration,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showSuccess(BuildContext context, String message, {String? title}) {
    show(context, message: message, type: ToastType.success, title: title);
  }

  static void showError(BuildContext context, String message, {String? title}) {
    show(context, message: message, type: ToastType.error, title: title);
  }

  static void showWarning(BuildContext context, String message, {String? title}) {
    show(context, message: message, type: ToastType.warning, title: title);
  }

  static void showInfo(BuildContext context, String message, {String? title}) {
    show(context, message: message, type: ToastType.info, title: title);
  }
}

class _ToastContent extends StatelessWidget {
  final String message;
  final String? title;
  final IconData icon;
  final Color iconColor;
  final List<Color> gradient;
  final VoidCallback? onAction;
  final String? actionLabel;

  const _ToastContent({
    required this.message,
    required this.icon,
    required this.iconColor,
    required this.gradient,
    this.title,
    this.onAction,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradient.first.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: -4,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Background decorative circles
            Positioned(
              top: -20,
              right: -20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -30,
              left: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: iconColor, size: 24),
                  ).animate().scale(
                    duration: 300.ms,
                    curve: Curves.easeOutBack,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (title != null) ...[
                          Text(
                            title!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 2),
                        ],
                        Text(
                          message,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: title != null ? 0.9 : 1),
                            fontWeight: title != null ? FontWeight.w400 : FontWeight.w500,
                            fontSize: title != null ? 13 : 14,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  if (onAction != null && actionLabel != null) ...[
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: onAction,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          actionLabel!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().slideY(
      begin: 1,
      end: 0,
      duration: 300.ms,
      curve: Curves.easeOutCubic,
    ).fadeIn(duration: 200.ms);
  }
}

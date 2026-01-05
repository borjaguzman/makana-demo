import 'package:flutter/material.dart';

/// Loading overlay widget to show during async operations
class LoadingOverlay extends StatelessWidget {
  final String? message;
  final bool isVisible;

  const LoadingOverlay({
    Key? key,
    this.message,
    this.isVisible = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    return Container(
      color: Colors.black54,
      child: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                if (message != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    message!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Show loading overlay as a dialog
  static void show(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoadingOverlay(message: message),
    );
  }

  /// Hide loading overlay
  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  /// Show loading for a minimum duration to ensure animation is visible
  static Future<T> showWithMinDuration<T>({
    required BuildContext context,
    required Future<T> future,
    String? message,
    Duration minDuration = const Duration(milliseconds: 800),
  }) async {
    show(context, message: message);
    
    final results = await Future.wait([
      future,
      Future.delayed(minDuration),
    ]);
    
    if (context.mounted) {
      hide(context);
    }
    
    return results[0] as T;
  }
}

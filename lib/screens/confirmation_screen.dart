import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/gift_card.dart';
import '../providers/coins_provider.dart';
import '../widgets/loading_overlay.dart';

class ConfirmationScreen extends StatelessWidget {
  final GiftCardOption option;

  const ConfirmationScreen({Key? key, required this.option}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.simpleCurrency(locale: 'es_CL', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(title: const Text("Confirmar Canje")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Estás a un paso de tu premio",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Revisa los detalles antes de confirmar.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            
            // Summary Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _rowDetail("Tienda", option.storeName),
                  const Divider(height: 24),
                  _rowDetail("Monto Giftcard", currency.format(option.amountClp), isBold: true),
                  const Divider(height: 24),
                  _rowDetail("Costo en Coins", "${option.costCoins} Coins", color: Colors.blue),
                ],
              ),
            ),
            
            const Spacer(),
            
            // Explicit Action Button
            SizedBox(
              width: double.infinity,
              child: Consumer<CoinsProvider>(
                builder: (context, provider, child) {
                  return ElevatedButton(
                    onPressed: provider.isLoading 
                        ? null 
                        : () async {
                            // Show loading overlay with minimum duration
                            LoadingOverlay.show(
                              context, 
                              message: 'Procesando tu canje...',
                            );
                            
                            // Add minimum delay to ensure animation is visible
                            final results = await Future.wait([
                              provider.redeemGiftCard(option),
                              Future.delayed(const Duration(milliseconds: 1200)),
                            ]);
                            
                            final success = results[0] as bool;
                            
                            if (context.mounted) {
                              LoadingOverlay.hide(context);
                              
                              if (success) {
                                // Navigate to success state or back
                                Navigator.of(context).pop(); // Close confirm
                                _showSuccessDialog(context, option);
                              } else if (provider.error != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(provider.error!)),
                                );
                              }
                            }
                        },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: provider.isLoading
                      ? const SizedBox(
                          height: 20, width: 20, 
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                        )
                      : const Text("Confirmar Canje", style: TextStyle(fontSize: 18)),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancelar", style: TextStyle(color: Colors.grey)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rowDetail(String label, String value, {bool isBold = false, Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.black54)),
        Text(value, style: TextStyle(
          fontSize: 18, 
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: color ?? Colors.black87
        )),
      ],
    );
  }

  void _showSuccessDialog(BuildContext context, GiftCardOption option) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Column(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 60),
            SizedBox(height: 16),
            Text("¡Canje Exitoso!"),
          ],
        ),
        content: Text(
          "Disfruta tu Giftcard de ${option.storeName}. Puedes ver el código en la sección 'Mis Giftcards'.",
          textAlign: TextAlign.center,
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop(); // Close dialog
                Navigator.of(context).pop(); // Back to Dashboard (assuming Confirm was pushed)
              },
              child: const Text("Entendido"),
            ),
          )
        ],
      ),
    );
  }
}

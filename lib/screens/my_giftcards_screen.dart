import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/coins_provider.dart';

class MyGiftCardsScreen extends StatelessWidget {
  const MyGiftCardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myCards = context.watch<CoinsProvider>().myGiftCards;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Giftcards"),
      ),
      body: myCards.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.card_giftcard, size: 60, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text(
                    "No tienes giftcards aún",
                    style: TextStyle(color: Colors.grey[500], fontSize: 16),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: myCards.length,
              itemBuilder: (context, index) {
                final card = myCards[index];
                final currency = NumberFormat.simpleCurrency(locale: 'es_CL', decimalDigits: 0);

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              card.option.storeName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currency.format(card.option.amountClp),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green, // Visual emphasis on value
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Canjeado el: ${DateFormat('dd/MM/yyyy').format(card.dateRedeemed)}",
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                        const Divider(height: 24),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  card.code,
                                  style: const TextStyle(
                                    fontFamily: 'Courier',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.copy, color: Colors.blue),
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(text: card.code));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Código copiado al portapapeles")),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/transaction.dart';
import '../providers/coins_provider.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transactions = context.watch<CoinsProvider>().transactions;
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final currency = NumberFormat.simpleCurrency(locale: 'es_CL', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Historial de Transacciones"),
      ),
      body: transactions.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 60, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text(
                    "No hay transacciones recientes",
                    style: TextStyle(color: Colors.grey[500], fontSize: 16),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: transactions.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                final isEarned = transaction.type == TransactionType.earned;

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isEarned ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isEarned ? Icons.arrow_downward : Icons.arrow_upward,
                      color: isEarned ? Colors.green : Colors.orange,
                    ),
                  ),
                  title: Text(
                    transaction.description,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    dateFormat.format(transaction.date),
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  trailing: Text(
                    "${isEarned ? '+' : '-'}${transaction.amount}",
                    style: TextStyle(
                      color: isEarned ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                );
              },
            ),
    );
  }
}

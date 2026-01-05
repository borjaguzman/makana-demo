import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/gift_card.dart';
import 'animated_scale_button.dart';

class CatalogItem extends StatelessWidget {
  final GiftCardOption option;
  final bool canAfford;
  final VoidCallback onTap;

  const CatalogItem({
    Key? key,
    required this.option,
    required this.canAfford,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'es_CL', decimalDigits: 0);
    
    
    return AnimatedScaleButton(
      onTap: canAfford ? onTap : null,
      child: Card(
        elevation: 2,
        color: canAfford ? Colors.white : Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mock Image / Store Name Header
              Row(
                children: [
                   Container(
                     width: 40,
                     height: 40,
                     decoration: BoxDecoration(
                       color: Colors.grey[200],
                       shape: BoxShape.circle,
                     ),
                     child: Icon(Icons.store, color: canAfford ? Colors.blue : Colors.grey),
                   ),
                   const SizedBox(width: 8),
                   Expanded(
                     child: Text(
                       option.storeName,
                       style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 14,
                         color: canAfford ? Colors.black87 : Colors.grey,
                       ),
                       overflow: TextOverflow.ellipsis,
                     ),
                   ),
                ],
              ),
              const Spacer(),
              // Value in CLP
              Text(
                formatCurrency.format(option.amountClp),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: canAfford ? Colors.black : Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              // Cost in Coins
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: canAfford ? Colors.blue.withOpacity(0.1) : Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "${option.costCoins} Coins",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: canAfford ? Colors.blue : Colors.grey[600],
                  ),
                ),
              ),
              if (!canAfford) ...[ 
                 const SizedBox(height: 4),
                 const Text(
                   "Insuficiente",
                   style: TextStyle(fontSize: 10, color: Colors.orange),
                 )
              ]
            ],
          ),
        ),
      ),
    );
  }
}

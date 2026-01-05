import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/coins_provider.dart';
import '../widgets/balance_card.dart';
import '../widgets/catalog_item.dart';
import 'confirmation_screen.dart';
import 'my_giftcards_screen.dart';
import '../utils/page_transitions.dart';

class CoinsDashboard extends StatelessWidget {
  const CoinsDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Makana Coins"),
      ),
      body: Consumer<CoinsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.catalog.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () async {
              // Trigger a reload if needed, for now just a mockup
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BalanceCard(balance: provider.balance),
                  const SizedBox(height: 16),
                  
                  // Button to access My Giftcards
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          FadePageRoute(page: const MyGiftCardsScreen()),
                        );
                      },
                      icon: const Icon(Icons.confirmation_number_outlined),
                      label: const Text("Mis Giftcards"),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Description / Call to Action
                  const Text(
                    "Canjea tus premios",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Usa tus coins acumulados para obtener Giftcards en tus tiendas favoritas.",
                    style: TextStyle(color: Colors.grey),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Catalog Grid
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(), // Scroll handled by Parent
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75, // Taller cards
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: provider.catalog.length,
                    itemBuilder: (context, index) {
                      final option = provider.catalog[index];
                      final canAfford = provider.balance >= option.costCoins;
                      
                      // Staggered animation delays
                      final delay = Duration(milliseconds: 100 * index);
                      
                      return TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                        tween: Tween(begin: 0.0, end: 1.0),
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 20 * (1 - value)),
                              child: CatalogItem(
                                option: option,
                                canAfford: canAfford,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    SlidePageRoute(
                                      page: ConfirmationScreen(option: option),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
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

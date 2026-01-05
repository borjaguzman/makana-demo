import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/coins_provider.dart';
import '../widgets/balance_card.dart';
import '../widgets/catalog_item.dart';
import 'confirmation_screen.dart';
import 'my_giftcards_screen.dart';
import 'transaction_history_screen.dart';
import '../utils/page_transitions.dart';
import '../widgets/makana_loading.dart';

class CoinsDashboard extends StatelessWidget {
  const CoinsDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Makana Coins"),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Historial',
            onPressed: () {
              Navigator.push(
                context,
                SlidePageRoute(page: const TransactionHistoryScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<CoinsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.catalog.isEmpty) {
            return const MakanaLoading();
          }

          final filteredCatalog = provider.filteredCatalog;

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
                  
                  // Buttons Row
                  Row(
                    children: [
                      Expanded(
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
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Description / Call to Action
                  const Text(
                    "Canjea tus premios",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  
                  // Search Bar
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar tienda...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: provider.searchQuery.isNotEmpty 
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 20),
                            onPressed: () => provider.setSearchQuery(''),
                          )
                        : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                    ),
                    onChanged: (value) => provider.setSearchQuery(value),
                    controller: provider.searchQuery.isNotEmpty 
                        ? (TextEditingController(text: provider.searchQuery)..selection = TextSelection.fromPosition(TextPosition(offset: provider.searchQuery.length)))
                        : null,
                  ),
                  const SizedBox(height: 12),
                  
                  // Type Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: provider.availableTypes.map((type) {
                        final isSelected = provider.selectedTypes.contains(type);
                        // Simple capitalization
                        final label = type.isNotEmpty 
                            ? '${type[0].toUpperCase()}${type.substring(1)}' 
                            : type;
                            
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FilterChip(
                            label: Text(label),
                            selected: isSelected,
                            onSelected: (selected) {
                              provider.toggleTypeFilter(type);
                            },
                            backgroundColor: Colors.white,
                            selectedColor: Colors.blue.withOpacity(0.2),
                            checkmarkColor: Colors.blue,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.blue : Colors.black87,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: isSelected ? Colors.blue : Colors.grey.shade300,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Price Range Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildPriceChip(
                          context, 
                          provider, 
                          PriceRange.low, 
                          '≤ 5.000',
                        ),
                        _buildPriceChip(
                          context, 
                          provider, 
                          PriceRange.medium, 
                          '5.001 - 10.000',
                        ),
                        _buildPriceChip(
                          context, 
                          provider, 
                          PriceRange.high, 
                          '> 10.000',
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Catalog Grid
                  filteredCatalog.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            children: [
                              Icon(Icons.search_off, size: 48, color: Colors.grey[300]),
                              const SizedBox(height: 16),
                              Text(
                                "No se encontraron resultados",
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                              TextButton(
                                onPressed: () => provider.clearFilters(),
                                child: const Text("Limpiar filtros"),
                              ),
                            ],
                          ),
                        ),
                      )
                    : GridView.builder(
                        physics: const NeverScrollableScrollPhysics(), // Scroll handled by Parent
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75, // Taller cards
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: filteredCatalog.length,
                        itemBuilder: (context, index) {
                          final option = filteredCatalog[index];
                          final canAfford = provider.balance >= option.costCoins;
                          
                          // Staggered animation delays
                          // Use index from filtered list, might reset animations on filter change which is fine
                          
                          return TweenAnimationBuilder<double>(
                            key: ValueKey(option.id), // Key helps with animation consistency
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
                      
                  const SizedBox(height: 48), // Bottom padding
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildPriceChip(
    BuildContext context, 
    CoinsProvider provider, 
    PriceRange range, 
    String label
  ) {
    final isSelected = provider.selectedPriceRange == range;
    
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          provider.setPriceFilter(range);
        },
        backgroundColor: Colors.white,
        selectedColor: Colors.green.withOpacity(0.1),
        checkmarkColor: Colors.green,
        labelStyle: TextStyle(
          color: isSelected ? Colors.green[800] : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? Colors.green : Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}

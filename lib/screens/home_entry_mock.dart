import 'package:flutter/material.dart';
import 'coins_dashboard.dart';
import '../utils/page_transitions.dart';

class HomeEntryMock extends StatelessWidget {
  const HomeEntryMock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Perfil"),
        leading: const Icon(Icons.arrow_back_ios), 
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // User Header Mock
            Row(
              children: const [
                Text(
                  "Carlos Jouanne",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Text("👷", style: TextStyle(fontSize: 24)),
              ],
            ),
            const SizedBox(height: 24),

            // Statistics Mock (Visual Only)
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                   _statMock(Icons.check_circle, "66%", "Cumplimiento", Colors.green),
                   _statMock(Icons.accessibility_new, "7", "Zonas", Colors.blue),
                   _statMock(Icons.timer, "51m", "Tiempo", Colors.yellow[700]!),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),

            // ENTRY POINT TO NEW FEATURE
            // Designed to stand out but fit the UI
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  SlidePageRoute(page: const CoinsDashboard()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E60F4), Color(0xFF1546B0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.stars, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mis Makana Coins",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Canjea giftcards aquí",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Other Profile Info Mock
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Información Personal:", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _infoChip(Icons.work, "19638444-8"),
                        const SizedBox(width: 8),
                        _infoChip(Icons.phone, "+56991712991"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statMock(IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _infoChip(IconData icon, String text) {
    return Chip(
      avatar: Icon(icon, size: 16, color: Colors.blue),
      label: Text(text),
      backgroundColor: Colors.blue[50],
    );
  }
}

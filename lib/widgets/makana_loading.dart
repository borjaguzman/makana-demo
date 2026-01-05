import 'package:flutter/material.dart';
import 'dart:math' as math;

class MakanaLoading extends StatefulWidget {
  const MakanaLoading({Key? key}) : super(key: key);

  @override
  State<MakanaLoading> createState() => _MakanaLoadingState();
}

class _MakanaLoadingState extends State<MakanaLoading> with TickerProviderStateMixin {
  late AnimationController _spinController;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    
    // Controlador para el giro de la moneda (infinito)
    _spinController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Controlador para el efecto de pulso (respiración)
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _spinController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Fondo/Resplandor Pulsante
              ScaleTransition(
                scale: _pulseAnimation,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                ),
              ),
              
              // Moneda Giratoria 3D
              AnimatedBuilder(
                animation: _spinController,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001) // Perspectiva
                      ..rotateY(_spinController.value * 2 * math.pi),
                    alignment: Alignment.center,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFFD700), // Gold
                            Color(0xFFFFA000), // Amber darker
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                      ),
                      child: const Icon(
                        Icons.attach_money,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Texto animado
          FadeTransition(
            opacity: _pulseAnimation,
            child: const Text(
              "Cargando Makana Coins...",
              style: TextStyle(
                color: Colors.grey, 
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

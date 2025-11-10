import 'package:flutter/material.dart';

String formatRupiahInt(int value) {
  final s = value.toString();
  final reg = RegExp(r'\B(?=(\d{3})+(?!\d))');
  return 'Rp' + s.replaceAllMapped(reg, (m) => '.');
}

class AtmCard extends StatelessWidget {
  final int balance;
  final String cardNumber;
  final String expiryDate;
  final Color color1;
  final Color color2;
  final String? bankShort;

  const AtmCard({
    Key? key,
    required this.balance,
    required this.cardNumber,
    required this.expiryDate,
    required this.color1,
    required this.color2,
    this.bankShort,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(18),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color1.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // top row: bank short and card icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (bankShort != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    bankShort!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              const Icon(Icons.credit_card, color: Colors.white70),
            ],
          ),

          const SizedBox(height: 12),

          const Text(
            'Saldo',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            formatRupiahInt(balance),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '•••• •••• •••• ${cardNumber}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  letterSpacing: 1.4,
                ),
              ),
              Text(
                expiryDate,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
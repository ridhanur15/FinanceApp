import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;

  final Color color;

  const TransactionItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isExpense = amount.startsWith('-');
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.06),
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
              color: color.withOpacity(0.14),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isExpense ? Colors.redAccent : Colors.green[700],
            ),
          ),
        ],
      ),
    );
  }
}
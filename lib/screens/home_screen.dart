import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/atm_card.dart';
import '../widgets/transaction_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final PageController _pageController = PageController(viewportFraction: 0.85);
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0.0;
      });
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  // Header
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Halo, Ridha Nurmala👋',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          CircleAvatar(
            radius: 26,
            backgroundColor: Color(0xFFF2F0EA), // krem
            child: const Icon(Icons.person, color: Colors.black87, size: 28),
          ),
        ],
      ),
    );
  }

  // Summary Saldo
  Widget _buildSummaryHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Color(0xFFA8D5E3), // teal
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Total Saldo Anda',
                style: TextStyle(color: Colors.white70, fontSize: 14)),
            SizedBox(height: 8),
            Text('Rp12.790.800',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      ),
    );
  }

  // Kartu ATM
  Widget _buildAtmCards() {
    final cards = [
      const AtmCard(
          balance: 9590800,
          cardNumber: '1122',
          expiryDate: '03/27',
          color1: Color(0xFFFF78AC), // merah muda
          color2: Color(0xFFA8D5E3), // teal
          bankShort: 'BCA'),
      const AtmCard(
          balance: 750000,
          cardNumber: '7788',
          expiryDate: '02/27',
          color1: Color(0xFFFF78AC),
          color2: Color(0xFFA8D5E3),
          bankShort: 'BRI'),
      const AtmCard(
          balance: 2450000,
          cardNumber: '3456',
          expiryDate: '08/25',
          color1: Color(0xFFFF78AC),
          color2: Color(0xFFA8D5E3),
          bankShort: 'BNI'),
    ];

    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: _pageController,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final scale = (_currentPage - index).abs() < 1
              ? 1 - (_currentPage - index).abs() * 0.12
              : 0.88;
          return Transform.scale(
            scale: scale,
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(18),
              child: cards[index],
            ),
          );
        },
      ),
    );
  }

  // Quick Menu
  Widget _buildQuickMenu() {
    final items = [
      {'icon': Icons.send, 'label': 'Transfer', 'color': Color(0xFFFF78AC)},
      {'icon': Icons.account_balance_wallet, 'label': 'Top Up', 'color': Color(0xFFA8D5E3)},
      {'icon': Icons.payment, 'label': 'Tagihan', 'color': Color(0xFFFF78AC)},
      {'icon': Icons.more_horiz, 'label': 'Lainnya', 'color': Color(0xFFA8D5E3)},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          final Color color = item['color'] as Color;
          return InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {},
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withOpacity(0.25),
                  ),
                  child: Icon(item['icon'] as IconData, color: color, size: 28),
                ),
                const SizedBox(height: 6),
                Text(
                  item['label'] as String,
                  style: TextStyle(color: Colors.black87, fontSize: 13),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // Recent Transactions
  Widget _buildRecentTransactions() {
    final transactions = [
      {
        'icon': Icons.local_cafe,
        'title': 'Kopi Janji Jiwa',
        'subtitle': 'Hari ini',
        'amount': '-Rp25.000',
        'color': Color(0xFFFF78AC)
      },
      {
        'icon': Icons.lunch_dining,
        'title': 'Makan Siang',
        'subtitle': 'Kemarin',
        'amount': '-Rp38.000',
        'color': Color(0xFFA8D5E3)
      },
      {
        'icon': Icons.shopping_bag,
        'title': 'Belanja Shopee',
        'subtitle': '2 hari lalu',
        'amount': '-Rp120.000',
        'color': Color(0xFFFF78AC)
      },
      {
        'icon': Icons.monetization_on,
        'title': 'Gaji Bulanan',
        'subtitle': '5 hari lalu',
        'amount': '+Rp5.000.000',
        'color': Color(0xFFA8D5E3)
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Transaksi Terbaru',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          Column(
            children: List.generate(transactions.length, (index) {
              final tx = transactions[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            color: tx['color'] as Color, shape: BoxShape.circle),
                      ),
                      if (index != transactions.length - 1)
                        Container(
                          width: 2,
                          height: 40,
                          color: Colors.black26,
                        ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TransactionItem(
                      icon: tx['icon'] as IconData,
                      title: tx['title'] as String,
                      subtitle: tx['subtitle'] as String,
                      amount: tx['amount'] as String,
                      color: tx['color'] as Color,
                    ),
                  )
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  // Financial Summary
  Widget _buildFinancialSummary() {
    final double totalIncome = 5000000;
    final double totalExpense = 235000;
    final double expensePercent = totalExpense / totalIncome;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF2F0EA), // krem solid
          borderRadius: BorderRadius.circular(22),
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ringkasan Keuangan Bulan Ini',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Pemasukan', style: TextStyle(color: Colors.black54)),
                Text('+Rp${totalIncome.toStringAsFixed(0)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black87)),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Pengeluaran', style: TextStyle(color: Colors.black54)),
                Text('-Rp${totalExpense.toStringAsFixed(0)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black87)),
              ],
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: LinearProgressIndicator(
                value: expensePercent,
                color: Color(0xFFFF78AC),
                backgroundColor: Colors.black12,
                minHeight: 12,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Pengeluaran hanya ${(expensePercent * 100).toStringAsFixed(1)}% dari total pemasukan. Hebat! 🎉',
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFF78AC),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tambah transaksi coming soon! 😄')),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Container(
        color: const Color(0xFFF2F0EA), // solid krem
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    _buildSummaryHeader(),
                    _buildAtmCards(),
                    _buildQuickMenu(),
                    _buildRecentTransactions(),
                    _buildFinancialSummary(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
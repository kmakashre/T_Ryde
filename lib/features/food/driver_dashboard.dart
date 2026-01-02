import 'package:flutter/material.dart';
import 'package:tryde_partner/features/food/partner_profile_screen.dart';
import 'package:tryde_partner/features/food/wallet_screen.dart';
import 'order_req_screen.dart';

/// ===================== MAIN DASHBOARD =====================
class PartnerDashboardScreen extends StatefulWidget {
  const PartnerDashboardScreen({super.key});

  @override
  State<PartnerDashboardScreen> createState() =>
      _PartnerDashboardScreenState();
}

class _PartnerDashboardScreenState extends State<PartnerDashboardScreen> {
  int _currentIndex = 0;
  bool _isOnline = true;

  late final List<Widget> _screens = const [
    DashboardHome(),
    OrderListScreen(),
    WalletScreen(),
    PartnerProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _screens[_currentIndex],
      bottomNavigationBar: PartnerBottomNav(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Good Afternoon 👋",
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          Text("Delivery Partner",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () {
            setState(() => _isOnline = !_isOnline);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  _isOnline
                      ? "You are Online – Waiting for orders"
                      : "You are Offline",
                ),
              ),
            );
          },
          child: _OnlineStatusChip(isOnline: _isOnline),
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.black),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("No new notifications")),
            );
          },
        ),
      ],
    );
  }
}

/// ===================== HOME =====================
class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EarningsHeroCard(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const WalletScreen()),
                );
              },
            ),
            const SizedBox(height: 20),

            const Text(
              "Performance",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const PerformanceInsights(),
            const SizedBox(height: 20),

            const RecentOrdersSection(),
            const SizedBox(height: 20),

            const RatingsCard(),
          ],
        ),
      ),
    );
  }
}

/// ===================== ONLINE CHIP =====================
class _OnlineStatusChip extends StatelessWidget {
  final bool isOnline;
  const _OnlineStatusChip({required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isOnline
            ? Colors.green.withOpacity(0.15)
            : Colors.red.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isOnline ? "ONLINE" : "OFFLINE",
        style: TextStyle(
          color: isOnline ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// ===================== EARNINGS =====================
class EarningsHeroCard extends StatelessWidget {
  final VoidCallback onTap;
  final String amount;
  final String subtitle;

  const EarningsHeroCard({
    super.key,
    required this.onTap,
    this.amount = "₹1,240",
    this.subtitle = "TODAY'S EARNINGS",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [Color(0xFFFF6A00), Color(0xFFFF8F00)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subtitle,
                style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    letterSpacing: 1.1)),
            const SizedBox(height: 10),
            Row(
              children: const [
                Text("₹1,240",
                    style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Spacer(),
                Icon(Icons.arrow_forward_ios,
                    size: 18, color: Colors.white70),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ===================== PERFORMANCE =====================
class PerformanceInsights extends StatelessWidget {
  const PerformanceInsights({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          _InsightCard("Completion", "96%"),
          _InsightCard("Avg Time", "22 min"),
          _InsightCard("Acceptance", "92%"),
        ],
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  final String title;
  final String value;
  const _InsightCard(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05), blurRadius: 12),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value,
              style:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Spacer(),
          Text(title, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

/// ===================== RECENT ORDERS =====================
class RecentOrdersSection extends StatelessWidget {
  const RecentOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Recent Orders",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        _OrderCard(name: "Burger King", status: "Completed", color: Colors.green),
        _OrderCard(name: "Domino's", status: "In Progress", color: Colors.orange),
        _OrderCard(name: "KFC", status: "Cancelled", color: Colors.red),
      ],
    );
  }
}

class _OrderCard extends StatelessWidget {
  final String name;
  final String status;
  final Color color;

  const _OrderCard(
      {required this.name, required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    return _PremiumCard(
      child: ListTile(
        title: Text(name),
        trailing: Chip(
          label: Text(status),
          backgroundColor: color.withOpacity(0.15),
          labelStyle: TextStyle(color: color),
        ),
      ),
    );
  }
}

/// ===================== RATINGS =====================
class RatingsCard extends StatelessWidget {
  const RatingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _PremiumCard(
      child: Row(
        children: const [
          Icon(Icons.star, color: Colors.amber, size: 32),
          SizedBox(width: 10),
          Text("4.7 / 5",
              style:
              TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

/// ===================== COMMON CARD =====================
class _PremiumCard extends StatelessWidget {
  final Widget child;
  const _PremiumCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: child,
    );
  }
}

/// ===================== BOTTOM NAV =====================
class PartnerBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const PartnerBottomNav(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: const Color(0xFFFF6A00),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: "Orders"),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet), label: "Wallet"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}

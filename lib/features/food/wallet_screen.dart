import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _walletCard(),
            const SizedBox(height: 20),
            _summaryRow(),
            const SizedBox(height: 20),
            _transactionTitle(),
            _transactionTile("Order #1234", "+ ₹120"),
            _transactionTile("Order #1233", "+ ₹95"),
            _transactionTile("Order #1232", "+ ₹140"),
          ],
        ),
      ),
    );
  }

  Widget _walletCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.green, Colors.teal],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Wallet Balance",
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: 6),
          Text(
            "₹ 2,450",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _summaryBox("Today", "₹420"),
        _summaryBox("Orders", "8"),
        _summaryBox("Rating", "4.8 ⭐"),
      ],
    );
  }

  Widget _summaryBox(String title, String value) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _transactionTitle() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "Recent Transactions",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _transactionTile(String title, String amount) {
    return ListTile(
      leading: const Icon(Icons.receipt_long),
      title: Text(title),
      trailing: Text(
        amount,
        style: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}

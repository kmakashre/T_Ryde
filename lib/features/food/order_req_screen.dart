import 'package:flutter/material.dart';

/// ================== ORDER LIST SCREEN ==================
class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Orders"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const OrderRequestScreen(),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.fastfood, color: Colors.white),
                ),
                title: Text(
                  "Domino's Pizza",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Pickup 2.5 km • Drop 5 km"),
                trailing: Text(
                  "₹85",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// ================== ORDER REQUEST SCREEN ==================
class OrderRequestScreen extends StatelessWidget {
  const OrderRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Request"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Restaurant Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const ListTile(
                title: Text(
                  "Domino's Pizza",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Pickup: 2.5 km • Drop: 5 km"),
                trailing: Text(
                  "₹85",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const OrderDetailTile(
              icon: Icons.store,
              title: "Pickup Location",
              value: "Domino's, MG Road",
            ),
            const OrderDetailTile(
              icon: Icons.location_on,
              title: "Drop Location",
              value: "Customer Address",
            ),
            const OrderDetailTile(
              icon: Icons.timer,
              title: "Estimated Time",
              value: "22 mins",
              highlight: true,
            ),

            const Spacer(),

            /// Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Reject"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DeliveryFlowScreen(),
                        ),
                      );
                    },
                    child: const Text("Accept Order"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ================== ORDER DETAIL TILE ==================
class OrderDetailTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool highlight;

  const OrderDetailTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color:
        highlight ? const Color(0xFFFFF3E0) : const Color(0xFFF9FAFC),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor:
            highlight ? Colors.orange : Colors.grey.shade200,
            child: Icon(
              icon,
              color: highlight ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight:
                    highlight ? FontWeight.bold : FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ================== DELIVERY FLOW PLACEHOLDER ==================
class DeliveryFlowScreen extends StatefulWidget {
  const DeliveryFlowScreen({super.key});

  @override
  State<DeliveryFlowScreen> createState() => _DeliveryFlowScreenState();
}

class _DeliveryFlowScreenState extends State<DeliveryFlowScreen> {
  int _currentStep = 0;

  final List<_DeliveryStep> _steps = [
    _DeliveryStep(
      title: "Go to Pickup Location",
      icon: Icons.store_mall_directory,
    ),
    _DeliveryStep(
      title: "Reached Restaurant",
      icon: Icons.store,
    ),
    _DeliveryStep(
      title: "Order Picked",
      icon: Icons.shopping_bag,
    ),
    _DeliveryStep(
      title: "Go to Drop Location",
      icon: Icons.location_on,
    ),
    _DeliveryStep(
      title: "Order Delivered",
      icon: Icons.check_circle,
    ),
  ];

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() => _currentStep++);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const DeliveryRatingScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final step = _steps[_currentStep];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery in Progress"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Progress bar
            LinearProgressIndicator(
              value: (_currentStep + 1) / _steps.length,
              minHeight: 8,
              color: Colors.orange,
              backgroundColor: Colors.orange.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),

            const SizedBox(height: 30),

            /// Status Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 14,
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.orange.withOpacity(0.15),
                    child: Icon(
                      step.icon,
                      size: 40,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    step.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Step ${_currentStep + 1} of ${_steps.length}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            const Spacer(),

            /// CTA Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: _nextStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  _currentStep == _steps.length - 1
                      ? "Finish Delivery"
                      : "Mark as Done",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class DeliveryRatingScreen extends StatefulWidget {
  const DeliveryRatingScreen({super.key});

  @override
  State<DeliveryRatingScreen> createState() => _DeliveryRatingScreenState();
}

class _DeliveryRatingScreenState extends State<DeliveryRatingScreen> {
  int _rating = 5;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rate Delivery"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 30),

            /// Icon
            const CircleAvatar(
              radius: 45,
              backgroundColor: Color(0xFFFFF3E0),
              child: Icon(
                Icons.delivery_dining,
                size: 45,
                color: Colors.orange,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "How was your delivery experience?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Your feedback helps us improve our service",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 24),

            /// Star Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    Icons.star,
                    size: 38,
                    color: index < _rating
                        ? Colors.orange
                        : Colors.grey.shade300,
                  ),
                  onPressed: () {
                    setState(() => _rating = index + 1);
                  },
                );
              }),
            ),

            const SizedBox(height: 20),

            /// Feedback Field
            TextField(
              controller: _feedbackController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Write your feedback (optional)",
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const Spacer(),

            /// Submit Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Delivery completed successfully 🎉"),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Submit Rating",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _DeliveryStep {
  final String title;
  final IconData icon;

  _DeliveryStep({required this.title, required this.icon});
}

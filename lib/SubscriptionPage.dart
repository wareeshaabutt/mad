import 'package:flutter/material.dart';

class SubscriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Subscription Plans",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Choose a Subscription Plan",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildSubscriptionCard(
                title: "Basic Plan",
                price: "\$9.99/month",
                benefits: [
                  "Access to basic workouts",
                  "No personal trainer",
                  "Community support",
                ],
                color: Colors.teal.shade50,
              ),
              _buildSubscriptionCard(
                title: "Standard Plan",
                price: "\$19.99/month",
                benefits: [
                  "Access to all workouts",
                  "One personal trainer session/month",
                  "Community support",
                ],
                color: Colors.teal.shade200,
              ),
              _buildSubscriptionCard(
                title: "Premium Plan",
                price: "\$29.99/month",
                benefits: [
                  "Unlimited workout access",
                  "Unlimited personal trainer sessions",
                  "Premium community support",
                  "Customized meal plans",
                ],
                color: Colors.teal.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard({
    required String title,
    required String price,
    required List<String> benefits,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Price Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                ),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal[900],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),

            Divider(color: Colors.teal[700], thickness: 1),

            SizedBox(height: 10),

            // Benefits List
            Column(
              children: benefits.map(
                    (benefit) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.teal[800], size: 20),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            benefit,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.teal[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'payment_done.dart';

class CheckoutCoachPage extends StatefulWidget {
  const CheckoutCoachPage({super.key});

  @override
  State<CheckoutCoachPage> createState() => _CheckoutCoachPageState();
}

class _CheckoutCoachPageState extends State<CheckoutCoachPage> {
  final String _selectedType = 'Video Call';
  final String _selectedDuration = '1 hour';

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();

  final Color mainColor = const Color(0xFF1F2937);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF0F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFF0F4),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Check Out',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildDoctorCard(),
            const SizedBox(height: 20),
            _buildAppointmentSection(),
            const SizedBox(height: 20),
            _buildPaymentSection(),
            const SizedBox(height: 20),
            _buildAmountSection(),
            const SizedBox(height: 10),
            _buildCheckoutButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorCard() => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: const [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/life_coach.png'),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dr. Mohamed', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Life Coach'),
              ],
            ),
          ],
        ),
      );

  Widget _buildAppointmentSection() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Appointment Type', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildStaticCard('Type', _selectedType),
            const SizedBox(height: 14),
            const Text('Duration', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildStaticCard('Duration', _selectedDuration),
          ],
        ),
      );

  Widget _buildStaticCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.teal, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildPaymentSection() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.radio_button_checked, color: Colors.teal),
                SizedBox(width: 8),
                Text('Credit Card / Debit Card', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _cardHolderController,
              decoration: const InputDecoration(
                labelText: 'Card Holder',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              maxLength: 19,
              decoration: const InputDecoration(
                labelText: 'Card Number',
                prefixIcon: Icon(Icons.credit_card),
                border: OutlineInputBorder(),
                counterText: "",
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _expiryController,
                    keyboardType: TextInputType.number,
                    maxLength: 5,
                    decoration: const InputDecoration(
                      labelText: 'MM/YY',
                      border: OutlineInputBorder(),
                      counterText: "",
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _cvvController,
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    decoration: const InputDecoration(
                      labelText: 'CVV',
                      border: OutlineInputBorder(),
                      counterText: "",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildAmountSection() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text('Total Amount:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('LE 500.00', style: TextStyle(color: Color(0xFF01B5C5), fontWeight: FontWeight.bold)),
        ],
      );

  Widget _buildCheckoutButton() => ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PaymentSuccessPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: mainColor,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: const Text('Check Out', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'payment_done.dart'; // Import the PaymentSuccessPage

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CheckoutPage(),
  ));
}

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _selectedType = 'Video Call';
  String _selectedDuration = '1 hour';

  final _appointmentTypes = ['Video Call', 'Audio Call'];

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF0F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFF0F4),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);  // Go back to the previous screen
          },
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
            _buildCheckoutButton(context), // Pass context here for navigation
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: const [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/doctor.png'), // Replace with your image
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dr. Mark', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Clinical Psychologist'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Choose Type of Appointment', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: _selectedType,
            items: _appointmentTypes
                .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                .toList(),
            onChanged: (value) => setState(() => _selectedType = value!),
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['30 min', '1 hour', '2 hours'].map((label) {
              final selected = _selectedDuration == label;
              return GestureDetector(
                onTap: () => setState(() => _selectedDuration = label),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color.fromARGB(255, 24, 41, 125)
                        : const Color(0xFFDFF0F4),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.teal, width: 1),
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      color: selected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 14),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 24, 41, 125),
              minimumSize: const Size.fromHeight(45),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            child: const Text('Confirm', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Container(
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
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
              CardNumberInputFormatter(separator: ' '), // Use '-' if you want dashes
            ],
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                    LengthLimitingTextInputFormatter(5),
                    _ExpiryDateInputFormatter(),
                  ],
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
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
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
  }

  Widget _buildAmountSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text('Total Amount:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('LE 500.00', style: TextStyle(color: Color(0xFF01B5C5), fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to PaymentSuccessPage (payment_done.dart) when Check Out button is pressed
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PaymentSuccessPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 24, 41, 125),
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: const Text(
        'Check Out',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (text.length == 1 && int.tryParse(text[0])! > 1) {
      text = '0$text';
    }
    if (text.length == 2 && oldValue.text.length < newValue.text.length) {
      text += '/';
    }
    if (text.length > 5) {
      text = text.substring(0, 5);
    }
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  final String separator;

  CardNumberInputFormatter({this.separator = ' '});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    String formatted = '';

    for (int i = 0; i < digitsOnly.length; i++) {
      if (i != 0 && i % 4 == 0) {
        formatted += separator;
      }
      formatted += digitsOnly[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

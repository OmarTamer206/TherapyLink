// Final merged CheckoutPage with updated UI and theme from first file
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/services/patient.dart';
import 'package:flutter_application_1/services/therapist.dart';
import 'payment_done.dart'; // Import the PaymentSuccessPage

class CheckoutPage extends StatefulWidget {
  final Map<String, dynamic> doctorData;
  DateTime selectedDate ;
  String selectedTime;
   CheckoutPage({super.key , required this.doctorData ,required this.selectedDate,required this.selectedTime});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _selectedType = 'Voice / Video Call';
  String _selectedDuration = '1 hour';
  final _appointmentTypes = ['Voice / Video Call', 'Chatting'];
  
  var doctor_id;
  var date ;
  var time ;
  var finalTimestamp;

  double multipier = 1.0;
  String? basePrice ;
  double? price;

  TherapistApi _therapistApi = TherapistApi();
  PatientApi _patientApi = PatientApi();

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();

  final Color mainColor = const Color(0xFF1F2937);

    @override
  void initState() {
    super.initState();
    doctor_id = widget.doctorData["doctor_data"]["id"];
    date = widget.selectedDate;
    time = widget.selectedTime;
    basePrice = widget.doctorData["doctor_data"]["Session_price"].toString();
    price = double.parse(basePrice!) * multipier;

    print("price : $price");
    finalTimestamp = generateTimestamp(date.toString(), time);
  }


  generateTimestamp(dateStr , timeStr){
    // Parse the date in UTC, then convert to local time
    DateTime date = DateTime.parse(dateStr).toLocal();

    // Parse the time manually
    TimeOfDay time = TimeOfDay(
      hour: int.parse(timeStr.split(':')[0]) + (timeStr.contains('PM') && !timeStr.startsWith('12') ? 12 : 0) - (timeStr.contains('AM') && timeStr.startsWith('12') ? 12 : 0),
      minute: int.parse(timeStr.split(':')[1].split(' ')[0]),
    );

    // Merge into final DateTime
    DateTime finalDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    print(" Final : $finalDateTime"); // e.g., 2025-06-10 23:00:00.000 (in your local time zone)
    return finalDateTime;
  }

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
      children:  [
         CircleAvatar(
                                      radius: 24,
                                      backgroundColor: Colors.grey[300],
                                      child: ClipOval(
                                        child: (widget.doctorData['doctor_data']['profile_pic_url'] != null &&
                                                widget.doctorData['doctor_data']['profile_pic_url'].toString().isNotEmpty)
                                            ? Image.network(
                                                'http://localhost:3000/uploads/${widget.doctorData['doctor_data']['profile_pic_url']}',
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) {
                                                  return Image.asset(
                                                    'assets/images/profile png.png', // Local fallback
                                                    width: 60,
                                                    height: 60,
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              )
                                            : Image.asset(
                                                'assets/images/profile png.png', // Fallback when URL is null or empty
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
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
Widget _buildAppointmentSection() => Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Choose Type of Appointment',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      DropdownButtonFormField<String>(
        value: _selectedType,
        items: _appointmentTypes
            .map((type) => DropdownMenuItem(
                value: type, child: Text(type)))
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
            onTap: () => setState(() {
              _selectedDuration = label;
              // Update multiplier based on selection
              if (label == '30 min') multipier = 0.5;
              else if (label == '1 hour') multipier = 1.0;
              else if (label == '2 hours') multipier = 2.0;

                  price = double.parse(basePrice!) * multipier;


            }),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: selected ? mainColor : const Color(0xFFDFF0F4),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: mainColor, width: 1),
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
      const SizedBox(height: 10),
    ],
  ),
);

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
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(16),
            CardNumberInputFormatter(separator: ' '),
          ],
          decoration: const InputDecoration(
            labelText: 'Card Number',
            prefixIcon: Icon(Icons.credit_card),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _expiryController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                  LengthLimitingTextInputFormatter(5),
                  _ExpiryDateInputFormatter(),
                ],
                decoration: const InputDecoration(
                  labelText: 'MM/YY',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _cvvController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                decoration: const InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(),
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
    children:  [
      Text('Total Amount:', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('${price}', style: TextStyle(color: Color(0xFF01B5C5), fontWeight: FontWeight.bold)),
    ],
  );

  Widget _buildCheckoutButton() => ElevatedButton(
    onPressed: () async {

       if (_selectedDuration == '30 min') _selectedDuration = "30";
              else if (_selectedDuration == '1 hour') _selectedDuration = "60";
              else if (_selectedDuration == '2 hours') _selectedDuration = "120";

      Map<String, dynamic> sessionData = {
      "doctor_id": doctor_id,
      "com_type": _selectedType,
      "time": finalTimestamp.toString(),
      "type": "doctor",
      "cost": price,
      "duration": _selectedDuration,
      };

      await _patientApi.makeAppointment(sessionData);

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
    return TextEditingValue(text: text, selection: TextSelection.collapsed(offset: text.length));
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
      if (i != 0 && i % 4 == 0) formatted += separator;
      formatted += digitsOnly[i];
    }

    return TextEditingValue(text: formatted, selection: TextSelection.collapsed(offset: formatted.length));
  }
}

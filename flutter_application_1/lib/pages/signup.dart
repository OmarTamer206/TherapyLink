import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth.dart';
// Adjust import as needed

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _authApi = AuthApi();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();




  String? _selectedGender;
  String? _selectedMaritalStatus;

  // DOB dropdown selections
  int? _selectedDay;
  int? _selectedMonth;
  int? _selectedYear;

  bool _isLoading = false;
  String? _generalError;

  // Field-specific error messages
  String? _fullNameError;
  String? _dobError;
  String? _genderError;
  String? _maritalStatusError;
  String? _emailError;
  String? _phoneError;
  String? _passwordError;
  String? _confirmPasswordError;

  List<int> _years = [];
  List<int> _months = List.generate(12, (index) => index + 1);
  List<int> _days = [];

  @override
  void initState() {
    super.initState();
    final currentYear = 2013;
    _years = List.generate(currentYear - 1925, (index) => currentYear - index);
  }

  void _updateDays() {
    if (_selectedYear != null && _selectedMonth != null) {
      int daysInMonth = DateTime(_selectedYear!, _selectedMonth! + 1, 0).day;
      setState(() {
        _days = List.generate(daysInMonth, (index) => index + 1);
        // Reset day if current selection invalid
        if (_selectedDay! > daysInMonth) {
          _selectedDay = null;
        }
      });
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validateInputs() {
    bool valid = true;

    setState(() {
      _fullNameError = null;
      _dobError = null;
      _genderError = null;
      _maritalStatusError = null;
      _emailError = null;
      _phoneError = null;
      _passwordError = null;
      _confirmPasswordError = null;
      _generalError = null;
    });

    if (_fullNameController.text.trim().isEmpty) {
      _fullNameError = 'Full Name cannot be empty';
      valid = false;
    }

    if (_selectedDay == null || _selectedMonth == null || _selectedYear == null) {
      _dobError = 'Please select your full date of birth';
      valid = false;
    }

    if (_selectedGender == null) {
      _genderError = 'Please select a gender';
      valid = false;
    }

    if (_selectedMaritalStatus == null) {
      _maritalStatusError = 'Please select marital status';
      valid = false;
    }

    if (_emailController.text.trim().isEmpty) {
      _emailError = 'Email cannot be empty';
      valid = false;
    } else if (!_isValidEmail(_emailController.text.trim())) {
      _emailError = 'Invalid email format';
      valid = false;
    }

      final phone = _phoneController.text.trim();
  if (phone.isEmpty) {
    _phoneError = 'Phone Number cannot be empty';
    valid = false;
  } else if (!RegExp(r'^01[0125][0-9]{8}$').hasMatch(phone)) {
    _phoneError = 'Invalid Egyptian phone number';
    valid = false;
  }

    if (_passwordController.text.isEmpty) {
      _passwordError = 'Password cannot be empty';
      valid = false;
    }

    if (_confirmPasswordController.text.isEmpty) {
      _confirmPasswordError = 'Confirm your password';
      valid = false;
    } else if (_passwordController.text != _confirmPasswordController.text) {
      _confirmPasswordError = 'Passwords do not match';
      valid = false;
    }

    setState(() {});
    return valid;
  }

  bool _isValidEmail(String email) {
  final regex = RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    return regex.hasMatch(email);
  }

  Future<void> _handleSignUp() async {
    if (!_validateInputs()) return;

    setState(() {
      _isLoading = true;
      _generalError = null;
    });

   
      String emailExists = await _authApi.checkEmail(_emailController.text.trim());

    if (emailExists == "taken") {
      setState(() {
        _emailError = 'Email is already registered';
        _isLoading = false;
      });
      return;
    }
    

    final dobString = '${_selectedYear!.toString().padLeft(4, '0')}-'
        '${_selectedMonth!.toString().padLeft(2, '0')}-'
        '${_selectedDay!.toString().padLeft(2, '0')}';

    final userData = {
      'name': _fullNameController.text.trim(),
      'Gender': _selectedGender,
      'Date_Of_Birth': dobString,
      'Marital_Status': _selectedMaritalStatus,
      'email': _emailController.text.trim(),
      'phone_number': _phoneController.text.trim(),
      'password': _passwordController.text,
    };

    final success = await _authApi.registerPatient(userData);

    setState(() {
      _isLoading = false;
    });

    if (success) {
      Navigator.pop(context);
    } else {
      setState(() {
        _generalError = 'Sign Up failed. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/therapy.png', height: 60),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  '"Find the support you need, connect with the right therapist, and start your journey toward healing because everyone deserves a safe space to talk."',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'ScriptMTBold',
                    color: Color(0xFF0891B2),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    shadows: [
                      Shadow(blurRadius: 4, color: Colors.black26, offset: Offset(2, 2)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              _buildInputField(controller: _fullNameController, hint: 'Full Name', errorText: _fullNameError),
              const SizedBox(height: 12),

              _buildGenderDropdown(errorText: _genderError),
              const SizedBox(height: 12),

              // DOB dropdowns
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildDropdown<int>(
                          value: _selectedDay,
                          hint: 'Day',
                          items: _daysInMonth(),
                          onChanged: (val) => setState(() => _selectedDay = val),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildDropdown<int>(
                          value: _selectedMonth,
                          hint: 'Month',
                          items: _months,
                          onChanged: (val) {
                            setState(() {
                              _selectedMonth = val;
                              // Reset day when month changes
                              _selectedDay = null;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildDropdown<int>(
                          value: _selectedYear,
                          hint: 'Year',
                          items: _years,
                          onChanged: (val) {
                            setState(() {
                              _selectedYear = val;
                              // Reset day when year changes (for leap year)
                              _selectedDay = null;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  if (_dobError != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 12, top: 4),
                      child: Text(_dobError!, style: const TextStyle(color: Colors.red, fontSize: 12)),
                    ),
                ],
              ),
              const SizedBox(height: 12),

              _buildMaritalStatusDropdown(errorText: _maritalStatusError),
              const SizedBox(height: 12),

              _buildInputField(controller: _emailController, hint: 'Email', keyboardType: TextInputType.emailAddress, errorText: _emailError),
              const SizedBox(height: 12),

              _buildInputField(controller: _phoneController, hint: 'Phone Number', keyboardType: TextInputType.phone, errorText: _phoneError),
              const SizedBox(height: 12),

              _buildInputField(controller: _passwordController, hint: 'Password', obscureText: true, errorText: _passwordError),
              const SizedBox(height: 12),

              _buildInputField(controller: _confirmPasswordController, hint: 'Confirm Password', obscureText: true, errorText: _confirmPasswordError),
              const SizedBox(height: 24),

              if (_generalError != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(_generalError!, style: const TextStyle(color: Colors.red)),
                ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F2937),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text('Sign Up', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? ', style: TextStyle(fontSize: 14, color: Colors.black87)),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text('Log In', style: TextStyle(fontSize: 14, color: Color(0xFF0891B2), fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to generate days in selected month/year, or default 31
  List<int> _daysInMonth() {
    if (_selectedYear != null && _selectedMonth != null) {
      return List.generate(DateTime(_selectedYear!, _selectedMonth! + 1, 0).day, (i) => i + 1);
    }
    return List.generate(31, (i) => i + 1);
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? errorText,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(),
        errorText: errorText,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required T? value,
    required String hint,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      hint: Text(hint),
      items: items
          .map((item) => DropdownMenuItem<T>(
                value: item,
                child: Text(item.toString()),
              ))
          .toList(),
      onChanged: onChanged,
      decoration: const InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }

  Widget _buildGenderDropdown({String? errorText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: DropdownButtonFormField<String>(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: const InputDecoration(border: InputBorder.none),
            hint: const Text('Gender'),
            value: _selectedGender,
            items: const [
              DropdownMenuItem(value: 'Male', child: Text('Male')),
              DropdownMenuItem(value: 'Female', child: Text('Female')),
            ],
            onChanged: (val) => setState(() => _selectedGender = val),
          ),
        ),
        if (errorText != null)
          Padding(padding: const EdgeInsets.only(left: 12, top: 4), child: Text(errorText, style: const TextStyle(color: Colors.red, fontSize: 12))),
      ],
    );
  }

  Widget _buildMaritalStatusDropdown({String? errorText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(border: InputBorder.none),
            hint: const Text('Marital Status'),
            value: _selectedMaritalStatus,
            items: const [
              DropdownMenuItem(value: 'Single', child: Text('Single')),
              DropdownMenuItem(value: 'Married', child: Text('Married')),
              DropdownMenuItem(value: 'Divorced', child: Text('Divorced')),
              DropdownMenuItem(value: 'Widowed', child: Text('Widowed')),
            ],
            onChanged: (val) => setState(() => _selectedMaritalStatus = val),
          ),
        ),
        if (errorText != null)
          Padding(padding: const EdgeInsets.only(left: 12, top: 4), child: Text(errorText, style: const TextStyle(color: Colors.red, fontSize: 12))),
      ],
    );
  }
}

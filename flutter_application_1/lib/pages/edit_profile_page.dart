// Updated EditProfilePage
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:flutter_application_1/services/patient.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final PatientApi _patientApi = PatientApi();
  final AuthApi _authApi = AuthApi();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _selectedGender;
  String? _selectedMaritalStatus;
  String? _oldEmailController ;
  var id ;


  int? _selectedDay;
  int? _selectedMonth;
  int? _selectedYear;

  bool _loading = true;
  String? _patientPhoto;

  List<int> _years = [];
  List<int> _months = List.generate(12, (index) => index + 1);
  List<int> _days = [];

  // Validation errors
  String? _nameError;
  String? _dobError;
  String? _genderError;
  String? _maritalError;
  String? _emailError;
  String? _phoneError;
  String? _passwordError;
  String? _confirmPasswordError;
  String?  _generalError;

  @override
  void initState() {
    super.initState();
    final currentYear = DateTime.now().year;
    _years = List.generate(currentYear - 1925, (index) => currentYear - index);
    _fetchData();
  }

  Future<void> _fetchData() async {
    final userData = await _patientApi.getProfileData();
    final patient = userData["data"]["patient"][0];

    setState(() {
      id = patient["id"];
      _nameController.text = patient["Name"] ?? "";
      _emailController.text = patient["Email"] ?? "";
      _oldEmailController = patient["Email"] ?? "";
      _phoneController.text = patient["phone_number"] ?? "";
      _selectedGender = patient["Gender"];
      _selectedMaritalStatus = patient["Marital_Status"];
      if (patient["Date_Of_Birth"] != null) {
        String dateOnly = patient["Date_Of_Birth"].split('T')[0];
        final dobParts = dateOnly.split("-");
        _selectedYear = int.tryParse(dobParts[0]);
        _selectedMonth = int.tryParse(dobParts[1]);
        _selectedDay = int.tryParse(dobParts[2]);
        _updateDays();
      }
      if (patient["Profile_pic_url"] != null) {
        _patientPhoto = "http://localhost:3000/uploads/${patient["Profile_pic_url"]}";
      }
      _loading = false;
    });
  }

  void _updateDays() {
    if (_selectedYear != null && _selectedMonth != null) {
      int daysInMonth = DateTime(_selectedYear!, _selectedMonth! + 1, 0).day;
      setState(() {
        _days = List.generate(daysInMonth, (index) => index + 1);
        if (_selectedDay != null && _selectedDay! > daysInMonth) {
          _selectedDay = null;
        }
      });
    }
  }

  bool _validateInputs() {
    bool valid = true;
    setState(() {
      _nameError = _nameController.text.trim().isEmpty ? 'Name cannot be empty' : null;
      _dobError = (_selectedDay == null || _selectedMonth == null || _selectedYear == null)
          ? 'Please select your full date of birth'
          : null;
      _genderError = _selectedGender == null ? 'Please select a gender' : null;
      _maritalError = _selectedMaritalStatus == null ? 'Please select marital status' : null;
      _emailError = _emailController.text.trim().isEmpty
          ? 'Email cannot be empty'
          : (!_isValidEmail(_emailController.text.trim()) ? 'Invalid email format' : null);
      _phoneError = _phoneController.text.trim().isEmpty ? 'Phone Number cannot be empty' : null;
     if(!_passwordController.text.isEmpty || !_confirmPasswordController.text.isEmpty){
       _passwordError = _passwordController.text.isEmpty ? 'Password cannot be empty' : null;
      _confirmPasswordError = _confirmPasswordController.text.isEmpty
          ? 'Confirm your password'
          : (_passwordController.text != _confirmPasswordController.text
              ? 'Passwords do not match'
              : null);
     }
    });
    return [_nameError, _dobError, _genderError, _maritalError, _emailError, _phoneError, _passwordError, _confirmPasswordError]
        .every((e) => e == null);
  }

  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    return regex.hasMatch(email);
  }

  void _handleConfirm() async {
    if (!_validateInputs()) return;

    setState(() {
      _loading = true;
      _generalError = null;
    });

     if(_emailController.text != _oldEmailController){
      String emailExists = await _authApi.checkEmail(_emailController.text.trim());

    if (emailExists == "taken") {
      setState(() {
        _emailError = 'Email is already registered';
        _loading = false;
      });
      return;
    }
    }

    final dobString = '${_selectedYear!.toString().padLeft(4, '0')}-'
        '${_selectedMonth!.toString().padLeft(2, '0')}-'
        '${_selectedDay!.toString().padLeft(2, '0')}';

    var updatedData ;
    print("Results :  ${_passwordController.text.isEmpty}" );
    if(_passwordController.text.isEmpty){
      updatedData = {
      "id" :  id ,
      "name": _nameController.text.trim(),
      "Date_Of_Birth": dobString,
      "Gender": _selectedGender,
      "Marital_Status": _selectedMaritalStatus,
      "email": _emailController.text.trim(),
      "phone_number": _phoneController.text.trim(),
      "password": "",

    };
    }
    else{

    updatedData = {
      "name": _nameController.text.trim(),
      "Date_Of_Birth": dobString,
      "Gender": _selectedGender,
      "Marital_Status": _selectedMaritalStatus,
      "email": _emailController.text.trim(),
      "phone_number": _phoneController.text.trim(),
      "password": _passwordController.text,
    };
    }
    print(updatedData);
    var result = await _authApi.updatePatient(updatedData);
    print(result);

                Navigator.pop(context,true); // Handles the back button
 // Here you'd call your API to update the profile
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F3F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text('Edit Profile', style: TextStyle(color: Color(0xFF1F2937), fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  if (_patientPhoto != null)
                    CircleAvatar(radius: 50, backgroundImage: NetworkImage(_patientPhoto!)),
                  const SizedBox(height: 20),
                  _buildTextField(_nameController, 'Name', _nameError),
                  _buildDOBSection(),
                  _buildDropdownField('Gender', _selectedGender, ['Male', 'Female'], (val) => setState(() => _selectedGender = val), _genderError),
                  _buildDropdownField('Marital Status', _selectedMaritalStatus,
                      ['Single', 'Married', 'Divorced', 'Widowed'], (val) => setState(() => _selectedMaritalStatus = val), _maritalError),
                  _buildTextField(_emailController, 'Email', _emailError, keyboardType: TextInputType.emailAddress),
                  _buildTextField(_phoneController, 'Phone Number', _phoneError, keyboardType: TextInputType.phone),
                  _buildTextField(_passwordController, 'Password', _passwordError, obscureText: true),
                  _buildTextField(_confirmPasswordController, 'Confirm Password', _confirmPasswordError, obscureText: true),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _handleConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F2937),
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Confirm', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  )
                ],
              ),
            ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, String? errorText,
      {bool obscureText = false, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          errorText: errorText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String hint, String? value, List<String> options, ValueChanged<String?> onChanged, String? errorText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: value,
        hint: Text(hint),
        items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          errorText: errorText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _buildDOBSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildDOBDropdown(_selectedDay, 'Day', _days, (val) => setState(() => _selectedDay = val)),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildDOBDropdown(_selectedMonth, 'Month', _months, (val) {
                setState(() {
                  _selectedMonth = val;
                  _updateDays();
                });
              }),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildDOBDropdown(_selectedYear, 'Year', _years, (val) {
                setState(() {
                  _selectedYear = val;
                  _updateDays();
                });
              }),
            ),
          ],
        ),
        if (_dobError != null)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 4),
            child: Text(_dobError!, style: const TextStyle(color: Colors.red, fontSize: 12)),
          ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildDOBDropdown<T>(T? value, String hint, List<T> items, ValueChanged<T?> onChanged) {
    return DropdownButtonFormField<T>(
      value: value,
      hint: Text(hint),
      items: items.map((e) => DropdownMenuItem<T>(value: e, child: Text(e.toString()))).toList(),
      onChanged: onChanged,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide.none),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }
}

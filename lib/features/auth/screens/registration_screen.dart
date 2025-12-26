import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  
  // Form Controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  
  String? _gender;
  String? _selectedVehicleType;
  
  final List<String> _genderOptions = ['Male', 'Female', 'Other'];
  final List<String> _vehicleTypes = [
    'Motorcycle',
    'Car',
    'Auto Rickshaw',
    'Mini Truck',
    'Truck'
  ];
  
  final List<String> _steps = [
    'Personal',
    'Address',
    'Aadhar/PAN',
    'Vehicle',
    'Documents'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Registration',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Progress Bar
          _buildProgressBar(),
          
          // Step Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getStepTitle(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'Step ${_currentStep + 1}/5',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          
          // Page View for Steps
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentStep = index;
                });
              },
              children: [
                // Step 1: Personal Information
                _buildPersonalInfoStep(),
                
                // Step 2: Address
                _buildAddressStep(),
                
                // Step 3: Aadhar & PAN
                _buildAadharPanStep(),
                
                // Step 4: Vehicle Type
                _buildVehicleStep(),
                
                // Step 5: Documents
                _buildDocumentsStep(),
              ],
            ),
          ),
          
          // Navigation Buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _goToPreviousStep,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: AppColors.primary),
                      ),
                      child: Text(
                        'Back',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _goToNextStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _currentStep == 4 ? 'Submit' : 'Next',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          // Step Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              return Column(
                children: [
                  Text(
                    step,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: index <= _currentStep 
                          ? AppColors.primary 
                          : Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Step Indicator
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index <= _currentStep 
                          ? AppColors.primary 
                          : Colors.grey.shade300,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
          
          // Progress Line
          const SizedBox(height: 4),
          Stack(
            children: [
              Container(
                height: 2,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 2,
                width: MediaQuery.of(context).size.width * ((_currentStep + 1) / 5) - 48,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0: return 'Personal Information';
      case 1: return 'Address Details';
      case 2: return 'Aadhar & PAN';
      case 3: return 'Vehicle Type';
      case 4: return 'Upload Documents';
      default: return '';
    }
  }

  // Step 1: Personal Information
  Widget _buildPersonalInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Profile Image Upload
          GestureDetector(
            onTap: () {
              // Handle image upload
            },
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  // Placeholder for profile image (centered)
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withOpacity(0.1),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Upload Profile Photo',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          
          // First Name
          _buildTextField(
            controller: _firstNameController,
            label: 'First Name',
            hintText: 'Enter your first name',
            prefixIcon: Icons.person_outline,
          ),
          const SizedBox(height: 16),
          
          // Last Name
          _buildTextField(
            controller: _lastNameController,
            label: 'Last Name',
            hintText: 'Enter your last name',
            prefixIcon: Icons.person_outline,
          ),
          const SizedBox(height: 16),
          
          // Date of Birth
          _buildTextField(
            controller: _dateOfBirthController,
            label: 'Date of Birth',
            hintText: 'DD/MM/YYYY',
            prefixIcon: Icons.calendar_today,
            readOnly: true,
            onTap: () {
              _selectDate();
            },
          ),
          const SizedBox(height: 16),
          
          // Gender
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gender',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                 
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _genderOptions.map((gender) {
                  final isSelected = _gender == gender;
                  return ChoiceChip(
                    label: Text(gender),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _gender = selected ? gender : null;
                      });
                    },
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Step 2: Address
  Widget _buildAddressStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _buildTextField(
            controller: _stateController,
            label: 'State',
            hintText: 'Enter your state',
            prefixIcon: Icons.location_on_outlined,
          ),
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: _districtController,
            label: 'District',
            hintText: 'Enter your district',
            prefixIcon: Icons.location_city_outlined,
          ),
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: _addressController,
            label: 'Address',
            hintText: 'Enter your full address',
            prefixIcon: Icons.home_outlined,
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          
          _buildTextField(
            controller: _pincodeController,
            label: 'Pincode',
            hintText: 'Enter 6-digit pincode',
            prefixIcon: Icons.pin_drop_outlined,
            keyboardType: TextInputType.number,
            maxLength: 6,
          ),
        ],
      ),
    );
  }

  // Step 3: Aadhar & PAN
  Widget _buildAadharPanStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Aadhar Number
          _buildTextField(
            controller: _aadharController,
            label: 'Aadhar Number',
            hintText: 'Enter 12-digit Aadhar number',
            prefixIcon: Icons.credit_card_outlined,
            keyboardType: TextInputType.number,
            maxLength: 12,
          ),
          const SizedBox(height: 16),
          
          // Aadhar Upload
          _buildUploadCard(
            title: 'Upload Aadhar Card',
            subtitle: 'Front & Back (Max 2MB)',
            onUpload: () {
              // Handle Aadhar upload
            },
          ),
          const SizedBox(height: 24),
          
          // PAN Number
          _buildTextField(
            controller: _panController,
            label: 'PAN Number',
            hintText: 'Enter PAN number',
            prefixIcon: Icons.card_membership_outlined,
            maxLength: 10,
          ),
          const SizedBox(height: 16),
          
          // PAN Upload
          _buildUploadCard(
            title: 'Upload PAN Card',
            subtitle: 'Clear image (Max 2MB)',
            onUpload: () {
              // Handle PAN upload
            },
          ),
        ],
      ),
    );
  }

  // Step 4: Vehicle Type
  Widget _buildVehicleStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Your Vehicle Type',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose the vehicle you will be using',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          
          // Vehicle Type Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: _vehicleTypes.length,
            itemBuilder: (context, index) {
              final vehicle = _vehicleTypes[index];
              final isSelected = _selectedVehicleType == vehicle;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedVehicleType = vehicle;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getVehicleIcon(vehicle),
                        size: 32,
                        color: isSelected ? AppColors.primary : Colors.grey.shade600,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        vehicle,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? AppColors.primary : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Step 5: Documents
  Widget _buildDocumentsStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _buildDocumentUploadCard(
            title: 'Driving Licence',
            subtitle: 'Upload front & back side',
            onUpload: () {
              // Handle DL upload
            },
          ),
          const SizedBox(height: 16),
          
          _buildDocumentUploadCard(
            title: 'Vehicle RC',
            subtitle: 'Upload Registration Certificate',
            onUpload: () {
              // Handle RC upload
            },
          ),
          const SizedBox(height: 16),
          
          _buildDocumentUploadCard(
            title: 'Insurance',
            subtitle: 'Upload valid insurance document',
            onUpload: () {
              // Handle Insurance upload
            },
          ),
          const SizedBox(height: 16),
          
          _buildDocumentUploadCard(
            title: 'Vehicle Photo',
            subtitle: 'Upload clear vehicle photos',
            onUpload: () {
              // Handle Vehicle photo upload
            },
          ),
          const SizedBox(height: 24),
          
          // Terms & Conditions
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: false,
                onChanged: (value) {},
                activeColor: AppColors.primary,
              ),
              Expanded(
                child: Text(
                  'I agree to the Terms & Conditions and confirm that all information provided is accurate.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper Widgets
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    required IconData prefixIcon,
    bool readOnly = false,
    int maxLines = 1,
    TextInputType? keyboardType,
    int? maxLength,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: readOnly,
          maxLines: maxLines,
          keyboardType: keyboardType,
          maxLength: maxLength,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(prefixIcon, color: Colors.grey.shade600),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            counterText: '',
          ),
        ),
      ],
    );
  }

  Widget _buildUploadCard({
    required String title,
    required String subtitle,
    required VoidCallback onUpload,
  }) {
    return GestureDetector(
      onTap: onUpload,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.upload_file,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentUploadCard({
    required String title,
    required String subtitle,
    required VoidCallback onUpload,
  }) {
    return GestureDetector(
      onTap: onUpload,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.description_outlined,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Upload',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Methods
  IconData _getVehicleIcon(String vehicle) {
    switch (vehicle) {
      case 'Motorcycle': return Icons.motorcycle;
      case 'Car': return Icons.directions_car;
      case 'Auto Rickshaw': return Icons.moped;
      case 'Mini Truck': return Icons.local_shipping;
      case 'Truck': return Icons.fire_truck;
      default: return Icons.directions_car;
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _dateOfBirthController.text = '${picked.day}/${picked.month}/${picked.year}';
    }
  }

  void _goToNextStep() {
    if (_currentStep < 4) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Submit form
      _submitForm();
    }
  }

  void _goToPreviousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _submitForm() async {
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('user_role');
    print('User role from prefs: $role');

    // Handle form submission
    print('Form Submitted');
    print('Name: ${_firstNameController.text} ${_lastNameController.text}');
    print('Vehicle Type: $_selectedVehicleType');
    
    // Show success dialog or navigate
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registration Submitted'),
        content: const Text('Your registration has been submitted successfully. We will contact you soon.'),
        actions: [
          TextButton(
            onPressed: () {
              context.pop(); // Close dialog
              if (role == 'rider') {
                context.go('/home');
              } else if (role == 'porter') {
                context.go('/porter-dashboard');
              } else {
                // fallback (safety)
                context.go('/login');
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dateOfBirthController.dispose();
    _stateController.dispose();
    _districtController.dispose();
    _addressController.dispose();
    _pincodeController.dispose();
    _aadharController.dispose();
    _panController.dispose();
    super.dispose();
  }
}
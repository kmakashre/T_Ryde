import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 🔹 APP BAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.headset_mic, color: Colors.black),
              label: const Text(
                'Help',
                style: TextStyle(color: Colors.black),
              ),
            ),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 20),

            // // 🔹 ICON
            // Center(
            //   child: CircleAvatar(
            //     radius: 36,
            //     backgroundColor: AppColors.primary.withValues(alpha: 0.5),
            //     child: const Icon(Icons.phone_sharp, size: 36),
            //   ),
            // ),

            // const SizedBox(height: 24),

            Row(
              children: [
                CircleAvatar(
                radius: 20,
                // backgroundColor: AppColors.primary.withValues(alpha: 0.5),
                child: const Icon(Icons.phone_sharp, size: 20),
              ),
              const SizedBox(width: 12),
                            const Text(
              'Enter your Phone Number',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
              ],
            ),



            const SizedBox(height: 20),

            // 🔹 PHONE FIELD (Uber style)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const Text(
                    '+91',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        hintText: 'Phone number',
                        border: InputBorder.none,
                        
                        counterText: '',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // 🔹 TERMS
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: _acceptTerms,
                      onChanged: (v) => setState(() => _acceptTerms = v!),
                    ),
                    const Text('Please read our '),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Terms and conditions',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // 🔹 CHANGE NUMBER
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Change registered number',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // 🔹 PROCEED
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_acceptTerms) {
                        context.push('/otp', extra: _phoneController.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Proceed',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
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

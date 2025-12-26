// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
// import 'package:tryde_partner/core/constants/color_constants.dart';

// class LanguageSelectionScreen extends StatefulWidget {
//   const LanguageSelectionScreen({super.key});

//   @override
//   State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
// }

// class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
//   String _selectedLanguage = 'en'; // Default: English (from screenshot)

//   // Language data: code, name, script sample
//   final List<Map<String, String>> _languages = [
//     {'code': 'en', 'name': 'English', 'script': 'Aa'},
//     {'code': 'hi', 'name': 'हिंदी', 'script': 'हिंदी'},
//     {'code': 'mr', 'name': 'मराठी', 'script': 'मराठी'},
//     {'code': 'kn', 'name': 'ಕನ್ನಡ', 'script': 'ಕನ್ನಡ'},
//     {'code': 'ta', 'name': 'தமிழ்', 'script': 'தமிழ்'},
//     {'code': 'te', 'name': 'తెలుగు', 'script': 'తెలుగు'},
//     {'code': 'ml', 'name': 'മലയാളം', 'script': 'മലയാളം'},
//     {'code': 'bn', 'name': 'বাংলা', 'script': 'বাংলা'},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // Load saved language from Provider
//     // final provider = Provider.of<AppProvider>(context, listen: false);
//     // _selectedLanguage = provider.currentLanguage;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => context.pop(),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const Text(
//           'Select a language to continue',
//           style: TextStyle(
//             color: AppColors.textPrimary,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           // Language Grid
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 1.2,
//                   crossAxisSpacing: 16,
//                   mainAxisSpacing: 16,
//                 ),
//                 itemCount: _languages.length,
//                 itemBuilder: (context, index) {
//                   final lang = _languages[index];
//                   final isSelected = _selectedLanguage == lang['code'];
//                   return GestureDetector(
//                     onTap: () => setState(() {
//                       _selectedLanguage = lang['code']!;
//                     }),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(
//                           color: isSelected ? AppColors.primary : Colors.grey.shade200,
//                           width: isSelected ? 2 : 1,
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           // Radio Button
//                           Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: isSelected ? AppColors.primary : Colors.transparent,
//                               border: Border.all(
//                                 color: isSelected ? AppColors.primary : Colors.grey,
//                               ),
//                             ),
//                             child: Icon(
//                               Icons.radio_button_checked,
//                               size: isSelected ? 20 : 0,
//                               color: Colors.white,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           // Script Sample
//                           Text(
//                             lang['script']!,
//                             style: const TextStyle(
//                               fontSize: 32,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           // Language Name
//                           Text(
//                             lang['name']!,
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           // Confirm Button
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: () {
//                   context.push('/login');
//                   // Save to Provider
//                   // final provider = Provider.of<AppProvider>(context, listen: false);
//                   // provider.setLanguage(_selectedLanguage);
//                   // // Navigate to next (Service Provider Selection)
//                   // context.pushReplacement(AppConstants.routeServiceProvider); // Add this route if needed
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primary,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                   elevation: 2,
//                 ),
//                 child: const Text(
//                   'Confirm',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguage = 'en';

  // Language data updated as per screenshot
final List<Map<String, String>> _languages = [
  {'code': 'en', 'name': 'English', 'script': 'English'},

  {'code': 'hi', 'name': 'Hindi', 'script': 'हिंदी'},
  {'code': 'bn', 'name': 'Bengali', 'script': 'বাংলা'},
  {'code': 'mr', 'name': 'Marathi', 'script': 'मराठी'},
  {'code': 'te', 'name': 'Telugu', 'script': 'తెలుగు'},
  {'code': 'ta', 'name': 'Tamil', 'script': 'தமிழ்'},
  {'code': 'ur', 'name': 'Urdu', 'script': 'اردو'},
  {'code': 'gu', 'name': 'Gujarati', 'script': 'ગુજરાતી'},
  {'code': 'kn', 'name': 'Kannada', 'script': 'ಕನ್ನಡ'},
  {'code': 'ml', 'name': 'Malayalam', 'script': 'മലയാളം'},
  {'code': 'or', 'name': 'Odia', 'script': 'ଓଡ଼ିଆ'},
  {'code': 'pa', 'name': 'Punjabi', 'script': 'ਪੰਜਾਬੀ'},
  {'code': 'as', 'name': 'Assamese', 'script': 'অসমীয়া'},
  {'code': 'mai', 'name': 'Maithili', 'script': 'मैथिली'},
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
        title: const Text(
          'Select a language to continue',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Language Grid - 2x2 layout
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.8, // Adjusted for better proportions
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _languages.length,
                itemBuilder: (context, index) {
                  final lang = _languages[index];
                  final isSelected = _selectedLanguage == lang['code'];
                  return GestureDetector(
                    onTap: () => setState(() {
                      _selectedLanguage = lang['code']!;
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : Colors.grey.shade300,
                          width: isSelected ? 1.5 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            // Radio button on left (screenshot style)
                            Container(
                              width: 24,
                              height: 24,
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? AppColors.primary : Colors.grey.shade400,
                                  width: 2,
                                ),
                              ),
                              child: isSelected
                                  ? Center(
                                      child: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            
                            // Language content on right
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Large script text (as shown in screenshot)
                                  Text(
                                    lang['script']!,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                      height: 1.2,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  
                                  const SizedBox(height: 4),
                                  
                                  // Language name in English
                                  Text(
                                    lang['name']!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.textSecondary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Check icon for selected item
                            if (isSelected)
                              Icon(
                                Icons.check,
                                color: AppColors.primary,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          // Confirm Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  context.push('/role-selection');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
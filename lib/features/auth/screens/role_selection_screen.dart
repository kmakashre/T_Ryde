// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:tryde_partner/core/constants/color_constants.dart';

// class PartnerTypeSelectionScreen extends StatefulWidget {
//   const PartnerTypeSelectionScreen({super.key});

//   @override
//   State<PartnerTypeSelectionScreen> createState() => _PartnerTypeSelectionScreenState();
// }

// class _PartnerTypeSelectionScreenState extends State<PartnerTypeSelectionScreen> {
//   String? _selectedPartnerType;

//   final List<Map<String, dynamic>> _partnerTypes = [
//     {
//       'id': 'rider',
//       'title': 'Rider\nPartner',
//       'subtitle': 'Drive with Tryde',
//       'icon': Icons.directions_car_rounded,
//       'color': Color(0xFF2196F3),
//       'bgColor': Color(0xFFE3F2FD),
//     },
//     {
//       'id': 'porter',
//       'title': 'Porter\nPartner',
//       'subtitle': 'Deliver with Tryde',
//       'icon': Icons.local_shipping_rounded,
//       'color': Color(0xFFFF9800),
//       'bgColor': Color(0xFFFFF3E0),
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final cardSize = (screenWidth - 72) / 2; // 24*3 padding

//     return Scaffold(
//       backgroundColor: AppColors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Header with back button
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(color: Colors.grey.shade200),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () => context.pop(),
//                     child: Container(
//                       width: 40,
//                       height: 40,
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade100,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: const Icon(
//                         Icons.arrow_back,
//                         color: Colors.black,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Text(
//                     'Login as',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimary,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
//                 child: Column(
//                   children: [
//                     // Title
//                     Text(
//                       'Select your partner type',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.w700,
//                         color: AppColors.textPrimary,
//                       ),
//                     ),
                    
//                     const SizedBox(height: 8),
                    
//                     Text(
//                       'Choose how you want to earn with Tryde',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 15,
//                         color: AppColors.textSecondary,
//                       ),
//                     ),
                    
//                     const SizedBox(height: 40),
                    
//                     // Grid Cards
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: _partnerTypes.map((type) {
//                         final isSelected = _selectedPartnerType == type['id'];
                        
//                         return GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               _selectedPartnerType = type['id'];
//                             });
//                           },
//                           child: Container(
//                             width: 150,
//                             height: 210,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(16),
//                               border: Border.all(
//                                 color: isSelected ? type['color'] : Colors.grey.shade300,
//                                 width: isSelected ? 2 : 1,
//                               ),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.05),
//                                   blurRadius: 10,
//                                   offset: const Offset(0, 4),
//                                 ),
//                               ],
//                             ),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 // Icon
//                                 Container(
//                                   width: 70,
//                                   height: 70,
//                                   decoration: BoxDecoration(
//                                     color: type['bgColor'],
//                                     borderRadius: BorderRadius.circular(35),
//                                   ),
//                                   child: Icon(
//                                     type['icon'],
//                                     size: 36,
//                                     color: type['color'],
//                                   ),
//                                 ),
                                
//                                 const SizedBox(height: 16),
                                
//                                 // Title
//                                 Text(
//                                   type['title'],
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     color: type['color'],
//                                     height: 1.2,
//                                   ),
//                                 ),
                                
//                                 const SizedBox(height: 4),
                                
//                                 // Subtitle
//                                 Text(
//                                   type['subtitle'],
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: AppColors.textSecondary,
//                                   ),
//                                 ),
                                
//                                 const SizedBox(height: 8),
                                
//                                 // Check icon
//                                 if (isSelected)
//                                   Icon(
//                                     Icons.check_circle,
//                                     color: type['color'],
//                                     size: 20,
//                                   ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
                    
//                     const SizedBox(height: 40),
                    
//                     // Description
//                     Container(
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: AppColors.primary.withOpacity(0.05),
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(
//                           color: AppColors.primary.withOpacity(0.1),
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.info_outline,
//                                 color: AppColors.primary,
//                                 size: 20,
//                               ),
//                               const SizedBox(width: 8),
//                               Text(
//                                 'What you\'ll get',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                   color: AppColors.primary,
//                                 ),
//                               ),
//                             ],
//                           ),
                          
//                           const SizedBox(height: 12),
                          
//                           _buildFeatureItem('Flexible working hours'),
//                           _buildFeatureItem('Weekly payments'),
//                           _buildFeatureItem('24/7 support'),
//                           _buildFeatureItem('Performance incentives'),
//                         ],
//                       ),
//                     ),
                    
//                     const SizedBox(height: 32),
                    
//                     // Help Text
//                     Text(
//                       'You can switch between partner types later in settings',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: AppColors.textSecondary,
//                         fontStyle: FontStyle.italic,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
            
//             // Continue Button
//             Container(
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border(
//                   top: BorderSide(color: Colors.grey.shade200),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, -4),
//                   ),
//                 ],
//               ),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: _selectedPartnerType != null
//                       ? () {
//                           // Pass partner type to login screen
//                           context.push(
//                             '/login',);
//                         }
//                       : null,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: _selectedPartnerType != null 
//                         ? AppColors.primary 
//                         : Colors.grey.shade400,
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: Text(
//                     'Continue as ${_selectedPartnerType == 'rider' ? 'Rider Partner' : _selectedPartnerType == 'porter' ? 'Porter Partner' : 'Partner'}',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFeatureItem(String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           Icon(
//             Icons.check_circle,
//             color: AppColors.primary,
//             size: 16,
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               text,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: AppColors.textSecondary,
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';

class PartnerTypeSelectionScreen extends StatefulWidget {
  const PartnerTypeSelectionScreen({super.key});

  @override
  State<PartnerTypeSelectionScreen> createState() =>
      _PartnerTypeSelectionScreenState();
}

class _PartnerTypeSelectionScreenState
    extends State<PartnerTypeSelectionScreen> {
  String? _selectedPartnerType;

  final List<Map<String, dynamic>> _partnerTypes = [
    {
      'id': 'rider',
      'title': 'Rider\nPartner',
      'subtitle': 'Drive with Tryde',
      'icon': Icons.directions_car_rounded,
      'color': Color(0xFF2196F3),
      'bgColor': Color(0xFFE3F2FD),
    },
    {
      'id': 'porter',
      'title': 'Porter\nPartner',
      'subtitle': 'Deliver with Tryde',
      'icon': Icons.local_shipping_rounded,
      'color': Color(0xFFFF9800),
      'bgColor': Color(0xFFFFF3E0),
    },
  ];

  /// SAVE ROLE
  Future<void> _saveRoleAndContinue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_role', _selectedPartnerType!);

    // Optional: future use
    await prefs.setBool('is_role_selected', true);

    context.push('/login'); // ya jo bhi next screen ho
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Login as',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            Text(
              'Select your partner type',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Choose how you want to earn with Tryde',
              style: TextStyle(color: AppColors.textSecondary),
            ),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _partnerTypes.map((type) {
                final isSelected = _selectedPartnerType == type['id'];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedPartnerType = type['id'];
                    });
                  },
                  child: Container(
                    width: 150,
                    height: 210,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color:
                            isSelected ? type['color'] : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: type['bgColor'],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            type['icon'],
                            size: 36,
                            color: type['color'],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          type['title'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: type['color'],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          type['subtitle'],
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (isSelected)
                          Icon(Icons.check_circle,
                              color: type['color'], size: 20),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed:
                    _selectedPartnerType == null ? null : _saveRoleAndContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: Colors.grey.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _selectedPartnerType == null
                      ? 'Continue'
                      : 'Continue as ${_selectedPartnerType == 'rider' ? 'Rider Partner' : 'Porter Partner'}',
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
    );
  }
}

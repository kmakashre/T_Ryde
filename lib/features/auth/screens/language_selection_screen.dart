import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tryde_partner/core/constants/color_constants.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguage = 'en';

  final List<Map<String, String>> _languages = [
    {'code': 'en', 'name': 'English', 'script': 'English'},
    {'code': 'te', 'name': 'Telugu', 'script': 'తెలుగు'},
    {'code': 'hi', 'name': 'Hindi', 'script': 'हिंदी'},
    {'code': 'ta', 'name': 'Tamil', 'script': 'தமிழ்'},
    {'code': 'kn', 'name': 'Kannada', 'script': 'ಕನ್ನಡ'},
    {'code': 'ml', 'name': 'Malayalam', 'script': 'മലയാളം'},
    {'code': 'pa', 'name': 'Punjabi', 'script': 'ਪੰਜਾਬੀ'},
  ];

  void _showAddLanguageDialog(double w) {
    final nameController = TextEditingController();
    final scriptController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            "Add Language",
            style: TextStyle(fontSize: w * 0.045),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration:
                const InputDecoration(labelText: "Language Name"),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: scriptController,
                decoration:
                const InputDecoration(labelText: "Language Script"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brownPrimary,
              ),
              onPressed: () {
                if (nameController.text.isEmpty ||
                    scriptController.text.isEmpty) return;

                setState(() {
                  final code =
                  nameController.text.toLowerCase().substring(0, 2);
                  _languages.add({
                    'code': code,
                    'name': nameController.text,
                    'script': scriptController.text,
                  });
                  _selectedLanguage = code;
                });

                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: w * 0.06),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Select a language to continue',
          style: TextStyle(
            fontSize: w * 0.045,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          /// SELECTED LANGUAGE
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              horizontal: w * 0.04,
              vertical: h * 0.01,
            ),
            padding: EdgeInsets.all(w * 0.03),
            decoration: BoxDecoration(
              color: AppColors.brownPrimary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.brownPrimary.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.language,
                    color: AppColors.brownPrimary, size: w * 0.055),
                SizedBox(width: w * 0.02),
                Text(
                  "Selected: ",
                  style: TextStyle(
                    fontSize: w * 0.035,
                    color: AppColors.textSecondary,
                  ),
                ),
                Expanded(
                  child: Text(
                    "${_languages.firstWhere((e) => e['code'] == _selectedLanguage)['script']} "
                        "(${_languages.firstWhere((e) => e['code'] == _selectedLanguage)['name']})",
                    style: TextStyle(
                      fontSize: w * 0.035,
                      fontWeight: FontWeight.w600,
                      color: AppColors.brownPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          /// LANGUAGE GRID
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(w * 0.04),
              child: GridView.builder(
                itemCount: _languages.length + 1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: w > 600 ? 3 : 2,
                  childAspectRatio: w > 600 ? 2.2 : 1.8,
                  crossAxisSpacing: w * 0.04,
                  mainAxisSpacing: w * 0.04,
                ),
                itemBuilder: (context, index) {
                  if (index == _languages.length) {
                    return GestureDetector(
                      onTap: () => _showAddLanguageDialog(w),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                          Border.all(color: Colors.grey.shade300),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_circle_outline,
                                  size: w * 0.08,
                                  color: AppColors.brownPrimary),
                              SizedBox(height: h * 0.01),
                              Text(
                                "Add Language",
                                style: TextStyle(
                                  fontSize: w * 0.035,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  final lang = _languages[index];
                  final isSelected =
                      _selectedLanguage == lang['code'];

                  return GestureDetector(
                    onTap: () =>
                        setState(() => _selectedLanguage = lang['code']!),
                    child: Container(
                      padding: EdgeInsets.all(w * 0.03),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.brownPrimary
                              : Colors.grey.shade300,
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: w * 0.06,
                            height: w * 0.06,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.brownPrimary
                                    : Colors.grey,
                                width: 2,
                              ),
                            ),
                            child: isSelected
                                ? Center(
                              child: Container(
                                width: w * 0.03,
                                height: w * 0.03,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                  AppColors.brownPrimary,
                                ),
                              ),
                            )
                                : null,
                          ),
                          SizedBox(width: w * 0.03),
                          Expanded(
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  lang['script']!,
                                  style: TextStyle(
                                    fontSize: w * 0.05,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  lang['name']!,
                                  style: TextStyle(
                                    fontSize: w * 0.032,
                                    color:
                                    AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Icon(Icons.check,
                                size: w * 0.05,
                                color:
                                AppColors.brownPrimary),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          /// CONFIRM BUTTON
          Padding(
            padding: EdgeInsets.all(w * 0.04),
            child: SizedBox(
              width: double.infinity,
              height: h * 0.065,
              child: ElevatedButton(
                onPressed: () => context.push('/role-selection'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brownPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    fontSize: w * 0.045,
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

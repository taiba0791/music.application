import 'package:flutter/material.dart';

class LanguageCardsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LanguageGridScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LanguageGridScreen extends StatefulWidget {
  @override
  _LanguageGridScreenState createState() => _LanguageGridScreenState();
}

class _LanguageGridScreenState extends State<LanguageGridScreen> {
  final List<String> languages = [
    'Hindi',
    'Marathi',
    'English',
    'Korean',
  ];

  List<String> selectedLanguages = [];

  Color _getCardColor(String language) {
    switch (language) {
      case 'Hindi':
        return Color(0xFFF38701); // Tangerine
      case 'Marathi':
        return Color(0xFFF7A400); // Orange
      case 'English':
        return Color(0xFF616D3D); // Chalet Green
      case 'Korean':
        return Color(0xFF2F4D2A); // Palm Leaf
      default:
        return Colors.white;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Which language do you prefer??',
            style: TextStyle(
              fontFamily: 'Times New Roman',
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  return LanguageCard(
                    name: languages[index],
                    backgroundColor: _getCardColor(languages[index]),
                    isSelected: selectedLanguages.contains(languages[index]),
                    onTap: () {
                      setState(() {
                        if (selectedLanguages.contains(languages[index])) {
                          selectedLanguages.remove(languages[index]);
                        } else {
                          selectedLanguages.add(languages[index]);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: selectedLanguages.isNotEmpty
                    ? () {
                  // Implement the action for the "Next" button here.
                  print('Selected Languages: $selectedLanguages');
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageCard extends StatelessWidget {
  final String name;
  final Color backgroundColor;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageCard({
    required this.name,
    required this.backgroundColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        color: isSelected ? backgroundColor.withOpacity(0.7) : backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Added padding for better layout
          child: Align(
            alignment: Alignment.bottomLeft, // Aligning text to bottom left
            child: Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24, // Increased font size
                color: Colors.white,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
    );
  }
}

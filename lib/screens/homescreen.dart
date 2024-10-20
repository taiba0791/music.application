import 'package:flutter/material.dart';

class ArtistCardsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ArtistGridScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ArtistGridScreen extends StatefulWidget {
  @override
  _ArtistGridScreenState createState() => _ArtistGridScreenState();
}

class _ArtistGridScreenState extends State<ArtistGridScreen> {
  final List<Map<String, String>> artists = [
    {'name': 'Arijit Singh', 'image': 'lib/assets/arjit-singh.png'},
    {'name': 'Shreya Ghoshal', 'image': 'lib/assets/shreya-image.png'},
    {'name': 'Sonu Nigam', 'image': 'lib/assets/sonu_nigam.png'},
    {'name': 'Udit Narayan', 'image': 'lib/assets/udit_narayan.png'},
    {'name': 'A. R. Rahman', 'image': 'lib/assets/AR_rehman.png'},
    {'name': 'KK', 'image': 'lib/assets/KK.png'},
    {'name': 'Kumar Sanu', 'image': 'lib/assets/kumar_sanu.png'},
    {'name': 'Neha Kakkar', 'image': 'lib/assets/neha_kakkar.png'},
    {'name': 'Justin Bieber', 'image': 'lib/assets/justin_bieber.png'},
    {'name': 'Taylor Swift', 'image': 'lib/assets/taylor_swift.png'},
    {'name': 'Selena Gomez', 'image': 'lib/assets/selena_gomez.png'},
    {'name': 'Ariana Grande', 'image': 'lib/assets/Ariana_grande.png'},
    {'name': 'Ed Sheeran', 'image': 'lib/assets/ed_sheeran.png'},
    {'name': 'Shawn Mendes', 'image': 'lib/assets/shawn_mendes.png'},
  ];

  List<String> selectedArtists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'who are your Favorite Artists??',
            style: TextStyle(
              fontFamily: 'Times New Roman',
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(), // Prevents the internal scroll
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: artists.length,
                  itemBuilder: (context, index) {
                    return ArtistCard(
                      name: artists[index]['name']!,
                      imagePath: artists[index]['image']!,
                      isSelected: selectedArtists.contains(artists[index]['name']!),
                      onTap: () {
                        setState(() {
                          if (selectedArtists.contains(artists[index]['name']!)) {
                            selectedArtists.remove(artists[index]['name']!);
                          } else {
                            selectedArtists.add(artists[index]['name']!);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: selectedArtists.length >= 5
                  ? () {
                // Implement the action for the "Next" button here.
                print('Selected Artists: $selectedArtists');
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
    );
  }
}

class ArtistCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const ArtistCard({
    required this.name,
    required this.imagePath,
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
        color: isSelected ? Colors.orange.withOpacity(0.5) : Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
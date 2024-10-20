import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpotifyHomeScreen extends StatefulWidget {
  @override
  _SpotifyHomeScreenState createState() => _SpotifyHomeScreenState();
}

class _SpotifyHomeScreenState extends State<SpotifyHomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    HomePage(),
    SearchPage(),
    LibraryPage(),
    MePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.orange,
            icon: Icon(Icons.home, size: 28),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.orange,
            icon: Icon(Icons.search, size: 28),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.orange,
            icon: Icon(Icons.library_music, size: 28),
            label: 'Your Library',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.orange,
            icon: Icon(Icons.person, size: 28),
            label: 'Me',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.orange, // Orange background
        elevation: 10, // Adds a shadow for better depth
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Section(title: 'To Get You Started'),
          Section(title: 'Music According to Your Mood'),
          Section(title: 'Current Hits'),
          Section(title: 'Songs from Your Favorite Artists'),
        ],
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;

  const Section({required this.title});

  @override
  Widget build(BuildContext context) {
    final cardColors = [
      Color(0xFFF38701), // Tangerine
      Color(0xFF616D3D), // Chalet Green
      Color(0xFF2F4D2A), // Palm Leaf
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    color: cardColors[index % cardColors.length],
                    child: Container(
                      width: 130,
                      child: Center(
                        child: Text(
                          'Song ${index + 1}',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(8),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Genres',
            style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 3.2,
            padding: EdgeInsets.all(8),
            children: [
              GenreCard('Pop'),
              GenreCard('Love'),
              GenreCard('Party'),
              GenreCard('Dance'),
              GenreCard('K-pop'),
            ],
          ),
        ),
      ],
    );
  }
}

class GenreCard extends StatelessWidget {
  final String genre;

  const GenreCard(this.genre);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      color: Color(0xFFF38701),
      child: Center(
        child: Text(
          genre,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class LibraryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Your Library',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Playlists',
              style: TextStyle(color: Colors.black54, fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 8, // Example number of playlists
              itemBuilder: (context, index) {
                return PlaylistCard(
                  imageUrl: 'https://via.placeholder.com/100', // Replace with actual image URL
                  playlistName: 'Playlist ${index + 1}',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PlaylistCard extends StatelessWidget {
  final String imageUrl;
  final String playlistName;

  const PlaylistCard({required this.imageUrl, required this.playlistName});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF616D3D), // Example color from your palette
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6.0), // Space between cards
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: 60, // Thumbnail size
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                playlistName,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInfoRow(label: 'Name', value: 'John Doe'),
          UserInfoRow(label: 'Gender', value: 'Male'),
          UserInfoRow(label: 'Email', value: 'john.doe@example.com'),
          UserInfoRow(label: 'Date of Birth', value: '01/01/2000'),
          UserInfoRow(label: 'Year of Joining', value: '2023'),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFF7A400),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              // Add functionality to edit user info
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Text('Edit Info', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

class UserInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const UserInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey)),
          Text(value, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

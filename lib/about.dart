import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'About',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ListView(
            children: [
              Text(
                  ''' Embark on a harmonious journey with Galaxy, an immersive music player designed to transform the way you experience your favorite tunes. Galaxy goes beyond the conventional, offering a rich array of features that cater to both the discerning audiophile and the casual music lover.

Take full control of your music with Galaxy's intuitive play, pause, and shuffle functions, ensuring that every beat and melody is at your fingertips. Seamlessly curate your musical world with personalized playlists, providing the soundtrack for every aspect of your life. The 'Recently Played' section lets you effortlessly rediscover the gems from your musical explorations, creating a dynamic connection to your evolving tastes.

Galaxy's commitment to personalization extends to the 'Favorites' section, where you can cherish and revisit the songs that strike a chord in your heart. But Galaxy is more than just a player; it's a visual experience. The home screen features a captivating scrollable image, turning your music library into a mesmerizing gallery that evolves with your collection.

What sets Galaxy apart is our dedication to the fusion of technology and artistry. We understand that music is not just heard; it's felt. That's why Galaxy is designed to be an audio-visual masterpiece, where each note is not only heard but also seen in the vibrant display of the app.

Your feedback is invaluable as we strive to make Galaxy the perfect companion on your musical odyssey. Share your thoughts, suggestions, or inquiries at adiljaz17@gmail.com. Galaxy is not just a music player; it's a symphony of your senses. Thank you for choosing Galaxy - where music meets transcendence.
              ''')
            ],
          ),
        ),
      ),
    );
  }
}

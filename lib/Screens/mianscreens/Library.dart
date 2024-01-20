import 'package:flutter/material.dart';
import 'package:galaxy/Screens/playlist.dart';
import 'package:galaxy/favorite/likedsongs.dart';
import 'package:galaxy/playlist/playlist_func.dart';
import 'package:galaxy/playlist/playlist_model.dart';
import 'package:galaxy/recently/recently.dart';
import 'package:galaxy/colors/colors.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final TextEditingController _playlistnamecontroller = TextEditingController();
  final TextEditingController _editingController = TextEditingController();

  // Permanent grid views
  List<Widget> permanentGridItems() {
    return [
      _buildPermanentGridView(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const LikedSongs(),
          ));
        },
        icon: Icons.favorite,
        color: const Color.fromARGB(255, 246, 205, 205),
      ),
      _buildPermanentGridView(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RecentlyPlayed(),
          ));
        },
        child: Column(
          children: [
            const Text(
              'Recently played ',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
              ),
            ),
            Lottie.asset('assets/rc.json'),
          ],
        ),
      ),
      // _buildPermanentGridView(
      //   onTap: () {},
      //   child: Lottie.asset('assets/an1.json'),
      // ),
    ];
  }

  Widget _buildPermanentGridView({
    required VoidCallback onTap,
    IconData? icon,
    Color? color,
    Widget? child,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color ?? Colormanager.container,
        ),
        height: 130,
        width: 130,
        child: child ?? Icon(icon, size: 70, color: Color.fromARGB(255, 255, 121, 121)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuerry = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colormanager.scaffoldcolor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: mediaQuerry.size.height * 0.2,
              width: mediaQuerry.size.width * 1,
              decoration: BoxDecoration(
                color: Colormanager.container,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 130, top: 40),
                child: Text(
                  'Library',
                  style: GoogleFonts.lato(
                    color: Colormanager.titleText,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: mediaQuerry.size.height * 0.015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your Library',
                  style: GoogleFonts.lato(
                    color: Colormanager.maintext,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: mediaQuerry.size.width * 0.43,
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colormanager.sheetcolor,
                          title: Text(
                            'Add new playlist',
                            style: TextStyle(color: Colormanager.text),
                          ),
                          actions: [
                            TextFormField(
                              controller: _playlistnamecontroller,
                              style: GoogleFonts.lato(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: Colormanager.text),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {

                                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(  backgroundColor: Colors.black,  content:  Text('New playlist added'),
                                                                                       margin:EdgeInsets.all(10), behavior: SnackBarBehavior.floating,));

                                   


                                    addPlaylist(_playlistnamecontroller.text);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Add',
                                    style: TextStyle(
                                      color: Colormanager.text,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.add_circle,
                    size: 30,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: FutureBuilder<List<Playlistmodel>>(
                  future: getallPlaylist(),
                  builder: (context, items) {
                    if (items.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (items.hasError) {
                      return Text('Error: ${items.error}');
                    } else if (!items.hasData || items.data!.isEmpty) {
                      return GridView.builder(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 20,
                        ),
                        itemBuilder: (context, index) {
                          return permanentGridItems()[index];
                        },
                        itemCount: permanentGridItems().length,
                      );
                    } else {
                      return GridView.builder(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 20,
                        ),
                        itemBuilder: (context, index) {
                          if (index < permanentGridItems().length) {
                            return permanentGridItems()[index];
                          } else {
                            final dynamicIndex = index - permanentGridItems().length;
                            final playlist = items.data![dynamicIndex];

                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Playlist(
                                      playlistId: playlist.key,
                                      playlistname: playlist.name,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colormanager.container,
                                ),                                height: mediaQuerry.size.height,
                                width: mediaQuerry.size.width,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Text(
                                              playlist.name,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: const Color.fromARGB(255, 255, 255, 255),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 40,
                                          child: PopupMenuButton(
                                            color: Colormanager.listtile,
                                            elevation: 0,
                                            icon: Icon(Icons.more_vert, color: Colors.white),
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                child: TextButton(
                                                  onPressed: () {
                                                    showDialog(context: context, builder: (context) {
                                                      return AlertDialog(
                                                        title: Text('Edit playlist', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                                        content: TextFormField(
                              controller: _editingController,
                              style: GoogleFonts.lato(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                            ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: Text('Cancel', style: TextStyle(color: Colormanager.text),), 
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                                                                                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(  backgroundColor: Colors.black,  content:  Text('new name saved '),
                                                                                       margin:EdgeInsets.all(10), behavior: SnackBarBehavior.floating,));
                                                              editPlaylistName(playlist.name, _editingController.text);
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: Text('Save', style: TextStyle(color: Colormanager.text)),
                                                          )
                                                        ],
                                                        backgroundColor: Colormanager.container,
                                                      );
                                                    });
                                                  },
                                                  child: Text(
                                                    'Edit',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              PopupMenuItem(
                                                child: TextButton(
                                                  onPressed: () {
                                                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(  backgroundColor: Color.fromARGB(255, 255, 0, 0),  content:  Text('Playlist deleted'),
                                                                                       margin:EdgeInsets.all(10), behavior: SnackBarBehavior.floating,));
                                                    Navigator.of(context).pop();
                                                    setState(() {});
                                                    deletePlaylist(playlist.name, playlist.song);
                                                  },
                                                  child: Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Lottie.asset('assets/sing.json', height: 100, width: 100, fit: BoxFit.fill),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                        itemCount: items.data!.length + permanentGridItems().length,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


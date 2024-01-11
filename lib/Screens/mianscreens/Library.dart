import 'package:flutter/material.dart';
import 'package:galaxy/Screens/playlist.dart';
import 'package:galaxy/favorite/likedsongs.dart';
import 'package:galaxy/playlist/playlist_func.dart';
import 'package:galaxy/playlist/playlist_model.dart';
import 'package:galaxy/recently/recently.dart';
import 'package:galaxy/colors/colors.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final TextEditingController _playlistnamecontroller = TextEditingController();
   final TextEditingController _editingController = TextEditingController();

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
                  )),
              child: Padding(
                padding: const EdgeInsets.only(left: 130, top: 40),
                child: Text(
                  'Library',
                  style: GoogleFonts.lato(
                      color: Colormanager.titleText,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
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
                      fontSize: 20),
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
                                          borderRadius:
                                              BorderRadius.circular(40))),
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
                                        style:
                                            TextStyle(color: Colormanager.text),
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          addPlaylist(
                                              _playlistnamecontroller.text);
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Add',
                                          style: TextStyle(
                                              color: Colormanager.text),
                                        ))
                                  ],
                                )
                              ],
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.add_circle,
                      size: 30,
                      color: Colors.black,
                    ))
              ],
            ),

            // grid view builder for playlist and mostplayed and liked songs
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
                          return Text('No playlist available ');
                        } else {
                          return GridView.builder(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 20,
                            ),
                            itemBuilder: (context, index) {
                              final playlist = items.data![index];
                              print(
                                  'Playlist Name: ${playlist.name}'); // Print playlist name for debugging

                              if (index == 0) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LikedSongs()));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color.fromARGB(
                                          255, 246, 205, 205),
                                    ),
                                    height: 130,
                                    width: 130,
                                    child: const Icon(
                                      Icons.favorite,
                                      color: Color.fromARGB(255, 255, 153, 146),
                                      size: 70,
                                    ),
                                  ),
                                );
                              } else if (index == 1) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RecentlyPlayed()));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colormanager.container,
                                    ),
                                    height: 130,
                                    width: 130,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: mediaQuerry.size.width * 0.02,
                                        ),
                                        const Text(
                                          'Recently played ',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Lottie.asset('assets/rc.json'),
                                      ],
                                    ),
                                  ),
                                );
                              } else if (index == 2) {
                                return InkWell(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colormanager.container,
                                    ),
                                    height: 130,
                                    width: 130,
                                    child: Lottie.asset(
                                      'assets/an1.json',
                                    ),
                                  ),
                                );
                              }

                              return InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Playlist(playlistname: playlist.name,)));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colormanager.container,
                                  ),
                                  height: mediaQuerry.size.height,
                                  width: mediaQuerry.size.width,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 10),
                                              child: Text(
                                                playlist.name,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: const Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width:
                                                40, // Set a specific width for the PopupMenuButton container
                                            child: PopupMenuButton(
                                              color: Colormanager.listtile,
                                              elevation: 0,
                                              icon: Icon(Icons.more_vert,
                                                  color: Colors.white),
                                              itemBuilder: (context) => [
                                                PopupMenuItem(
                                                  child: TextButton(
                                                    onPressed: () {
                                                      showDialog(context: context, builder: (context){
                                                        
                                                        return AlertDialog(title: Text('Edit playlist',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                        content: TextFormField(controller: _editingController,),
                                                        actions: [ TextButton(onPressed: (){
                                                          Navigator.of(context).pop();
                                                        }, child: Text('Cancel',style: TextStyle(color: Colormanager.text),)),TextButton(onPressed: (){
                                                          editPLaylistName(playlist.name,_editingController.text );
                                                          Navigator.of(context).pop();
                                                        }, child: Text('Save',style: TextStyle(color: Colormanager.text)))]
                                                        ,
                                
                                                        backgroundColor: Colormanager.container,
                                                        );
                                                      });
                                                    },
                                                    child: Text(
                                                      'Edit',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  child: TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                      setState(() {});
                                                      deletePlaylist(
                                                          playlist.name,
                                                          playlist.song);
                                                    },
                                                    child: Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Lottie.asset('assets/sing.json',
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.fill),
                                    ],
                                  ),
                                ),
                              );

                              // Container(

                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(10),
                              //     color: Colormanager.container,
                              //   ),
                              //   height: 130,
                              //   width: 130,
                              //   child: Column(
                              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //     children: [

                              //       InkWell( onTap: (){
                              //         setState(() {

                              //         });
                              //         deletePlaylist(playlist.name, playlist.song);
                              //       },  child: Icon(Icons.delete,color: Colors.red,)),
                              //       Center(
                              //         child: Text(playlist.name, style: TextStyle(color: Colors.white),),
                              //       ),
                              //     ],
                              //   ),
                              // );
                            },
                            itemCount: items.data!.length,
                          );
                        }
                      })),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:galaxy/Screens/likedsongs.dart';
import 'package:galaxy/Screens/playlist.dart';
import 'package:google_fonts/google_fonts.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuerry = MediaQuery.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: mediaQuerry.size.height * 0.2,
              width: mediaQuerry.size.width * 1,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(left: 130, top: 40),
                child: Text(
                  'Library',
                  style: GoogleFonts.lato(
                      color: Colors.white,
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
                      color: Colors.black,
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
                              backgroundColor: Colors.black,
                              title: Text('Add new playlist',style: TextStyle(color:Colors.white),),
                              actions: [
                                TextFormField(
                                  
                                  
                                  style: GoogleFonts.lato(color: Colors.black,fontWeight: FontWeight.bold,),
                                  decoration: InputDecoration(fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(40))
                                
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
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Add',
                                          style: TextStyle(color: Colors.white),
                                        ))
                                  ],
                                )
                              ],
                            );
                          });
                    },
                    icon: Icon(
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
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    InkWell( 
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LikedSongs()));
                      },
                      child: Container(
                      
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        height: 130,
                        width: 130,
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Playlist()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        height: 130,
                        width: 130,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      height: 130,
                      width: 130,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      height: 130,
                      width: 130,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      height: 130,
                      width: 130,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      height: 130,
                      width: 130,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      height: 130,
                      width: 130,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

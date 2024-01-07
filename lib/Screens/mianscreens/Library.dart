import 'package:flutter/material.dart';
import 'package:galaxy/Screens/likedsongs.dart';
import 'package:galaxy/Screens/recently.dart';
import 'package:galaxy/colors/colors.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

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
                      color:Colormanager.maintext,
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
                                style: TextStyle(color:Colormanager.text),
                              ),
                              actions: [
                                TextFormField(
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
                                        style: TextStyle(color:Colormanager.text),
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Add',
                                          style: TextStyle(color:Colormanager.text),
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
                child: GridView.builder(
                    physics:const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    if(index==0){
                      return InkWell(
                        onTap: (){ Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const LikedSongs()));
                        
                        },
                        child: Container(
                          
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 246, 205, 205),
                        ),
                        height: 130,
                        width: 130,
                        child: const Icon(Icons.favorite ,color: Color.fromARGB(255, 255, 153, 146),size: 70,),

                                          ),
                      );
                    } else if(index==1){

                      return  InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const RecentlyPlayed()));
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
                            SizedBox(height: mediaQuerry.size.width*0.02 ,),
                            const Text('Recently played ',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontWeight: FontWeight.bold ),),
                            Lottie.asset('assets/rc.json'),
                          ],
                        ),
                                          ),
                      );
                    }else if(index==2){
                      return   InkWell(
                        onTap: (){},
                        child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colormanager.container,
                        ),
                        height: 130,
                        width: 130,
                        child: Lottie.asset('assets/an1.json',) ,
                                          ),
                      );

                    }

                    return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:Colormanager.container,
                        ),
                        height: 130,
                        width: 130,
                                          );
                  },
                  itemCount: 4,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



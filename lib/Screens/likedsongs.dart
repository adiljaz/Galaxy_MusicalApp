import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LikedSongs extends StatelessWidget {
  const LikedSongs({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuerry = MediaQuery.of(context);
    return  SafeArea(
      child: Scaffold(
          body:  Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: mediaQuerry.size.height * 0.25,
                      // ignore: sort_child_properties_last
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const FaIcon(
                                      FontAwesomeIcons.circleChevronLeft,
                                      color: Colors.white,
                                    )),
                                SizedBox(
                                  width: mediaQuerry.size.width * 0.2,
                                ),
                                const Center(
                                    child: Text(
                                  'Liked Songs',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ))
                              ],
                            ),
                            SizedBox(
                              height: mediaQuerry.size.height * 0.04,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  hintText: 'Search..',
                                  suffixIcon: const Icon(Icons.search)),
                            ),
                          ],
                        ),
                      )),
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40))),
                    ),
                  ],
                ),
                SizedBox(
                  height: mediaQuerry.size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const FaIcon(
                          FontAwesomeIcons.shuffle,
                          color: Colors.black,
                          size: 30,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.play_circle,
                          color: Colors.black,
                          size: 40,
                        )),
                    IconButton(
                        onPressed: () {
                          
                            showModalBottomSheet(
                            shape:const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))) ,
                            context: context, builder: (context){
                            
                            return Container(
                              height: mediaQuerry.size.height*0.45,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
                              ),
                            )
                          ;
      
                            
                            
                          });
                        },
                        icon: const Icon(
                          Icons.more_horiz,
                          color: Colors.black,
                          size: 40,
                        ))
                  ],
                ),


                
              ],


              
            ),
          ),
    );
      
    
  }
}

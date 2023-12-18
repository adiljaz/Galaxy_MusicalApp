import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Playlist extends StatelessWidget {
  const Playlist({super.key});

  @override
  Widget build(BuildContext context) {
      MediaQueryData mediaQuerry = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: mediaQuerry.size.height * 0.25,
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
                                  icon: FaIcon(
                                    FontAwesomeIcons.circleChevronLeft,
                                    color: Colors.white,
                                  )),
                              SizedBox(
                                width: mediaQuerry.size.width * 0.25 ,
                              ),
                              Center(
                                  child: Text(
                                'Playlist',
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
                                suffixIcon: Icon(Icons.search)),
                          ),
                        ],
                      ),
                    )),
                    decoration: BoxDecoration(
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
                      icon: FaIcon(
                        FontAwesomeIcons.shuffle,
                        color: Colors.black,
                        size: 30,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.play_circle,
                        color: Colors.black,
                        size: 40,
                      )),
                  IconButton(
                      onPressed: () {
                         showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(40))),
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: mediaQuerry.size.height * 0.35,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(40),
                                              topRight: Radius.circular(40))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: mediaQuerry.size.height *
                                                  0.05,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width:
                                                      mediaQuerry.size.width *
                                                          0.06,
                                                ),
                                                Icon(
                                                  Icons.add_circle,
                                                  size: 30,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width:
                                                      mediaQuerry.size.width *
                                                          0.05,
                                                ),
                                                Text('Add to playlist',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ))
                                              ],
                                            ),
                                            SizedBox(
                                              height: mediaQuerry.size.height *
                                                  0.03,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width:
                                                      mediaQuerry.size.width *
                                                          0.06,
                                                ),
                                                Icon(
                                                  Icons.do_not_disturb_on,
                                                  size: 30,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width:
                                                      mediaQuerry.size.width *
                                                          0.05,
                                                ),
                                                Text('Remove From PLaylist',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ))
                                              ],
                                            ),
                                            SizedBox(
                                              height: mediaQuerry.size.height *
                                                  0.03,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width:
                                                      mediaQuerry.size.width *
                                                          0.06,
                                                ),
                                                FaIcon(
                                                  FontAwesomeIcons.music,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width:
                                                      mediaQuerry.size.width *
                                                          0.05,
                                                ),
                                                Text('Go to Lyrics',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ))
                                              ],
                                            ),
                                            SizedBox(
                                              height: mediaQuerry.size.height *
                                                  0.03,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width:
                                                      mediaQuerry.size.width *
                                                          0.06,
                                                ),
                                                Icon(
                                                  Icons.queue_music,
                                                  size: 35,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width:
                                                      mediaQuerry.size.width *
                                                          0.05,
                                                ),
                                                Text('Go to Playlist',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  );

                        
                        
                          
                      },
                      icon: Icon(
                        Icons.more_horiz,
                        color: Colors.black,
                        size: 40,
                      ))
                ],
              )
            ],
          ),
        ),
    );
    
  }
}
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LikedSongs extends StatelessWidget {
  const LikedSongs({super.key});

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
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))),
                          context: context,
                          builder: (context) {
                            return Container(
                              height: mediaQuerry.size.height * 0.45,
                              decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40))),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: mediaQuerry.size.height * 0.05,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: mediaQuerry.size.width * 0.06,
                                      ),
                                      Icon(
                                        Icons.add_circle,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: mediaQuerry.size.width * 0.05,
                                      ),
                                      Text('Add to playlist',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: mediaQuerry.size.height * 0.03,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: mediaQuerry.size.width * 0.06,
                                      ),
                                      Icon(
                                        Icons.do_not_disturb_on,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: mediaQuerry.size.width * 0.05,
                                      ),
                                      Text('Remove From PLaylist',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: mediaQuerry.size.height * 0.03,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: mediaQuerry.size.width * 0.06,
                                      ),
                                      FaIcon(
                                        FontAwesomeIcons.music,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: mediaQuerry.size.width * 0.05,
                                      ),
                                      Text('Go to Lyrics',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: mediaQuerry.size.height * 0.03,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: mediaQuerry.size.width * 0.06,
                                      ),
                                      Icon(
                                        Icons.queue_music,
                                        size: 35,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: mediaQuerry.size.width * 0.05,
                                      ),
                                      Text('Go to Playlist',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: mediaQuerry.size.height * 0.03,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: mediaQuerry.size.width * 0.06,
                                      ),
                                      Icon(
                                        Icons.favorite,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: mediaQuerry.size.width * 0.05,
                                      ),
                                      Text('Add to Favorite',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            );
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

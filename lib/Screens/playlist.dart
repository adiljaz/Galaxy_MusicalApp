// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galaxy/colors/colors.dart';

class Playlist extends StatelessWidget {
   Playlist({super.key,required this.playlistname});

  String playlistname;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuerry = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colormanager.scaffoldcolor,
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: mediaQuerry.size.height * 0.2,
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
                              width: mediaQuerry.size.width * 0.25,
                            ),
                            
                          ],
                        ),
                        SizedBox(
                          height: mediaQuerry.size.height * 0.03 ,
                        ), 
                         Center(
                                child: Text(
                              playlistname,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25 ,
                                  fontWeight: FontWeight.bold),
                            ))
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
            
          ],
        ),
      ),
    );
  }
}

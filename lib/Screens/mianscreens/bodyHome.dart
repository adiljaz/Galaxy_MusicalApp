// ignore: file_names
import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galaxy/Screens/mianscreens/Library.dart';

import 'package:galaxy/Screens/home/home.dart';
import 'package:galaxy/about.dart';
import 'package:galaxy/colors/colors.dart';

import 'package:galaxy/database/db_functions.dart';

import 'package:galaxy/Screens/mianscreens/search.dart';
import 'package:galaxy/privacy.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<Home> createState() => _HomeState();
}

int _selectedindex = 0;

final pages = [
  MainHome(),
  const Search(),
  const LibraryScreen(),
];

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

        MediaQueryData mediaQuerry = MediaQuery.of(context);
    getAllSongs();
    

    return SafeArea(
      
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        key: Home.scaffoldKey,
        drawer: Drawer(
        
          child: Container(
            decoration: BoxDecoration(gradient: LinearGradient(colors: [
              Colors.white,Color.fromARGB(255, 255, 255, 255)
            ])),
            child: ListView(
              children: [
            
              SizedBox(
                height: mediaQuerry.size.height*0.1 ,
              ),
            
                Center( child: Lottie.asset('assets/drawer.json')),
                 SizedBox(
                height: mediaQuerry.size.height*0.01 ,
              ),
            
                Center(
                  child: AnimatedTextKit(
                     
                  
                     repeatForever: false,
                  
                      
                      animatedTexts:[ColorizeAnimatedText(' Galaxy', textStyle: GoogleFonts.josefinSans( color: const Color.fromARGB(255, 190, 188, 188) ,fontSize: 50 ,fontWeight: FontWeight.bold ), colors: [
                      Color.fromARGB(255, 0, 0, 0),
                      Color.fromARGB(255, 255, 255, 255) ,
                      
                  
                    ])]),
                ),
            
                SizedBox(height: mediaQuerry.size.height*0.07,),
            
            
                GestureDetector(child: Row(     children:[     SizedBox(width: mediaQuerry.size.width*0.07 ,),    FaIcon(FontAwesomeIcons.shareNodes,size: 30,)  ,SizedBox(width: mediaQuerry.size.width*0.07 ,),Text('Share',style:GoogleFonts.lato(fontWeight: FontWeight.bold ,fontSize: 27 ),)    ],)),
                SizedBox(height:mediaQuerry.size.height*0.02,),
            
                     GestureDetector(       onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Privacy()));
                     },      child: Row(     children:[     SizedBox(width: mediaQuerry.size.width*0.06 ,),    Icon(Icons.security,size: 30,),SizedBox(width: mediaQuerry.size.width*0.07 ,),Text('Privacy Policy',style:GoogleFonts.lato(fontWeight: FontWeight.bold ,fontSize: 27 ),)    ],)),
                 SizedBox(height:mediaQuerry.size.height*0.02,),
            
                     GestureDetector(
                      onTap: (){
                        _launchEmail();
                      },
                      child: Row(     children:[     SizedBox(width: mediaQuerry.size.width*0.06 ,),    Icon(Icons.forum,size: 30,),SizedBox(width: mediaQuerry.size.width*0.07 ,),Text('FeedBack',style:GoogleFonts.lato(fontWeight: FontWeight.bold ,fontSize: 27 ),)    ],)),
                     SizedBox(height:mediaQuerry.size.height*0.02,),
            
                     GestureDetector(         onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>About()));
                     },  child: Row(     children:[     SizedBox(width: mediaQuerry.size.width*0.06 ,),    Icon(Icons.report,size: 30,),SizedBox(width: mediaQuerry.size.width*0.07 ,),Text('About',style:GoogleFonts.lato(fontWeight: FontWeight.bold ,fontSize: 27 ),)    ],)),
                          SizedBox(height: mediaQuerry.size.height*0.16,),
                     Center(child: Text('V.1.0.0',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500 ),))
              ],
            ),
          ),
        ),
        body: pages[_selectedindex],
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // visible container

              // InkWell(
              //   onTap: () {
              //     Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              //       MusicModel currentSong =
              //           context.watch<SongModelProvider>().currentSong!;
              //       int currentIndex = context.watch<SongModelProvider>().id;
              //       List<MusicModel> songList =
              //           context.watch<SongModelProvider>().songList;

              //       return Nowplaying(
              //         index: currentIndex,
              //         musicModel: currentSong,
              //         songmodel: songList,
              //       );
              //     }));
              //   },
              //   child: Visibility(
              //     visible: VisibilityManager.isVisible &&
              //         _selectedindex != pages.length - 1,
              //     child: Container(
              //       height: mediaQuerry.size.height * 0.18,
              //       width: mediaQuerry.size.width * 1,
              //       color: Colormanager.container,
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.only(
              //               left: 30,
              //               top: 15,
              //             ),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                 ClipRRect(
              //                     borderRadius: BorderRadius.circular(3),
              //                     child: QueryArtworkWidget(
              //                       id: context.watch<SongModelProvider>().id,
              //                       type: ArtworkType.AUDIO,
              //                       artworkFit: BoxFit.cover,
              //                       artworkQuality: FilterQuality.high,
              //                       artworkBorder: const BorderRadius.all(
              //                           Radius.circular(5)),
              //                     )),
              //                 SizedBox(width: mediaQuerry.size.width * 0.05),
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   children: [
              //                     SizedBox(
              //                       width: mediaQuerry.size.width * 0.35,
              //                       height: 15,
              //                       child: MarqueeText(
              //                         speed: 15,
              //                         alwaysScroll: true,
              //                         text: TextSpan(
              //                           text: context
              //                                   .watch<SongModelProvider>()
              //                                   .currentSong
              //                                   ?.songname ??
              //                               'No Song',
              //                         ),
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.bold,
              //                             color: Colormanager.text),
              //                       ),
              //                     ),
              //                     SizedBox(
              //                       height: mediaQuerry.size.height * 0.004,
              //                     ),
              //                     SizedBox(
              //                       width: mediaQuerry.size.width * 0.35,
              //                       height: 15,
              //                       child: Text(
              //                         context
              //                                 .watch<SongModelProvider>()
              //                                 .currentSong
              //                                 ?.artistname ??
              //                             'No Artist',
              //                         style: TextStyle(
              //                             fontSize: 12,
              //                             color: Colormanager.text),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //                 SizedBox(
              //                   width: mediaQuerry.size.width * 0.06,
              //                 ),
              //                 InkWell(
              //                     child: FaIcon(FontAwesomeIcons.backwardStep,
              //                         color: Colormanager.icons)),
              //                 SizedBox(
              //                   width: mediaQuerry.size.width * 0.02,
              //                 ),
              //                 InkWell(
              //                   onTap: () {
              //                     context
              //                         .read<SongModelProvider>()
              //                         .togglePlayPause();
              //                   },
              //                   child: Icon(
              //                     context.read<SongModelProvider>().isPlaying
              //                         ? Icons.play_circle
              //                         : Icons.pause_circle,
              //                     size: 42,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   width: mediaQuerry.size.width * 0.02,
              //                 ),
              //                 InkWell(
              //                     onTap: () {
              //                       // next song
              //                     },
              //                     child: FaIcon(FontAwesomeIcons.forwardStep,
              //                         color: Colormanager.icons)),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),

              ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  child: SnakeNavigationBar.color( 
                    height: 70, snakeViewColor: Colormanager.listtile,

                     // Set to the desired color
                    backgroundColor: Colors.black,
                    currentIndex : _selectedindex,
                    onTap: (value) {
                      setState(() {
                        _selectedindex = value;
                      });
                    },
                    items:const  [
                      BottomNavigationBarItem(icon: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                                Text('Home',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                          ],
                        ),
                      ),),
                      BottomNavigationBarItem(icon: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            Text('Search',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                          ],
                        ),
                      ),),
                      BottomNavigationBarItem(icon: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.library_music,
                              color: Colors.white,
                            ),
                                Text('Library',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
                          ],
                        ),
                      ),),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }


 Future<void> _launchEmail() async {
    const String emailAddress = 'adiljaz17@gmail.com';
    const String emailSubject = '';
    const String emailBody = '';

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {
        'subject': emailSubject,
        'body': emailBody,
      },
    );

    try {
      await launchUrl(emailUri);
    } catch (e) {
      
      log('Error launching email: $e');
    }
  }

}


















//  currentIndex: _selectedindex,
//                   onTap: (value) {

                     

                    


                    
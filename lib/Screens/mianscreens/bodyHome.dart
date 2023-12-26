import 'package:flutter/material.dart';
import 'package:galaxy/Screens/mianscreens/Library.dart';
import 'package:galaxy/Screens/mianscreens/audio.dart';
import 'package:galaxy/Screens/mianscreens/home.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galaxy/Screens/nowplaying.dart';

import 'package:galaxy/provider/provider.dart';

import 'package:galaxy/Screens/mianscreens/search.dart';
import 'package:galaxy/Screens/visible.dart';

import 'package:lottie/lottie.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({super.key});

  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<Home> createState() => _HomeState();
}

int _selectedindex = 0;

final pages = [
  MainHome(),
  Search(),
  LibraryScreen(),
  AudioScreen(),
];

class _HomeState extends State<Home> {
  bool _isplaying = true;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuerry = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        key: Home.scaffoldKey,
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                leading: Text('kjankjfnwekj '),
              ),
              ListTile(
                leading: Text('kjankjfnwekj '),
              ),
              ListTile(
                leading: Text('kjankjfnwekj '),
              )
            ],
          ),
        ),
        body: pages[_selectedindex],
        bottomNavigationBar: ClipRRect(
        
          
           
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // visible container

              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return Nowplaying(
                        musicModel:
                            context.watch<SongModelProvider>().currentSong!);
                  }));
                },
                child: Visibility(
                  visible: VisibilityManager.isVisible &&
                      _selectedindex != pages.length - 1,
                  child: Container(
                    height: mediaQuerry.size.height * 0.18,
                    width: mediaQuerry.size.width * 1,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 30,
                            top: 15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(3),
                                  child: QueryArtworkWidget(
                                    id: context.watch<SongModelProvider>().id,
                                    type: ArtworkType.AUDIO,
                                    artworkFit: BoxFit.cover,
                                    artworkQuality: FilterQuality.high,
                                    artworkBorder: const BorderRadius.all(
                                        Radius.circular(5)),
                                  )),
                              SizedBox(width: mediaQuerry.size.width * 0.05),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: mediaQuerry.size.width * 0.35,
                                    height: 15,
                                    child: Text(
                                      context
                                              .watch<SongModelProvider>()
                                              .currentSong
                                              ?.songname ??
                                          'No Song',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: mediaQuerry.size.height * 0.004,
                                  ),
                                  Container(
                                    width: mediaQuerry.size.width * 0.35,
                                    height: 15,
                                    child: Text(
                                      context
                                              .watch<SongModelProvider>()
                                              .currentSong
                                              ?.artistname ??
                                          'No Artist',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: mediaQuerry.size.width * 0.06,
                              ),
                              InkWell(
                                  child: FaIcon(FontAwesomeIcons.backwardStep,
                                      color: Colors.white)),
                              SizedBox(
                                width: mediaQuerry.size.width * 0.02,
                              ),
                              InkWell(
                                onTap: () {
                                  _isplaying != _isplaying;
                                },
                                child: Icon(
                                  _isplaying
                                      ? Icons.pause_circle
                                      : Icons.play_circle,
                                  color: Colors.white,
                                  size: 42,
                                ),
                              ),
                              SizedBox(
                                width: mediaQuerry.size.width * 0.02,
                              ),
                              InkWell(
                                  child: FaIcon(FontAwesomeIcons.forwardStep,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  currentIndex: _selectedindex,
                  onTap: (value) {
                    setState(() {
                      _selectedindex = value;
                    });
                  },
                  selectedItemColor: Color.fromARGB(255, 105, 105, 105),
                  unselectedItemColor: Colors.black,
                  showUnselectedLabels: true,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.home,
                          size: 25,
                        ),
                        label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.search, size: 25), label: 'Search'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.library_music, size: 25),
                        label: 'Library'),
                    BottomNavigationBarItem(
                        icon: Lottie.asset(
                          'assets/an1.json',
                          width: 45,
                          height: 30,
                        ),
                        label: 'Record'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

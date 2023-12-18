import 'package:flutter/material.dart';
import 'package:galaxy/Screens/Library.dart';
import 'package:galaxy/Screens/audio.dart';
import 'package:galaxy/Screens/home.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:galaxy/Screens/search.dart';




class Home extends StatefulWidget {
  Home({super.key});

   static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<Home> createState() => _HomeState();
}

int _selectedindex = 0;

final pages=[
  MainHome(),
  Search(),
  LibraryScreen(), 
  AudioScreen(),
  
  

];

class _HomeState extends State<Home> {
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
        body:pages[_selectedindex],

        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          child: Stack(
            children: [

              
              // visible container


              InkWell(
                onTap: (){

//                   void navigateToNowPlaying(SongModel songModel) {
//   Navigator.of(context).push(
//     MaterialPageRoute(
//       builder: (context) => Nowplaying(songModel: songModel),
//     ),
//   );
// }

                }, 
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
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  'https://e1.pxfuel.com/desktop-wallpaper/433/147/desktop-wallpaper-steam-workshop-xxxtentacion-animated-backgrounds-red-led-xxxtentacion-animated.jpg',
                                  fit: BoxFit.cover,
                                  width: mediaQuerry.size.width * 0.17,
                                  height: mediaQuerry.size.height * 0.08,
                                )),
                            SizedBox(width: mediaQuerry.size.width * 0.05),
              
                            
              
                            
                          
              
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'XxX tentacion  ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255)),
                                ),
                                SizedBox(
                                  height: mediaQuerry.size.height * 0.004,
                                ),
                                Text(
                                  'Fade out ,Broken angel  ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255)),
                                )
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
                                child: Icon(
                              Icons.play_circle,
                              color: Colors.white,
                              size: 30,
                            )),
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

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
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
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home,size: 25,), label: 'Home'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.search,size: 25), label: 'Search'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.library_music,size: 25), label: 'Library'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.play_circle,size: 25,), label: 'Song'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

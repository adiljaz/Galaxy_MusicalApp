import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

int _selectedindex = 0;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuerry = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text('Home',
              style: GoogleFonts.josefinSans(
                  color: Colors.white, fontWeight: FontWeight.w500)),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu,color: Colors.white,),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: mediaQuerry.size.height * 0.2,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 35 ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20)),
                    height: mediaQuerry.size.height * 0.3,
                    width: mediaQuerry.size.width * 0.6,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9DzpVGpCf2UMKt0ERDjTekp0bXkayaC0uzA&usqp=CAU',
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                Positioned(
                  left: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 35),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 7, 7),
                          borderRadius: BorderRadius.circular(20)),
                      height: mediaQuerry.size.height * 0.3,
                      width: mediaQuerry.size.width * 0.6,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRskycHBe40Fu0JO58uFs8F0_CwzhP6R5w3w&usqp=CAU',
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                ),
                Positioned(
                  left: 80,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 30, left: 35),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(50)),
                        height: mediaQuerry.size.height * 0.3,
                        width: mediaQuerry.size.width * 0.6,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              'https://e1.pxfuel.com/desktop-wallpaper/433/147/desktop-wallpaper-steam-workshop-xxxtentacion-animated-backgrounds-red-led-xxxtentacion-animated.jpg',
                              fit: BoxFit.cover,
                            )),
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 43, right: 40, top: 20),
              child: Expanded(
                child: Column(
                  children: [
                    Text(
                      'Your songs',
                      style: GoogleFonts.josefinSans(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          child: Stack(
            children: [
              // Your visible container
              Container(
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
                              child: FaIcon(FontAwesomeIcons.forwardStep,
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
                              child: FaIcon(FontAwesomeIcons.backwardStep,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Your BottomNavigationBar
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
                          icon: Icon(Icons.home), label: 'Home'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.search), label: 'Search'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.library_add), label: 'Library'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.play_arrow_rounded), label: 'Song'),
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

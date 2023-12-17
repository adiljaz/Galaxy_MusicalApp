import 'package:flutter/material.dart';
import 'package:galaxy/Screens/bodyHome.dart';
import 'package:google_fonts/google_fonts.dart';

class MainHome extends StatefulWidget {
  
  MainHome({super.key});
  

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuerry = MediaQuery.of(context);
    return Scaffold(
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.black, border: Border.all(color: Colors.black)),
            height: mediaQuerry.size.height * 0.07,
            child: Row(
              children: [
                SizedBox(
                  width: mediaQuerry.size.width * 0.04,
                ),
                Builder(builder: (context) {
                  return InkWell(
                      onTap: () {
                        Home.scaffoldKey.currentState?.openDrawer();


                      },
                      child: Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 30,
                      ));
                }),
                SizedBox(
                  width: mediaQuerry.size.width * 0.28,
                ),
                Text(
                  'Home',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
              ],
            ),
          ),

          // stack starting
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
                padding: const EdgeInsets.only(top: 30, left: 35),
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
                    style: GoogleFonts.lato(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          // LIst view for showing swtched screens ...
        ],
      ),
    );
  }
}

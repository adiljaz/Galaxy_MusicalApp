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
                                width: mediaQuerry.size.width * 0.2,
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
                          shape:RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))) ,
                          context: context, builder: (context){
                          
                          return Container(
                            height: mediaQuerry.size.height*0.45,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
                            ),
                          )
                        ;
    
                          
                          
                        });
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
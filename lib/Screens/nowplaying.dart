import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galaxy/Screens/lyrics.dart';
import 'package:galaxy/Screens/playlist.dart';
import 'package:google_fonts/google_fonts.dart';

class Nowplaying extends StatefulWidget {
  const Nowplaying({super.key});

  @override
  State<Nowplaying> createState() => _NowplayingState();
}

class _NowplayingState extends State<Nowplaying> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuerry = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            
            Stack(
              children: [

               

                Container(
                  child: Row(
                   
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Padding(
                      padding: const EdgeInsets.only(left: 20,top: 10 ),
                      child: IconButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, icon:  FaIcon(FontAwesomeIcons.circleChevronDown,color: Colors.white,))
                    ),Padding(
                      padding: const EdgeInsets.only(left: 70,top: 20 ),
                      child: Text('Playing Now', style:GoogleFonts.lato(fontWeight: FontWeight.bold ,fontSize: 20,color: Colors.white),),
                      
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top:10,left:40,),
                    child: IconButton(onPressed: (){

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

                    }, icon: Icon(Icons.more_horiz ,color: Colors.white,size: 29)),
                  )
                  ],
                    
                    
                    ),
                  height: mediaQuerry.size.height * 0.37,
                  width: mediaQuerry.size.width * 1,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 80,
                    left: 38,
                    right: 38,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: mediaQuerry.size.height * 0.4,
                    width: mediaQuerry.size.width * 1.6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        'https://qph.cf2.quoracdn.net/main-qimg-04c3d4c3fe680ce89f7072aceac11ba3-pjlq',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: mediaQuerry.size.height * 0.05,
            ),
            // items starting   
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: ListTile(
                title: Text('greedy',style:GoogleFonts.lato(fontWeight: FontWeight.bold ,fontSize: 20,)),
                subtitle: Text('One direction',style:GoogleFonts.lato(fontWeight: FontWeight.bold)),
                trailing: Icon(
                  Icons.favorite,
                  color: Colors.red,//   favorite butto i need to change 
                ),
              ),
            ),
            Container(
             
              height: 10,
              child: SliderTheme(
                data:SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.black,
                  thumbColor: Colors.black,
                 thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
                 trackHeight:6.0, 
                     
                  
                ) ,
                child: Padding(
                  padding: const EdgeInsets.only(left:8,right: 8),
                  child: Slider(
                    value: 0.2,
                    onChanged: (context) {},
                    activeColor: Colors.black,
                  ),
                ),
            
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('0:01',style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 15),),
                Text('02:23',style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 15)),
              ],),
            ),
            SizedBox(
              height: mediaQuerry.size.height*0.02 ,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20 , right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  
                  FaIcon(FontAwesomeIcons.shuffle,size: 20,), 
                  FaIcon(FontAwesomeIcons.backwardStep,size: 35,),
                  Icon(Icons.play_circle,size: 65,),
                  FaIcon(FontAwesomeIcons.forwardStep,size: 35,),
                  FaIcon(FontAwesomeIcons.rotate,size: 20,)
                 
                ],
            
              ),
            ),

            SizedBox(
              height:mediaQuerry.size.height*0.05 ,

            ),
            Row(
              
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  InkWell ( onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Playlist()));},  child: Text('PLaylist   ',style:GoogleFonts.lato(fontWeight: FontWeight.bold ,fontSize: 18),)) ,Text('|',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                    
                    InkWell(  onTap: (){ Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LyricsScreen()));},  child: Text('    Lyrics ',style:GoogleFonts.lato(fontWeight: FontWeight.bold ,fontSize: 18))),

              ],
            )

          

            
          ],

          
        ),
        
      ),
    );
  }
}

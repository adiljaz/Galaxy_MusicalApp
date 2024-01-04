import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galaxy/database/db_model.dart';

import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class LyricsScreen extends StatelessWidget {
   LyricsScreen({super.key,required this.index,required this.songmodel });

   int index;
  List<MusicModel> songmodel;
 

  @override
  Widget build(BuildContext context) {
     MediaQueryData mediaQuerry = MediaQuery.of(context);

     

   

    return SafeArea(child: Scaffold(
      
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration( image: DecorationImage(image: NetworkImage('https://www.enjpg.com/img/2020/harry-styles-5.jpg'),fit: BoxFit.cover,colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [

            Padding(
              padding: const EdgeInsets.only(top: 8,left: 8),
              child: IconButton(onPressed: (){Navigator.of(context).pop();  }, icon: FaIcon(FontAwesomeIcons.circleChevronLeft,color: Colors.white,)),
            ),

            SizedBox(height: 450 ,),

            
          

           Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: ListTile(
                title: Text('greedy',style:GoogleFonts.lato(fontWeight: FontWeight.bold ,fontSize: 20,)),
                subtitle: Text('One direction',style:GoogleFonts.lato(fontWeight: FontWeight.bold,color: Colors.black)),
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

            SizedBox(height: mediaQuerry.size.height*0.05,),

          


        ],),

      ),
    ));
    
  }
}
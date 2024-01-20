import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galaxy/Screens/home/home.dart';
import 'package:galaxy/database/db_model.dart';
import 'package:galaxy/favorite/fav_function.dart';
import 'package:galaxy/provider/provider.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LyricsScreen extends StatefulWidget {
   LyricsScreen({super.key,required this.index,required this.songmodel, required this.musicmodel });

   int index;
  List<MusicModel> songmodel;
  MusicModel musicmodel; 

  @override
  State<LyricsScreen> createState() => _LyricsScreenState();
}

class _LyricsScreenState extends State<LyricsScreen> {


    Duration _duration = Duration();
    Duration _position = Duration(); 
    bool _isplaying=false; 



@override
  void initState() {
   
   
    super.initState();
     audioplayer.playerStateStream.listen((state) { 
      if(state.processingState==ProcessingState.completed);
      // playnext();
    });
    playSong();
  }


  playSong(){
    try{

      
      audioplayer.setAudioSource(AudioSource.uri(Uri.parse(widget.musicmodel.uri)));
        audioplayer.play(); 

        
       setState(() {
        _isplaying = true;
      });
        
        
    }on Exception {
      print('unsupported File');
    }

     audioplayer.durationStream.listen((d) {
      setState(() {
        _duration=d!;
      });
      });
      audioplayer.positionStream.listen((p) {
        setState(() {
          
          _position=p;
        });
       });
  
    
  }


  @override
  Widget build(BuildContext context) {
     MediaQueryData mediaQuerry = MediaQuery.of(context);

     

   

    return SafeArea(child: Scaffold(
      
      
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration( image: DecorationImage(image: const NetworkImage('https://www.enjpg.com/img/2020/harry-styles-5.jpg'),fit: BoxFit.cover,colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [

            Padding(
              padding: const EdgeInsets.only(top: 8,left: 8),
              child: IconButton(onPressed: (){Navigator.of(context).pop();  }, icon: const FaIcon(FontAwesomeIcons.circleChevronLeft,color: Colors.black,)),
            ),

            const SizedBox(height: 450 ,),

            
          

           Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: ListTile(
                title: Text(   widget.musicmodel.songname,style:GoogleFonts.lato(fontWeight: FontWeight.bold ,fontSize: 20, ), maxLines: 1,),
                subtitle: Text(widget.musicmodel.artistname,style:GoogleFonts.lato(fontWeight: FontWeight.bold,color: Colors.black),maxLines: 1,),
                trailing: favSongs.contains(widget.musicmodel.songid)?GestureDetector(
                  onTap: (){
                    removeLikedSong(widget.musicmodel.songid);
                    ifLickd();
                    setState(() {
                      
                    });

                  },
                  child:Icon(Icons.favorite_border,color: Colors.red,),

                ):GestureDetector(
                  onTap: (){
                    addlikedSong(widget.musicmodel.songid);
                    ifLickd();
                    setState(() {
                      
                    });
                  },
                  child: Icon(Icons.favorite,color: Colors.red,),
                ),
              )
            ), 
            SizedBox(
             
              height: 10,
              child: SliderTheme(
                data:SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.black,
                  thumbColor: Colors.black,
                 thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
                 trackHeight:6.0, 
                     
                  
                ) ,
                child: Padding(
                  padding: const EdgeInsets.only(left:8,right: 8),
                  child: Slider(
                    value: _position.inSeconds.toDouble(),
                    max: _duration.inSeconds.toDouble(),
                    min: Duration(microseconds: 0).inSeconds.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        value=value; 
                      });
                    },
                    activeColor: Colors.black,
                  ),
                ),
            
              ),
            ),

             Padding(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text(_position.toString().split('.')[0],style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 15),),
                Text(_duration.toString().split('.')[0],style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 15)),
              ],),
            ),
            SizedBox(
              height: mediaQuerry.size.height*0.02 ,
            ),

             Padding(
              padding: EdgeInsets.only(left: 20 , right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  
                  GestureDetector(    onTap: (){
                    seufflSongs(); 
                  },  child: FaIcon(FontAwesomeIcons.shuffle,size: 20,)), 
                  GestureDetector(     onTap: (){
                    playPrevious();
                  },   child: FaIcon(FontAwesomeIcons.backwardStep,size: 35,)),
                  GestureDetector( onTap: (){

                  }, child: Icon(Icons.play_circle,size: 65,)),
                  GestureDetector( onTap: (){
                    playnext(); 

                  }, child: FaIcon(FontAwesomeIcons.forwardStep,size: 35,)),
                  GestureDetector( onTap: (){
                    loopmode(); 

                  },   child: FaIcon(FontAwesomeIcons.rotate,size: 20,))
                 
                ],
            
              ),
            ),

            SizedBox(height: mediaQuerry.size.height*0.05,),

          


        ],),

      ),
    ));
    

    
  }


  void seufflSongs(){
    setState(() {
      List<MusicModel> originalSongs= List.from(widget.songmodel);
      if(audioplayer.shuffleModeEnabled){
        audioplayer.setShuffleModeEnabled(false); 
        widget.songmodel=originalSongs; 
      }else{
        audioplayer.setShuffleModeEnabled(true);
        List<MusicModel> suffleSongs= List.from(originalSongs); 
        suffleSongs.remove(widget.index); 
        suffleSongs.shuffle(); 
        widget.songmodel=[widget.musicmodel,...suffleSongs]; 
           if(!_isplaying){
            playSong(); 
           }
      }
    });
  }

  void loopmode(){
    setState(() {
      if(audioplayer.loopMode==LoopMode.off){
        audioplayer.setLoopMode(LoopMode.one); 
        
      }else{
        audioplayer.setLoopMode(LoopMode.off); 
      }
    });
  }


  void playnext(){
    if(widget.index<widget.songmodel.length-1){
      setState(() {
        widget.index++; 
        widget.musicmodel=widget.songmodel[widget.index]; 
        context.read<SongModelProvider>().setId(widget.musicmodel.songid);
        playSong(); 

      });
    }else{
      setState(() {
        widget.index=0; 
        widget.musicmodel=widget.songmodel[widget.index]; 
        context.read<SongModelProvider>().setId(widget.musicmodel.songid);
        playnext(); 

      });
    }
  }

playPrevious(){

if(widget.index>0){
  setState(() {
    widget.index--; 
    widget.musicmodel=widget.songmodel[widget.index]; 
    context.read<SongModelProvider>().setId(widget.musicmodel.songid);
    playSong();
    
  });
}else{
  setState(() {
    widget.index=widget.songmodel.length-1; 
    widget.musicmodel=widget.songmodel[widget.index]; 
    context.read<SongModelProvider>().setId(widget.musicmodel.songid);
    playSong(); 

  });
}

}




  changetosecond(int seconds){
    Duration duration=Duration (seconds: seconds);
    audioplayer.seek(duration); 
  }
}
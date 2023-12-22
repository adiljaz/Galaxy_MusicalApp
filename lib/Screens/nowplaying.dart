import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galaxy/Screens/bodyHome.dart';
import 'package:galaxy/Screens/home.dart';
import 'package:galaxy/Screens/lyrics.dart';
import 'package:galaxy/Screens/playlist.dart';
import 'package:galaxy/Screens/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class Nowplaying extends StatefulWidget {
  const Nowplaying({super.key, required this.songModel,required this.playlist});

  final SongModel songModel;

  final List<SongModel> playlist;
  



  @override
  State<Nowplaying> createState() => _NowplayingState();
}

class _NowplayingState extends State<Nowplaying> {

  Duration _duration=Duration();
  Duration _position=Duration();
  

  
  bool  _isplaying=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playSong();
  }

  
  //  try{
  //      audioplayer.setAudioSource(
  //     AudioSource.uri(Uri.parse(widget.songModel.uri!)),
  //   );


  playSong() {
  try {
    // Set up the audio player with the playlist
    audioplayer.setAudioSource(
      ConcatenatingAudioSource(
        children: widget.playlist.map((song) => AudioSource.uri(Uri.parse(song.uri!))).toList(),
      ),
    );

    audioplayer.play();

    setState(() {
      _isplaying = true;
    });
  } on Exception {
    print('unsupported File ');
  }

  audioplayer.durationStream.listen((d) {
    setState(() {
      _duration = d!;
    });
  });

  audioplayer.positionStream.listen((p) {
    setState(() {
      _position = p;
    });
  });
}


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
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 20, top: 10),
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.circleChevronDown,
                                color: Colors.white,
                              ))),
                      Padding(
                        padding: const EdgeInsets.only(left: 70, top: 20),
                        child: Text(
                          'Playing Now',
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 40,
                        ),
                        child: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(40))),
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: mediaQuerry.size.height * 0.35,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(40),
                                              topRight: Radius.circular(40))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: mediaQuerry.size.height *
                                                  0.05,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width:
                                                      mediaQuerry.size.width *
                                                          0.06,
                                                ),
                                                Icon(
                                                  Icons.add_circle,
                                                  size: 30,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width:
                                                      mediaQuerry.size.width *
                                                          0.05,
                                                ),
                                                Text('Add to playlist',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ))
                                              ],
                                            ),
                                            SizedBox(
                                              height: mediaQuerry.size.height *
                                                  0.03,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width:
                                                      mediaQuerry.size.width *
                                                          0.06,
                                                ),
                                                Icon(
                                                  Icons.do_not_disturb_on,
                                                  size: 30,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width:
                                                      mediaQuerry.size.width *
                                                          0.05,
                                                ),
                                                Text('Remove From PLaylist',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ))
                                              ],
                                            ),
                                            SizedBox(
                                              height: mediaQuerry.size.height *
                                                  0.03,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width:
                                                      mediaQuerry.size.width *
                                                          0.06,
                                                ),
                                                FaIcon(
                                                  FontAwesomeIcons.music,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width:
                                                      mediaQuerry.size.width *
                                                          0.05,
                                                ),
                                                Text('Go to Lyrics',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ))
                                              ],
                                            ),
                                            SizedBox(
                                              height: mediaQuerry.size.height *
                                                  0.03,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width:
                                                      mediaQuerry.size.width *
                                                          0.06,
                                                ),
                                                Icon(
                                                  Icons.queue_music,
                                                  size: 35,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width:
                                                      mediaQuerry.size.width *
                                                          0.05,
                                                ),
                                                Text('Go to Playlist',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                  );
                            },


                            icon: Icon(Icons.more_horiz,
                                color: Colors.white, size: 29)),
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
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: mediaQuerry.size.height * 0.4,
                    width: mediaQuerry.size.width * 1.6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const ArtWorkWiget( ),

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




                title: Text(widget.songModel.displayNameWOExt,
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
                subtitle: Text(widget.songModel.artist??'no artist found ',
                    style: GoogleFonts.lato(fontWeight: FontWeight.bold)),
                trailing: Icon(
                  Icons.favorite,
                  color: Colors.red, //   favorite butto i need to change
                ),
              ),
            ),
            Container(
              height: 10,
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.black,
                  thumbColor: Colors.black,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
                  trackHeight: 6.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Slider(
                    value: _position.inSeconds.toDouble(),
                    max: _duration.inSeconds.toDouble(),
                    min: Duration(microseconds: 0).inSeconds.toDouble(),
                    onChanged: (value) {

                      setState(() {
                        changetoseconds(value.toInt());
                        
                        value=value ;

                        
                      });


                    },
                    activeColor: Colors.black,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _position.toString().split('.')[0],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(_duration.toString().split('.')[0],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ],
              ),
            ),
            SizedBox(
              height: mediaQuerry.size.height * 0.02,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FaIcon(
                    FontAwesomeIcons.shuffle,
                    size: 20,
                  ),
                 InkWell(
                  onTap: (){
                    audioplayer.hasPrevious?audioplayer.seekToPrevious:null; 
                  },
                    child: FaIcon(
                      FontAwesomeIcons.backwardStep,
                      size: 35,
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {

                            if(_isplaying){
                              audioplayer.pause();

                         }else{
                         audioplayer.play();
                           
                         }


                         _isplaying=!_isplaying;

                         
                      });
                    },
                    child: Icon(
                     _isplaying? Icons.pause_circle:Icons.play_circle,
                      size: 65,
                    ),
                  ),

                  //////// next 
           
                   InkWell(
      onTap: () {
    if (audioplayer.hasNext == true) {
      audioplayer.seekToNext();
    } else {
      print('No next track available.');
    }
  },
      child: FaIcon(
        FontAwesomeIcons.forwardStep,
        size: 35,
      ),
    ),



                  FaIcon(
                    FontAwesomeIcons.rotate,
                    size: 20,
                  )
                ],
              ),
            ),

            SizedBox(
              height: mediaQuerry.size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Playlist()));
                    },
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
                        
                      },
                      child: Text(
                        'Home  ',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    )),
                Text(
                  '|',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LyricsScreen()));
                    },
                    child: Text('    Lyrics ',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold, fontSize: 18))),
              ],
            )
          ],
        ),
      ),
    );
  }

  void changetoseconds(int seconds){
    Duration duration=Duration(seconds: seconds);
    audioplayer.seek(duration);


  }
}

class ArtWorkWiget extends StatelessWidget {
  const ArtWorkWiget({
    super.key,
    
  });


  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget( id: context.watch<SongModelProvider>().id, type: ArtworkType.AUDIO, artworkFit: BoxFit.cover,);
  }
}

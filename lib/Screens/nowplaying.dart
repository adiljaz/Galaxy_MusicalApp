import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:galaxy/Screens/mianscreens/bodyHome.dart';
import 'package:galaxy/Screens/home/home.dart';
import 'package:galaxy/Screens/lyrics.dart';
import 'package:galaxy/Screens/playlist.dart';
import 'package:galaxy/colors/colors.dart';
import 'package:galaxy/database/db_model.dart';
import 'package:galaxy/favorite/fav_function.dart';
import 'package:galaxy/provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Nowplaying extends StatefulWidget {
  Nowplaying(
      {super.key,
      required this.musicModel,
      required this.index,
      required this.songmodel});

  MusicModel musicModel;
  int index;
  List<MusicModel> songmodel;

  @override
  State<Nowplaying> createState() => _NowplayingState();
}

class _NowplayingState extends State<Nowplaying> {
  Duration _duration = const Duration();
  Duration _position = const Duration();
  

  bool _isplaying = false;

  @override
  void initState() {


    // TODO: implement initState
    super.initState();
      audioplayer.playerStateStream.listen((State) {
      if(State.processingState==ProcessingState.completed){
        playnext(); 


      }
    });
    playSong();
  }

  //  try{
  //

  playSong() {
    try {
     

      audioplayer.setAudioSource(
        AudioSource.uri(Uri.parse(widget.musicModel.uri!)),
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
                                color: Colormanager.icons,
                              ))),
                      Padding(
                        padding: const EdgeInsets.only(left: 70, top: 20),
                        child: Text(
                          'Playing Now',
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colormanager.titleText),
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
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40))),
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: mediaQuerry.size.height * 0.35,
                                    decoration: BoxDecoration(
                                        color: Colormanager.sheetcolor,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            topRight: Radius.circular(40))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height:
                                                mediaQuerry.size.height * 0.05,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: mediaQuerry.size.width *
                                                    0.06,
                                              ),
                                              Icon(
                                                Icons.add_circle,
                                                size: 30,
                                                color: Colormanager.sheeticon,
                                              ),
                                              SizedBox(
                                                width: mediaQuerry.size.width *
                                                    0.05,
                                              ),
                                              Text('Add to playlist',
                                                  style: TextStyle(
                                                    color:
                                                        Colormanager.sheetText,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ))
                                            ],
                                          ),
                                          SizedBox(
                                            height:
                                                mediaQuerry.size.height * 0.03,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: mediaQuerry.size.width *
                                                    0.06,
                                              ),
                                              Icon(
                                                Icons.do_not_disturb_on,
                                                size: 30,
                                                color: Colormanager.sheeticon,
                                              ),
                                              SizedBox(
                                                width: mediaQuerry.size.width *
                                                    0.05,
                                              ),
                                              Text('Remove From PLaylist',
                                                  style: TextStyle(
                                                    color:
                                                        Colormanager.sheetText,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ))
                                            ],
                                          ),
                                          SizedBox(
                                            height:
                                                mediaQuerry.size.height * 0.03,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: mediaQuerry.size.width *
                                                    0.06,
                                              ),
                                              FaIcon(
                                                FontAwesomeIcons.music,
                                                color: Colormanager.sheeticon,
                                              ),
                                              SizedBox(
                                                width: mediaQuerry.size.width *
                                                    0.05,
                                              ),
                                              Text('Go to Lyrics',
                                                  style: TextStyle(
                                                    color:
                                                        Colormanager.sheetText,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ))
                                            ],
                                          ),
                                          SizedBox(
                                            height:
                                                mediaQuerry.size.height * 0.03,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: mediaQuerry.size.width *
                                                    0.06,
                                              ),
                                              Icon(
                                                Icons.queue_music,
                                                size: 35,
                                                color: Colormanager.sheeticon,
                                              ),
                                              SizedBox(
                                                width: mediaQuerry.size.width *
                                                    0.05,
                                              ),
                                              Text('Add to Playlist',
                                                  style: TextStyle(
                                                    color:
                                                        Colormanager.sheetText,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.more_horiz,
                            color: Colormanager.sheetText,
                            size: 29,
                          ),
                          color: Colormanager.icons,
                        ),
                      )
                    ],
                  ),
                  height: mediaQuerry.size.height * 0.37,
                  width: mediaQuerry.size.width * 1,
                  decoration: const BoxDecoration(
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
                      child: const ArtWorkWiget(),
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
                  title: Text(widget.musicModel.songname,
                      maxLines: 1,
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colormanager.BalckText,
                      )),
                  subtitle: Text(
                      widget.musicModel.artistname ?? 'no artist found',
                      maxLines: 1,
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          color: Colormanager.BalckText)),
                  trailing: favSongs.contains(widget.musicModel.songid)
                      ? InkWell(
                          onTap: () {
                            removeLikedSong(widget.musicModel.songid);
                            ifLickd();
                            setState(() {});
                          },
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            addlikedSong(widget.musicModel.songid);
                            ifLickd();
                            setState(() {});
                          },
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                          ),
                        )),
            ),
            Container(
              height: 10,
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.black,
                  thumbColor: Colors.black,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
                  trackHeight: 6.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Slider(
                    value: _position.inSeconds.toDouble(),
                    max: _duration.inSeconds.toDouble(),
                    min: const Duration(microseconds: 0).inSeconds.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        changetoseconds(value.toInt());

                        value = value;
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
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colormanager.BalckText),
                  ),
                  Text(_duration.toString().split('.')[0],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colormanager.BalckText)),
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
                  // suffle
                  InkWell(
                    onTap: () {
                      shuffleSongs();
                    },
                    child: FaIcon(
                      FontAwesomeIcons.shuffle,
                      size: 20,
                      color: audioplayer.shuffleModeEnabled
                          ? Colors.blueGrey
                          : Colors.black,
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      playPrevious();
                    },
                    child: FaIcon(
                      FontAwesomeIcons.backwardStep,
                      color: Colormanager.blackicon,
                      size: 35,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (_isplaying) {
                          audioplayer.pause();
                        } else {
                          audioplayer.play();
                        }

                        _isplaying = !_isplaying;
                      });
                    },
                    child: Icon(
                      _isplaying ? Icons.pause_circle : Icons.play_circle,
                      size: 65,
                    ),
                  ),

                  //////// next

                  InkWell(
                    onTap: () {
                      playnext();
                    },
                    child: FaIcon(FontAwesomeIcons.forwardStep,
                        size: 35, color: Colormanager.blackicon),
                  ),

                  // rotate ..

                  InkWell(
                    onTap: () {
                      loopmode();
                    },
                    child: FaIcon(
                      FontAwesomeIcons.rotate,
                      size: 20,
                      color: audioplayer.loopMode == LoopMode.off
                          ? Colors.black
                          : Colors.blueGrey,
                    ),
                  ),
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
                          MaterialPageRoute(builder: (context) => const Playlist()));
                    },
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: Text(
                        'Home  ',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colormanager.BalckText),
                      ),
                    )),
                Text(
                  '|',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colormanager.BalckText),
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LyricsScreen(  index:widget.index ,songmodel:widget.songmodel , )));
                    },
                    child: Text('    Lyrics ',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colormanager.BalckText))),
              ],
            )
          ],
        ),
      ),
    );
  }

  void shuffleSongs() {
    setState(() {
      List<MusicModel> originalSongs = List.from(widget.songmodel);

      if (audioplayer.shuffleModeEnabled) {
        // If shuffle mode is already enabled, disable it and revert to the original playlist order
        audioplayer.setShuffleModeEnabled(false);
        widget.songmodel = originalSongs;
      } else {
        // If shuffle mode is disabled, enable it and shuffle the playlist starting from the current song
        audioplayer.setShuffleModeEnabled(true);
        List<MusicModel> shuffledSongs = List.from(originalSongs);
        shuffledSongs
            .removeAt(widget.index); // Remove the currently playing song
        shuffledSongs.shuffle();
        widget.songmodel = [widget.musicModel, ...shuffledSongs];

        // Only call playSong if the song is not currently playing
        if (!_isplaying) {
          playSong();
        }
      }
    });
  }

  void loopmode() {
    setState(() {
      if (audioplayer.loopMode == LoopMode.off) {
        audioplayer.setLoopMode(LoopMode.one);
      } else {
        audioplayer.setLoopMode(LoopMode.off);
      }
    });
  }

  void playnext() {
    if (widget.index < widget.songmodel.length - 1) {
      setState(() {
        widget.index++;
        widget.musicModel = widget.songmodel[widget.index];

        context.read<SongModelProvider>().setId(widget.musicModel.songid);
       
        playSong();
      });
    } else {
      setState(() {
        widget.index = 0;
        widget.musicModel = widget.songmodel[widget.index];
           context.read<SongModelProvider>().setId(widget.musicModel.songid);
        
        playSong();
      });
    }
  }

  playPrevious() {
    if (widget.index > 0) {
      setState(() {
        widget.index--;
        widget.musicModel = widget.songmodel[widget.index];
         context.read<SongModelProvider>().setId(widget.musicModel.songid);
        playSong();
      });
    } else {
      setState(() {
        widget.index = widget.songmodel.length - 1;
        widget.musicModel = widget.songmodel[widget.index];
         context.read<SongModelProvider>().setId(widget.musicModel.songid); 
        playSong();
      });
    }
  }

  void changetoseconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    audioplayer.seek(duration);
  }
}

class ArtWorkWiget extends StatelessWidget {
  const ArtWorkWiget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      
      id: context.watch<SongModelProvider>().id,
      type: ArtworkType.AUDIO,
      artworkFit: BoxFit.cover,

    );
  }
}

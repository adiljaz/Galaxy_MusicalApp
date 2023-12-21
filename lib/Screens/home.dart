import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galaxy/Screens/audio.dart';
import 'package:galaxy/Screens/bodyHome.dart';
import 'package:galaxy/Screens/database/db_functions.dart';
import 'package:galaxy/Screens/nowplaying.dart';
import 'package:galaxy/Screens/provider.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

final AudioPlayer audioplayer = AudioPlayer();

class MainHome extends StatefulWidget {
  MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
  }

  void requestPermission() {
    Permission.storage.request();
  }

  Future<List<SongModel>> fetchSongs() async {
    List<SongModel> songlist = await _audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    addSongToDb(songs: songlist);
    return songlist;
  }

  final _audioQuery = OnAudioQuery();

  playSong(String? uri) {
    try {
      audioplayer.play();

      audioplayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
    } on Exception {
      print('error parsing song ');
    }
  }

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
                      child: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 30,
                      ));
                }),
                SizedBox(
                  width: mediaQuerry.size.width * 0.28,
                ),
                const Text(
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
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 35),
                child: Container(
                  decoration: BoxDecoration(
                      color:Colors.transparent,
                      borderRadius: BorderRadius.circular(20)),
                  height: mediaQuerry.size.height * 0.3,
                  width: mediaQuerry.size.width * 0.6,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
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
                        color:Colors.transparent,
                        borderRadius: BorderRadius.circular(20)),
                    height: mediaQuerry.size.height * 0.3,
                    width: mediaQuerry.size.width * 0.6,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
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
                          borderRadius: BorderRadius.circular(30),
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
          // SizedBox(height: mediaQuerry.size.height*0.01,),
          // song fetching
          // LIst view for showing swtched screens ...

          FutureBuilder<List<SongModel>>(
            future: fetchSongs(),
            builder: (context, items) {
              if (items.data == null) {
                return const CircularProgressIndicator();
              }
              if (items.data!.isEmpty) {
                return const Center(child: Text('bsd'));
              }

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20 ),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromARGB(255, 238, 238, 238) ,),
                          
                      
                          child: ListTile(
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: QueryArtworkWidget(
                                  artworkFit: BoxFit.cover,
                                  id: items.data![index].id,
                                  type: ArtworkType.AUDIO,
                                  artworkBorder:
                                      const BorderRadius.all(Radius.circular(5)),
                                )),
                            title: Text(
                              items.data![index].displayName,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              items.data![index].artist ?? 'No Artist',
                              style: const TextStyle(fontWeight: FontWeight.w300),
                            ),
                            trailing:InkWell(   onTap: (){
                        
                        
                        
                        
                               showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(40),
                                              topRight: Radius.circular(40))),
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: mediaQuerry.size.height * 0.40 ,
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
                                                      Icons.favorite,
                                                      size: 30,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          mediaQuerry.size.width *
                                                              0.05,
                                                    ),
                                                    Text('Add to Favorite',
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
                                
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                            },    child: Image.asset('assets/more.png',height: 25, width: 25,)),
                        
                            onTap: () {
                              
                                  VisibilityManager.isVisible = true;
                        
                              // for my song container ,
                        
                              context
                                  .read<SongModelProvider>()
                                  .setId(items.data![index].id);
                              context
                                  .read<SongModelProvider>()
                                  .updateCurrentSong(items.data![index]);
                        
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Nowplaying(
                                        songModel: items.data![index],
                                      )));
                              playSong(items.data![index].uri);
                            },
                          ),
                        ),
                      );
                    },
                    itemCount: items.data!.length,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

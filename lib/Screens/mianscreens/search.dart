import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'package:galaxy/Screens/nowplaying.dart';
import 'package:galaxy/Screens/visible.dart';
import 'package:galaxy/colors/colors.dart';
import 'package:galaxy/database/db_functions.dart';
import 'package:galaxy/database/db_model.dart';
import 'package:galaxy/favorite/fav_function.dart';
import 'package:galaxy/provider/provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<MusicModel> allSongs = [];
  List<MusicModel> findmusic = [];

  @override
  void initState() {
    super.initState();
    initializeSongs();
    ifLickd();
  }

  Future<void> initializeSongs() async {
    allSongs = await getAllSongs();
    // Initially, set findmusic to all songs
    findmusic = List.from(allSongs);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuerry = MediaQuery.of(context);
    return SafeArea(
      



      child: Scaffold(
          
        
        
        backgroundColor: Colormanager.scaffoldcolor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  'Search  ',
                                  style: TextStyle(
                                    color: Colormanager.titleText,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: mediaQuerry.size.height * 0.04,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: 'Search..',
                              suffixIcon: Icon(Icons.search),
                            ),
                            onChanged: searchMusic,
                          ),
                        ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colormanager.container,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child:FutureBuilder(future:getAllSongs(), builder: (context,items){
                return    ListView.builder(
                  physics:BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()), 
                itemCount: findmusic.length,
                itemBuilder: (context, index) {
                  final music = findmusic[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colormanager.listtile,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        
                        leading: QueryArtworkWidget(
                          artworkBorder: BorderRadius.circular(5),
                          id: music.songid,
                          type: ArtworkType.AUDIO,
                          artworkQuality: FilterQuality.high,
                        ),
                        title: Text(
                          music.songname,
                          maxLines: 1,
                          style:  TextStyle(
                              fontWeight: FontWeight.bold, color: Colormanager.text),
                        ),
                        subtitle: Text(
                          music.artistname,
                          style: TextStyle(color:Colormanager.text ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            favSongs.contains(music.songid)
                                ? InkWell(
                                    onTap: () {
                                      removeLikedSong(music.songid);
                                      ifLickd();
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ))
                                : InkWell(
                                    onTap: () async {
                                      addlikedSong(music.songid);
                                      await ifLickd();
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                    )),
                            SizedBox(width: mediaQuerry.size.width*0.020,),
                             GestureDetector(
                              onTap: (){
                                showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(40),
                                                topRight: Radius.circular(40))),
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            height:
                                                mediaQuerry.size.height * 0.40,
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(40),
                                                    topRight:
                                                        Radius.circular(40))),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: mediaQuerry
                                                            .size.height *
                                                        0.05,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: mediaQuerry
                                                                .size.width *
                                                            0.06,
                                                      ),
                                                      Icon(
                                                        Icons.add_circle,
                                                        size: 30,
                                                        color: Colormanager.sheeticon,
                                                      ),
                                                      SizedBox(
                                                        width: mediaQuerry
                                                                .size.width *
                                                            0.05,
                                                      ),
                                                      Text('Add to playlist',
                                                          style: TextStyle(
                                                            color:Colormanager.sheetText,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                          ))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: mediaQuerry
                                                            .size.height *
                                                        0.03,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: mediaQuerry
                                                                .size.width *
                                                            0.06,
                                                      ),
                                                      Icon(
                                                        Icons.do_not_disturb_on,
                                                        size: 30,
                                                        color: Colormanager.sheeticon,
                                                      ),
                                                      SizedBox(
                                                        width: mediaQuerry
                                                                .size.width *
                                                            0.05,
                                                      ),
                                                      Text(
                                                          'Remove From PLaylist',
                                                          style: TextStyle(
                                                            color: Colormanager.sheetText,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                          ))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: mediaQuerry
                                                            .size.height *
                                                        0.03,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: mediaQuerry
                                                                .size.width *
                                                            0.06,
                                                      ),
                                                      FaIcon(
                                                        FontAwesomeIcons.music,
                                                        color: Colormanager.sheeticon,
                                                      ),
                                                      SizedBox(
                                                        width: mediaQuerry
                                                                .size.width *
                                                            0.05,
                                                      ),
                                                      Text('Go to Lyrics',
                                                          style: TextStyle(
                                                            color: Colormanager.sheetText,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                          ))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: mediaQuerry
                                                            .size.height *
                                                        0.03,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: mediaQuerry
                                                                .size.width *
                                                            0.06,
                                                      ),
                                                      Icon(
                                                        Icons.queue_music,
                                                        size: 35,
                                                        color: Colormanager.sheeticon,
                                                      ),
                                                      SizedBox(
                                                        width: mediaQuerry
                                                                .size.width *
                                                            0.05,
                                                      ),
                                                      Text('Go to Playlist',
                                                          style: TextStyle(
                                                            color: Colormanager.sheetText,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                          ))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: mediaQuerry
                                                            .size.height *
                                                        0.03,
                                                  ),
                                                  favSongs.contains(items.data![index].songid)?
                                                  InkWell(
                                                    onTap: (){
                                                      removeLikedSong(items.data![index].songid);
                                                      ifLickd();

                                                      


                                                      setState(() {
                                                        
                                                      });
                                                      Navigator.of(context).pop();
                                                      
                                                    },
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: mediaQuerry
                                                                  .size.width *
                                                              0.06,
                                                        ),
                                                        Icon(
                                                          Icons.favorite,
                                                          size: 30,
                                                          color: Colors.red,
                                                        ),
                                                        SizedBox(
                                                          width: mediaQuerry
                                                                  .size.width *
                                                              0.05,
                                                        ),
                                                        Text('remove from favorite',
                                                            style: TextStyle(
                                                              color: Colormanager.sheetText,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontSize: 20,
                                                            ))
                                                      ],
                                                    ),
                                                  ):InkWell(
                                                    onTap: (){
                                                      addlikedSong(items.data![index].songid);
                                                      ifLickd();
                                                      setState(() {
                                                        
                                                      });
                                                      Navigator.of(context).pop();
                                                      
                                                    },
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: mediaQuerry
                                                                  .size.width *
                                                              0.06,
                                                        ),
                                                        Icon(
                                                          Icons.favorite_border,
                                                          size: 30,
                                                          color: Colors.red, 
                                                          
                                                        ),
                                                        SizedBox(
                                                          width: mediaQuerry
                                                                  .size.width *
                                                              0.05,
                                                        ),
                                                        Text('Add to favorite',
                                                            style: TextStyle(
                                                              color: Colormanager.sheetText,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontSize: 20,
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }); 
                              },
                               child: Image.asset(
                                      'assets/more.png',
                                      color: Colors.white,
                                      height: 23,
                                      width: 23,
                                    ),
                             ),
                          ],
                        ),
                        onTap: () {
                          context
                              .read<SongModelProvider>()
                              .setId(findmusic[index].songid);
                          context
                              .read<SongModelProvider>()
                              .updateCurrentSong(findmusic[index]);

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Nowplaying(
                              musicModel:findmusic[index],
                                          index: index,
                                          songmodel: allSongs,
                                          
                                          
                             ),
                          ));
                          VisibilityManager.isVisible = true;
                        },
                      ),
                    ),
                  );
                },
              );
              })
            ),
          ],
        ),
      ),
    );
  }

  searchMusic(String query) {
    final suggestion = allSongs.where((music) {
      final songname = music.songname.toLowerCase();
      final input = query.toLowerCase();

      return songname.contains(input);
    }).toList();

    setState(() {
      findmusic = suggestion;
    });
  }
}

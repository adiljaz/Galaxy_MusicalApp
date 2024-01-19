import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:galaxy/Screens/nowplaying.dart';
import 'package:galaxy/Screens/visible.dart';
import 'package:galaxy/colors/colors.dart';
import 'package:galaxy/database/db_functions.dart';
import 'package:galaxy/database/db_model.dart';
import 'package:galaxy/favorite/fav_function.dart';
import 'package:galaxy/playlist/playlist_func.dart';
import 'package:galaxy/playlist/playlist_model.dart';
import 'package:galaxy/provider/provider.dart';
import 'package:galaxy/recently/refunction.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
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
                child: FutureBuilder(
                    future: getAllSongs(),
                    builder: (context, items) {
                      if (items.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (items.data == null || items.data!.isEmpty) {
                        return Center(
                          child: Text(
                            'Item not found ,',
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }

                      // If `findmusic` is empty, display "No songs found"
                      if (findmusic.isEmpty) {
                        return Center(
                          child: Lottie.asset('assets/search.json',)
                        );
                      }
                      return ListView.builder(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
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
                                  nullArtworkWidget: FaIcon(FontAwesomeIcons.headphonesSimple ,size: 40,color: Colormanager.container,),
                                  artworkBorder: BorderRadius.circular(5),
                                  id: music.songid,
                                  type: ArtworkType.AUDIO,
                                  artworkQuality: FilterQuality.high,
                                ),
                                title: Text(
                                  maxLines: 1,
                                  music.songname,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colormanager.text),
                                ),
                                subtitle: Text(
                                  maxLines: 1,
                                  music.artistname,
                                  style: TextStyle(color: Colormanager.text),
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
                                    SizedBox(
                                      width: mediaQuerry.size.width * 0.020,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        int playsongid =
                                            items.data![index].songid;
                                        showModalBottomSheet(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(40),
                                                    topRight:
                                                        Radius.circular(40))),
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                height:
                                                    mediaQuerry.size.height *
                                                        0.30,
                                                decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(40),
                                                            topRight:
                                                                Radius.circular(
                                                                    40))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
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
                                                                    .size
                                                                    .width *
                                                                0.06,
                                                          ),
                                                          Icon(
                                                            Icons.add_circle,
                                                            size: 30,
                                                            color: Colormanager
                                                                .sheeticon,
                                                          ),
                                                          SizedBox(
                                                            width: mediaQuerry
                                                                    .size
                                                                    .width *
                                                                0.05,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              Navigator.of(context).pop();
                                                              showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                  backgroundColor: Colormanager.scaffoldcolor,
                                                                  title: Text(
                                                                      'Playlists',style: GoogleFonts.lato(fontWeight: FontWeight.bold, color: Colors.black),),
                                                                  content:
                                                                      Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.5,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.3,
                                                                    child: FutureBuilder<
                                                                        List<
                                                                            Playlistmodel>>(
                                                                      future:
                                                                          getallPlaylist(),
                                                                      builder:
                                                                          (context,
                                                                              items) {
                                                                        if (items.connectionState ==
                                                                            ConnectionState
                                                                                .waiting) {
                                                                          return Center(
                                                                              child: CircularProgressIndicator());
                                                                        } else if (items
                                                                            .hasError) {
                                                                          return Text(
                                                                              'Error: ${items.error}');
                                                                        } else if (!items.hasData ||
                                                                            items.data!.isEmpty) {
                                                                          return Text(
                                                                              'No data available');
                                                                        } else {
                                                                          return ListView
                                                                              .builder(
                                                                            itemCount:
                                                                                items.data!.length,
                                                                            itemBuilder:
                                                                                (context, index) {
                                                                              return Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Container(
                                                                                  decoration: BoxDecoration( color: Colormanager.container,borderRadius: BorderRadius.circular(5)),
                                                                                 
                                                                                  child: ListTile(
                                                                                    onTap: () async {
                                                                                      var playlistId = items.data![index].key;
                                                                                      var songId = items.data![index].song;
                                                                                  
                                                                                      setState(() {});
                                                                                  
                                                                                      addSongToPlaylist(playlistId, playsongid);
                                                                                  
                                                                                      Navigator.of(context).pop();
                                                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(  backgroundColor: Colors.black,  content:  Text('Song added to playlist'),
                                                                                       margin:EdgeInsets.all(10), behavior: SnackBarBehavior.floating,));
                                                                                    },
                                                                                    leading: Lottie.asset('assets/sing.json', fit: BoxFit.fill),
                                                                                    title: Text(items.data![index].name,style: TextStyle(color: Colors.white),),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          );
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                            },
                                                            child: Text(
                                                                'Add to playlist',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colormanager
                                                                      .sheetText,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20,
                                                                )),
                                                          )
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
                                                                    .size
                                                                    .width *
                                                                0.06,
                                                          ),
                                                          FaIcon(
                                                            FontAwesomeIcons
                                                                .music,
                                                            color: Colormanager
                                                                .sheeticon,
                                                          ),
                                                          SizedBox(
                                                            width: mediaQuerry
                                                                    .size
                                                                    .width *
                                                                0.05,
                                                          ),
                                                           InkWell(
                                                          onTap: () {
                                                            Navigator.of(context).push(MaterialPageRoute(
                                                                builder: (context) => Nowplaying(
                                                                    musicModel:
                                                                        items.data![
                                                                            index],
                                                                    index:
                                                                        index,
                                                                    songmodel: items
                                                                        .data!)));
                                                          },
                                                          child: Text(
                                                              'Go to  song',
                                                              style: TextStyle(
                                                                color: Colormanager
                                                                    .sheetText,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20,
                                                              )),
                                                        )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: mediaQuerry
                                                                .size.height *
                                                            0.03,
                                                      ),
                                                      favSongs.contains(items
                                                              .data![index]
                                                              .songid)
                                                          ? InkWell(
                                                              onTap: () {
                                                                removeLikedSong(
                                                                    items
                                                                        .data![
                                                                            index]
                                                                        .songid);
                                                                ifLickd();

                                                                setState(() {});
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                    width: mediaQuerry
                                                                            .size
                                                                            .width *
                                                                        0.06,
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    size: 30,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                  SizedBox(
                                                                    width: mediaQuerry
                                                                            .size
                                                                            .width *
                                                                        0.05,
                                                                  ),
                                                                  Text(
                                                                      'remove from favorite',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colormanager
                                                                            .sheetText,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            20,
                                                                      ))
                                                                ],
                                                              ),
                                                            )
                                                          : InkWell(
                                                              onTap: () {
                                                                addlikedSong(items
                                                                    .data![
                                                                        index]
                                                                    .songid);
                                                                ifLickd();
                                                                setState(() {});
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  SizedBox(
                                                                    width: mediaQuerry
                                                                            .size
                                                                            .width *
                                                                        0.06,
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .favorite_border,
                                                                    size: 30,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                  SizedBox(
                                                                    width: mediaQuerry
                                                                            .size
                                                                            .width *
                                                                        0.05,
                                                                  ),
                                                                  Text(
                                                                      'Add to favorite',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colormanager
                                                                            .sheetText,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            20,
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
                                  FocusScope.of(context).unfocus();

                                  addRecentlyplayedSong(
                                      findmusic[index].songid,
                                      findmusic[index].songname,
                                      findmusic[index].artistname);

                                  context
                                      .read<SongModelProvider>()
                                      .setId(findmusic[index].songid);
                                  context
                                      .read<SongModelProvider>()
                                      .updateCurrentSong(findmusic[index]);

                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Nowplaying(
                                      musicModel: findmusic[index],
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
                    })),
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

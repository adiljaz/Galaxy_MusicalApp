import 'package:flutter/material.dart';

import 'package:galaxy/Screens/nowplaying.dart';
import 'package:galaxy/Screens/visible.dart';
import 'package:galaxy/database/db_functions.dart';
import 'package:galaxy/database/db_model.dart';
import 'package:galaxy/database/fav_function.dart';
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
                                    color: Colors.white,
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
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: findmusic.length,
                itemBuilder: (context, index) {
                  final music = findmusic[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration( color:  Color.fromARGB(255, 101, 100, 100) ,   borderRadius: BorderRadius.circular(10 )),
                      
                      child: ListTile(
                        
                        leading: QueryArtworkWidget(
                          artworkBorder: BorderRadius.circular(5),
                          id: music.songid,
                          type: ArtworkType.AUDIO,
                          artworkQuality:FilterQuality.high,
                        ),
                        title: Text(music.songname ,  maxLines: 1,
                        
                        style:
                                  
                                      const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                    
                        ),
                        subtitle: Text(music.artistname,style: TextStyle(color: Colors.white ),),
                        trailing:Row( mainAxisSize: MainAxisSize.min,            children: [ favSongs.contains(music.songid)?  InkWell( onTap: (){
                          removeLikedSong(music.songid);
                          ifLickd();
                          setState(() {
                            
                          });

                        }, child: Icon( Icons.favorite,color: Colors.red,)):InkWell( onTap: () async{
                          addlikedSong(music.songid);
                        await  ifLickd();
                        setState(() {
                          
                        });
                         
                        },  child: Icon(Icons.favorite,color: Colors.white,)), Text('  '),   Icon(Icons.play_circle,color: Colors.white,)],),
                        onTap: () {

                          
                                   context
                                  .read<SongModelProvider>()
                                  .setId(findmusic[index].songid);
                                    context
                                  .read<SongModelProvider>()
                                  .updateCurrentSong(findmusic[index]); 

                          

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Nowplaying(musicModel: music),
                          ));
                           VisibilityManager.isVisible = true;
 
                        },
                      ),
                    ),
                  );
                },
              ),
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

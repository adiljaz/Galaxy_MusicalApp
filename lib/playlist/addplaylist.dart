import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galaxy/Screens/nowplaying.dart';
import 'package:galaxy/Screens/visible.dart';
import 'package:galaxy/colors/colors.dart';
import 'package:galaxy/database/db_functions.dart';
import 'package:galaxy/database/db_model.dart';
import 'package:galaxy/playlist/playlist_func.dart';

import 'package:galaxy/provider/provider.dart';
import 'package:galaxy/recently/refunction.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class AddtoPlaylist extends StatefulWidget {
    AddtoPlaylist({super.key , required this.playlistid});



  int playlistid;

  @override
  State<AddtoPlaylist> createState() => _AddtoPlaylistState();
}

class _AddtoPlaylistState extends State<AddtoPlaylist> {

  late Future <List<MusicModel>> songsFuture; 


  @override
  void initState() {
    // TODO: implement initState

    songsFuture=getAllSongs();
    super.initState();
  }



     
  @override
  Widget build(BuildContext context) {

    MediaQueryData mediaQuerry= MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colormanager.scaffoldcolor,
      body:SafeArea(
        child: Column(
          children: [
          Stack(
                children: [
                  Container(
                    height: mediaQuerry.size.height * 0.2,
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
                                  icon: const FaIcon(
                                    FontAwesomeIcons.circleChevronLeft,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: mediaQuerry.size.width * 0.25,
                                ),
                              ],
                            ),
                            Center(
                              child: Text(
                               'Add to playlist',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
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
                child: FutureBuilder(
                    future: songsFuture,
                    builder: (context, item) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colormanager.listtile,
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                  leading: ClipRRect(
                                      child: QueryArtworkWidget(
                                    id: item.data![index].songid,
                                    type: ArtworkType.AUDIO,
                                    artworkFit: BoxFit.cover,
                                    artworkBorder: BorderRadius.circular(5),
                                  )),
                                  title: Text(
                                    item.data![index].songname,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colormanager.text),
                                  ),
                                  subtitle: Text(
                                    item.data![index].artistname,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colormanager.text),
                                  ),
                                  onTap: () {
                                    addRecentlyplayedSong(
                                        item.data![index].songid,
                                        item.data![index].songname,
                                        item.data![index].artistname);

                                    context
                                        .read<SongModelProvider>()
                                        .setId(item.data![index].songid);
                                    context
                                        .read<SongModelProvider>()
                                        .updateCurrentSong(item.data![index]);

                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => Nowplaying(
                                                  musicModel: item.data![index],
                                                  index: index,
                                                  songmodel: item.data!,
                                                )));
                                    VisibilityManager.isVisible = true;

                                    // to now play screen
                                  },
                                  trailing: _buildTrialingbutton(item.data![index] )),
                            ),
                          );
                        },
                        itemCount: item.data!.length,
                      );
                    })),


        ]),
      ) ,
    );
  }

 Widget _buildTrialingbutton(MusicModel song) {
  return FutureBuilder<bool>(
    future: ifSongContain(song, widget.playlistid),
    builder: (context, items) {
      if (items.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (items.hasError) {
        return Icon(Icons.error, color: Colors.red);
      }

      bool songisPlaylist = items.data ?? false;
      return IconButton(
        onPressed: () async {


          if (songisPlaylist) {
           setState(() {
              
           });
              deleteSongFromPlaylist(widget.playlistid, song.songid);
           
          } else {
           
            setState(() {
                addSongToPlaylist(widget.playlistid, song.songid);
          
            });
          }
        },
        icon: Icon( songisPlaylist ? Icons.remove  : Icons.add),
      );
    },
  );
}

}




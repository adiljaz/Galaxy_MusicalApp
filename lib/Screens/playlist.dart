// ignore_for_file: sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galaxy/Screens/nowplaying.dart';
import 'package:galaxy/colors/colors.dart';
import 'package:galaxy/playlist/addplaylist.dart';
import 'package:galaxy/playlist/playlist_func.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../database/db_model.dart';

class Playlist extends StatefulWidget {
  Playlist({Key? key, required this.playlistId, required this.playlistname});

  final int playlistId;
  final String playlistname;

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuerry = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colormanager.scaffoldcolor,
        body: Column(
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
                              widget.playlistname.toString(),
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
            SizedBox(
              height: mediaQuerry.size.height * 0.03,
            ),
            Expanded(
              child: FutureBuilder<List<MusicModel>>(
                future: getPlaylistSongs(widget.playlistId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.data == null) {
                    return Center(child: Text('No data available'));
                  } else if (snapshot.data!.isEmpty) {
                    return Center(child: Text('No songs in the playlist'));
                  } else {
                    // Use ListView.builder to show a list without a separator
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colormanager.listtile,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                               ListTile(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                    return  Nowplaying(
                                    musicModel: snapshot.data![index],
                                    index: index,
                                    songmodel: snapshot.data!);
                                  }));

                                },
                                leading: ClipRRect(
                                  child: QueryArtworkWidget(

                                    nullArtworkWidget: FaIcon(FontAwesomeIcons.headphonesSimple ,size: 40,color: Colormanager.container,), 
                                    id: snapshot.data![index].songid,
                                    type: ArtworkType.AUDIO,
                                    artworkFit: BoxFit.cover,
                                    artworkBorder: BorderRadius.circular(5),
                                  ),
                                ),
                                title: Text(
                                  snapshot.data![index].songname,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colormanager.text,
                                  ),
                                ),
                                subtitle: Text(
                                  snapshot.data![index].artistname,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Colormanager.text,
                                  ),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    
                                  deleteSongFromPlaylist(widget.playlistId,snapshot.data![index].songid);

                                  setState(() {
                                    
                                  });
                                  
                                  },
                                  child: Icon(Icons.close,size: 25,)
                                ),
                               
                              ),
                            
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton( backgroundColor: Colormanager.BalckText,  onPressed: (){

          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddtoPlaylist(playlistid:widget.playlistId,)))..then((value) {
            setState(() {
               
            });
          });

          
        }, child: Icon(Icons.add ,color: Colormanager.text,),),

        
      ),
    );
  }
}


// ignore_for_file: sort_child_properties_last, file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galaxy/Screens/nowplaying.dart';
import 'package:galaxy/Screens/visible.dart';
import 'package:galaxy/colors/colors.dart';
import 'package:galaxy/database/db_functions.dart';
import 'package:galaxy/favorite/fav_function.dart';

import 'package:galaxy/provider/provider.dart';
import 'package:galaxy/recently/refunction.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class Allsongs extends StatefulWidget {
  const Allsongs({super.key});

  @override
  State<Allsongs> createState() => _AllsongsState();
}

class _AllsongsState extends State<Allsongs> {
    
  @override
  void initState() {  
 getAllSongs() ;

  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuerry = MediaQuery.of(context);
    return SafeArea(
    
      child: Scaffold(
        backgroundColor:Colormanager.scaffoldcolor,
        
        body:Column(
          children: [
            Container(
              child: Center(child: Text('All songs',  style: TextStyle(  color: Colormanager.titleText,  fontWeight: FontWeight.bold,fontSize: 20),),),
              height: mediaQuerry.size.height*0.1,
              width: double.infinity,
              decoration: const BoxDecoration(  color: Colors.black,   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40))),

            ),
            Expanded(
              child: FutureBuilder(future: getAllSongs(), builder: (context,item){
                return  ListView.builder(
                   physics:const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()), 
                itemBuilder: (context, index) {
                  return Padding(
                  
                    padding: const EdgeInsets.all(8.0),
                    child: Container( 
                      decoration: BoxDecoration(color: Colormanager.listtile , borderRadius: BorderRadius.circular(10)),
                      
                      child: ListTile(
                        
                        leading: ClipRRect(child: QueryArtworkWidget( id:  item.data![index].songid, type: ArtworkType.AUDIO,artworkFit: BoxFit.cover,artworkBorder: BorderRadius.circular(5),)),
                        title: Text(item.data![index].songname, maxLines: 1, style:
                              
                                  TextStyle(fontWeight: FontWeight.bold,color:Colormanager.text), ),
                        subtitle: Text(item.data![index].artistname,style:
                                   TextStyle(fontWeight: FontWeight.w300,color:Colormanager.text),),
                        
                        onTap: (){

                          addRecentlyplayedSong(item.data![index].songid, item.data![index].songname, item.data![index].artistname);

                           context
                                  .read<SongModelProvider>() 
                                  .setId(item.data![index].songid);
                                    context
                                  .read<SongModelProvider>()
                                  .updateCurrentSong(item.data![index]); 

                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Nowplaying(musicModel: item.data![index],index: index,songmodel:item.data!,)));
                           VisibilityManager.isVisible = true;
  

                          // to now play screen
                        },trailing:  GestureDetector(
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
                                                        color: Colormanager
                                                            .sheeticon,
                                                      ),
                                                      SizedBox(
                                                        width: mediaQuerry
                                                                .size.width *
                                                            0.05,
                                                      ),
                                                      Text('Add to playlist',
                                                          style: TextStyle(
                                                            color: Colormanager
                                                                .sheetText,
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
                                                        color: Colormanager
                                                            .sheeticon,
                                                      ),
                                                      SizedBox(
                                                        width: mediaQuerry
                                                                .size.width *
                                                            0.05,
                                                      ),
                                                      Text(
                                                          'Remove From PLaylist',
                                                          style: TextStyle(
                                                            color: Colormanager
                                                                .sheetText,
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
                                                        color: Colormanager
                                                            .sheeticon,
                                                      ),
                                                      SizedBox(
                                                        width: mediaQuerry
                                                                .size.width *
                                                            0.05,
                                                      ),
                                                      Text('Go to Lyrics',
                                                          style: TextStyle(
                                                            color: Colormanager
                                                                .sheetText,
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
                                                        color: Colormanager
                                                            .sheeticon,
                                                      ),
                                                      SizedBox(
                                                        width: mediaQuerry
                                                                .size.width *
                                                            0.05,
                                                      ),
                                                      Text('Go to Playlist',
                                                          style: TextStyle(
                                                            color: Colormanager
                                                                .sheetText,
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
                                                  favSongs.contains(item
                                                          .data![index].songid)
                                                      ? InkWell(
                                                          onTap: () {
                                                            removeLikedSong(
                                                                item
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
                                                                Icons.favorite,
                                                                size: 30,
                                                                color:
                                                                    Colors.red,
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
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        20,
                                                                  ))
                                                            ],
                                                          ),
                                                        )
                                                      : InkWell(
                                                          onTap: () {
                                                            addlikedSong(item
                                                                .data![index]
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
                                                                color:
                                                                    Colors.red,
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
                                                                        FontWeight
                                                                            .bold,
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
                                      height: 25,
                                      width: 25,
                                    ),
                        )
                      ),
                    ),
                  );
                },
                itemCount:item.data!.length,
              );
              })
            ),
          ],
        ),
      ),
    );
  }
}

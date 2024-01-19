// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:galaxy/Screens/nowplaying.dart';

import 'package:galaxy/colors/colors.dart';

import 'package:galaxy/favorite/fav_function.dart';
import 'package:galaxy/provider/provider.dart';
import 'package:galaxy/recently/refunction.dart';
import 'package:lottie/lottie.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class LikedSongs extends StatefulWidget {
  const LikedSongs({super.key});

  @override
  State<LikedSongs> createState() => _LikedSongsState();
}

class _LikedSongsState extends State<LikedSongs> {
  @override
  void initState() {
    showLike();
    ifLickd(); 
    
    // TODO: implement initState
    super.initState();
  }

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
                

                  
                  
                  height: mediaQuerry.size.height * 0.27,
                  // ignore: sort_child_properties_last
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
                                )),
                            SizedBox(
                              width: mediaQuerry.size.width * 0.2,
                            ),
                            Center(
                                child: Text(
                              'Liked Songs',
                              style: TextStyle(
                                  color: Colormanager.titleText,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ))
                          ],
                        ),
                        SizedBox(
                          height: mediaQuerry.size.height * 0.04,
                        ),
                       
                      ],
                    ),
                  )),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/pexels3.jpg',),fit: BoxFit.cover),
                      color: Colormanager.container,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                ),
              ],
            ),
            SizedBox(
              height: mediaQuerry.size.height * 0.03,
            ),
            Expanded(
                child: FutureBuilder(
                    future: showLike(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.data!.isEmpty) {
                        return Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset('assets/likecount.json',
                                height: 200, width: 200),
                          ],
                        ));
                      } else {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colormanager.listtile,
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  leading: QueryArtworkWidget(nullArtworkWidget: FaIcon(FontAwesomeIcons.headphonesSimple ,size: 40,color: Colormanager.container,), 

                                    artworkBorder: BorderRadius.circular(4),
                                    id: snapshot.data![index].songid,
                                    type: ArtworkType.AUDIO,
                                  ),
                                  title: Text(
                                    maxLines: 1,
                                    snapshot.data![index].songname,
                                    style: TextStyle(color: Colormanager.text),
                                  ),
                                  subtitle: Text(
                                      snapshot.data![index].artistname,
                                      style:
                                          TextStyle(color: Colormanager.text)),
                                  trailing: favSongs.contains(
                                          snapshot.data![index].songid)
                                      ? InkWell(
                                          onTap: () {
                                            removeLikedSong(
                                                snapshot.data![index].songid);
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
                                            addlikedSong(
                                                snapshot.data![index].songid);
                                            ifLickd();
                                            setState(() {});
                                          },
                                          child: const Icon(
                                            Icons.favorite,
                                            color: Colors.white ,
                                          ),
                                        ),
                                  onTap: () {
                                    context
                                        .read<SongModelProvider>()
                                        .setId(snapshot.data![index].songid);
                                    context
                                        .read<SongModelProvider>()
                                        .updateCurrentSong(
                                            snapshot.data![index]);

                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Nowplaying(
                                                musicModel:
                                                    snapshot.data![index],
                                                index: index,
                                                songmodel: snapshot.data!)))
                                      ..then((value) {
                                        setState(() {});
                                      });

                                    addRecentlyplayedSong(
                                        snapshot.data![index].songid,
                                        snapshot.data![index].songname,
                                        snapshot.data![index].artistname);
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }
}

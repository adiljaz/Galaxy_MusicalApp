import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galaxy/Screens/nowplaying.dart';
import 'package:galaxy/colors/colors.dart';
import 'package:galaxy/provider/provider.dart';
import 'package:galaxy/recently/refunction.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class RecentlyPlayed extends StatefulWidget {
  const RecentlyPlayed({
    super.key,
  });

  @override
  State<RecentlyPlayed> createState() => _RecentlyPlayedState();
}

class _RecentlyPlayedState extends State<RecentlyPlayed> {
  @override
  void initState() {
    loadRecentlyplayedsongs();

    
    super.initState();
  }

  void loadRecentlyplayedsongs() {
    showRecentSong();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuerry = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colormanager.scaffoldcolor,
      body: Column(
        children: [
          Container(
            height: mediaQuerry.size.height * 0.2,
            decoration: BoxDecoration(
                color: Colormanager.container,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15,top: 15),
                        child: const FaIcon(
                          FontAwesomeIcons.circleArrowLeft,
                          color: Colors.white,
                        ),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Recently Played ',
                      style: GoogleFonts.lato(
                          color: Colormanager.titleText,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: mediaQuerry.size.height * 0.03,
          ),
          Expanded(
              child: FutureBuilder(
                  future: showRecentSong(),
                  builder: (context, items) {
  if (items.connectionState == ConnectionState.waiting) {
    // Data is still loading
    return Center(
      child: CircularProgressIndicator(),
    );
  } else if (items.hasError) {
    // Handle error case if needed
    return Center(
      child: Text('Error loading data'),
    );
  } else if (items.data!.isEmpty) {
    // Handle error case if needed
    return Center(
      child: Text('No songs here'),
    );
  }else {
    // Data is loaded, build the ListView
    return ListView.builder(
      itemCount: items.data!.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colormanager.listtile,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ListTile(
              leading: QueryArtworkWidget(
                nullArtworkWidget: FaIcon(FontAwesomeIcons.headphonesSimple, size: 40, color: Colormanager.container,),
                id: items.data![index].songid,
                type: ArtworkType.AUDIO,
                artworkBorder: BorderRadius.circular(2),
              ),
              title: Text(
                items.data![index].songname,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colormanager.text,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                items.data![index].artistname,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colormanager.text,
                    fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {});
                  deleteRecentSong(items.data![index].songid);
                },
                icon: Icon(Icons.close, color: Colormanager.BalckText,),
              ),
              onTap: () {
                context
                    .read<SongModelProvider>()
                    .setId(items.data![index].songid);
                context
                    .read<SongModelProvider>()
                    .updateCurrentSong(items.data![index]);

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Nowplaying(
                        musicModel: items.data![index],
                        index: index,
                        songmodel: items.data!)));

                addRecentlyplayedSong(
                    items.data![index].songid, items.data![index].songname, items.data![index].artistname);
              },
            ),
          ),
        );
      },
    );
  }
},
 )),
        ],
      ),
    ));
  }
}




//  if (snapshot.data == null) {
//                         return const Center(child: CircularProgressIndicator());
//                       } else if (snapshot.data!.isEmpty) {
//                         return  Center(child:Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Lottie.asset('assets/likecount.json',height:200,width: 200),
                            
//                           ],
//                         ) );
//                       } else {
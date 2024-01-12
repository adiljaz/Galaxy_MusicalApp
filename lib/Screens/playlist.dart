// ignore_for_file: sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galaxy/colors/colors.dart';
import 'package:galaxy/playlist/playlist_func.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../database/db_model.dart';

// ignore: must_be_immutable,
class Playlist extends StatelessWidget {

  Playlist({super.key, required this.playlistId, required this.playlistname});

  final int playlistId;

  final String playlistname;

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
                                )),
                            SizedBox(
                              width: mediaQuerry.size.width * 0.25,
                            ),
                          ],
                        ),
                        Center(
                          child: Text(
                            playlistname.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  )),
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                ),
              ],
            ),
            SizedBox(
              height: mediaQuerry.size.height * 0.03,
            ),
            Expanded(
              child: FutureBuilder<List<MusicModel>>(
                // Update this to get playlist songs instead of all songs
                future: getPlaylistSong(
                    playlistId), // Replace 'playlistId' with the actual playlist ID
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    // Use ListView.separated to show a separator between items
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colormanager.listtile,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              // ... your ListTile content here ...

                              // You can directly access snapshot.data for the list of songs
                              leading: ClipRRect(
                                child: QueryArtworkWidget(
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
                              onTap: () {
                                // ... your onTap logic here ...
                              },
                              trailing: GestureDetector(
                                onTap: () {
                                  // ... your onTap logic here ...
                                },
                                child: Image.asset(
                                  'assets/more.png',
                                  color: Colors.white,
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          Divider(), // Add a divider
                      itemCount: snapshot.data!.length,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:galaxy/Screens/bodyHome.dart';
import 'package:galaxy/Screens/database/db_functions.dart';
import 'package:galaxy/Screens/nowplaying.dart';
import 'package:galaxy/Screens/provider.dart';
import 'package:galaxy/Screens/visible.dart';
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
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20)),
                  height: mediaQuerry.size.height * 0.3,
                  width: mediaQuerry.size.width * 0.6,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
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
                        color: const Color.fromARGB(255, 255, 7, 7),
                        borderRadius: BorderRadius.circular(20)),
                    height: mediaQuerry.size.height * 0.3,
                    width: mediaQuerry.size.width * 0.6,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
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
                          borderRadius: BorderRadius.circular(20),
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
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: QueryArtworkWidget(
                              artworkFit: BoxFit.cover,
                              id: items.data![index].id,
                              type: ArtworkType.AUDIO,
                              artworkBorder:
                                  const BorderRadius.all(Radius.circular(3)),
                            )),
                        title: Text(
                          items.data![index].displayName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          items.data![index].artist ?? 'No Artist',
                          style: const TextStyle(fontWeight: FontWeight.w300),
                        ),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.more_horiz,
                              color: Colors.black,
                              size: 30,
                            )),
                        onTap: () {
                          VisibilityManager.isVisible =
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

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galaxy/colors/colors.dart';
import 'package:galaxy/database/fav_function.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LikedSongs extends StatelessWidget {
  const LikedSongs({super.key});

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
                  height: mediaQuerry.size.height * 0.25,
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
                        TextFormField(
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: 'Search..',
                              suffixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              )),
                        ),
                      ],
                    ),
                  )),
                  decoration: BoxDecoration(
                      color: Colormanager.container,
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
                child: FutureBuilder(
              future: showLike(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color:Colormanager.listtile, 
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          leading: QueryArtworkWidget(
                            artworkBorder: BorderRadius.circular(4),
                            id: snapshot.data![index].songid,
                            type: ArtworkType.AUDIO,
                          ),
                          title: Text(snapshot.data![index].songname,style: TextStyle(color: Colormanager.text),),
                          subtitle: Text(snapshot.data![index].artistname, style: TextStyle(color: Colormanager.text)),
                          trailing: Icon(Icons.favorite),
                        ),
                      ),
                    );
                  },
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}

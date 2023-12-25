import 'package:flutter/material.dart';
import 'package:galaxy/Screens/nowplaying.dart';
import 'package:galaxy/database/db_functions.dart';
import 'package:galaxy/database/db_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Allsongs extends StatefulWidget {
  const Allsongs({super.key});

  @override
  State<Allsongs> createState() => _AllsongsState();
}

class _AllsongsState extends State<Allsongs> {
  late List<MusicModel> Allsongs;
  @override
  void initState() {
    Allsongs = getAllSongs();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuerry = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        
        body: Column(
          children: [
            Container(
              child: Center(child: Text('All songs',  style: TextStyle(  color: Colors.white,  fontWeight: FontWeight.bold,fontSize: 25),),),
              height: mediaQuerry.size.height*0.1,
              width: double.infinity,
              decoration: BoxDecoration(  color: Colors.black,   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40))),

            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                  
                    padding: const EdgeInsets.all(8.0),
                    child: Container( 
                      decoration: BoxDecoration(color: Colors.black  , borderRadius: BorderRadius.circular(10)),
                      
                      child: ListTile(
                        
                        leading: ClipRRect(child: QueryArtworkWidget(id:Allsongs[index].songid, type: ArtworkType.AUDIO,artworkFit: BoxFit.cover,artworkBorder: BorderRadius.circular(5),)),
                        title: Text(Allsongs[index].songname, maxLines: 1, style:
                              
                                  const TextStyle(fontWeight: FontWeight.bold,color: Colors.white), ),
                        subtitle: Text(Allsongs[index].artistname,style:
                                  const TextStyle(fontWeight: FontWeight.w300,color: Colors.white),),
                        
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Nowplaying(musicModel: Allsongs[index] )));

                          // to now play screen
                        },trailing: Icon(Icons.play_circle ,color: Colors.white,size:30,),
                      ),
                    ),
                  );
                },
                itemCount: Allsongs.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

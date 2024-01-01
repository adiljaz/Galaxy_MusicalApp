import 'package:flutter/material.dart';
import 'package:galaxy/Screens/nowplaying.dart';
import 'package:galaxy/Screens/visible.dart';
import 'package:galaxy/colors/colors.dart';
import 'package:galaxy/database/db_functions.dart';

import 'package:galaxy/provider/provider.dart';
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

    // TODO: implement initState
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
              child: Center(child: Text('All songs',  style: TextStyle(  color: Colormanager.titleText,  fontWeight: FontWeight.bold,fontSize: 25),),),
              height: mediaQuerry.size.height*0.1,
              width: double.infinity,
              decoration: BoxDecoration(  color: Colors.black,   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40))),

            ),
            Expanded(
              child: FutureBuilder(future: getAllSongs(), builder: (context,item){
                return  ListView.builder(
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

                           context
                                  .read<SongModelProvider>() 
                                  .setId(item.data![index].songid);
                                    context
                                  .read<SongModelProvider>()
                                  .updateCurrentSong(item.data![index]); 

                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Nowplaying(musicModel: item.data![index],index: index,songmodel:item.data!,)));
                           VisibilityManager.isVisible = true;
  

                          // to now play screen
                        },trailing: Icon(Icons.play_circle ,color:Colormanager.icons,size:30,),
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

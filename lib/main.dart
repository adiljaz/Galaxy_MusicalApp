import 'package:flutter/material.dart';
import 'package:galaxy/Screens/Splash.dart';
import 'package:galaxy/database/db_model.dart';
import 'package:galaxy/favorite/fav_model.dart';
import 'package:galaxy/playlist/playlist_model.dart';
import 'package:galaxy/provider/provider.dart';
import 'package:galaxy/recently/recent.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(MusicModelAdapter().typeId)) {
    Hive.registerAdapter(MusicModelAdapter());
  }

  
 if(!Hive.isAdapterRegistered(LikedSongModelAdapter().typeId)){
  Hive.registerAdapter(LikedSongModelAdapter());
 }


if(!Hive.isAdapterRegistered(RecentmodelAdapter().typeId)){
  Hive.registerAdapter(RecentmodelAdapter()); 
}

if(!Hive.isAdapterRegistered(PlaylistmodelAdapter().typeId)){
  Hive.registerAdapter(PlaylistmodelAdapter());
}



  runApp(ChangeNotifierProvider(
    create: (context) => SongModelProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Galaxy',
      home: const SplashScreen(),
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
    );
  }
}
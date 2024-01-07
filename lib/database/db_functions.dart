import 'package:galaxy/database/db_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

addSongToDb({required List<SongModel> songs}) async {
  final songDb = await Hive.openBox<MusicModel>('song_model');

  if (songDb.isEmpty) {
    for (SongModel s in songs) {
      songDb.add(MusicModel(
          artistname: s.artist.toString(),
          songid: s.id,
          songname: s.title,
          uri: s.uri.toString()));
    }
  }

  for (MusicModel s in songDb.values) {
    print(s.artistname);
  }
}

Future<List<MusicModel>> getAllSongs() async {
  final songDb = await Hive.openBox<MusicModel>('song_model');
   print("All Songs: $songDb");

  return songDb.values.toList();
  
}






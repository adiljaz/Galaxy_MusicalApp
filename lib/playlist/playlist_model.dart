
import 'package:hive_flutter/hive_flutter.dart';
 part 'playlist_model.g.dart';

@HiveType(typeId: 3)
class Playlistmodel extends HiveObject{
  @HiveField(0)
   String  name ;
  @HiveField(1)
   List<String> song ;
  Playlistmodel({required this.name, required this.song}); 
}
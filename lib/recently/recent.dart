
import 'package:hive_flutter/hive_flutter.dart';
    part 'recent.g.dart';
    
  
  
@HiveType(typeId: 2)
class Recentmodel{

  @HiveField(0)
  int songId;
  @HiveField(1)
  String name;
  @HiveField(2)
  String artistname;
  Recentmodel({required this.songId, required this.name,required this.artistname});

}
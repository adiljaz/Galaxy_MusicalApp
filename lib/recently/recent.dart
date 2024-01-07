
import 'package:hive_flutter/hive_flutter.dart';
    part 'recent.g.dart';
    
  
  
@HiveType(typeId: 2)
class Recentlyplayed{

  @HiveField(0)
  String songId;
  @HiveField(1)
  String name;
  Recentlyplayed({required this.songId, required this.name});

}
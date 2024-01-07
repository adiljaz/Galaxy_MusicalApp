// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentlyplayedAdapter extends TypeAdapter<Recentlyplayed> {
  @override
  final int typeId = 2;

  @override
  Recentlyplayed read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recentlyplayed(
      songId: fields[0] as String,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Recentlyplayed obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.songId)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentlyplayedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

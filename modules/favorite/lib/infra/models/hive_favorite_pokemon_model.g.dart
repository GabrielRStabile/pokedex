// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_favorite_pokemon_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveFavoritePokemonModelAdapter
    extends TypeAdapter<HiveFavoritePokemonModel> {
  @override
  final int typeId = 1;

  @override
  HiveFavoritePokemonModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveFavoritePokemonModel(
      name: fields[0] as String,
      imageUrl: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveFavoritePokemonModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveFavoritePokemonModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

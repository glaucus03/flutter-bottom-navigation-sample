// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TabModelAdapter extends TypeAdapter<TabModel> {
  @override
  final int typeId = 0;

  @override
  TabModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TabModel(
      id: fields[0] as int,
      iconCode: fields[1] as int,
      label: fields[2] as String,
      isSelected: fields[3] as bool,
      pageKey: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TabModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.iconCode)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(3)
      ..write(obj.isSelected)
      ..writeByte(4)
      ..write(obj.pageKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TabModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

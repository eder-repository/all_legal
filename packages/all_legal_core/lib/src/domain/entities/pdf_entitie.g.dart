// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_entitie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PdfEntitieAdapter extends TypeAdapter<PdfEntitie> {
  @override
  final int typeId = 0;

  @override
  PdfEntitie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PdfEntitie(
      filePath: fields[0] as String,
      pdfData: fields[1] as Uint8List,
    );
  }

  @override
  void write(BinaryWriter writer, PdfEntitie obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.filePath)
      ..writeByte(1)
      ..write(obj.pdfData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PdfEntitieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

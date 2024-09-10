import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'pdf_entitie.g.dart';

@HiveType(typeId: 0)
class PdfEntitie extends HiveObject {
  @HiveField(0)
  String filePath;
  @HiveField(1)
  Uint8List pdfData;

  PdfEntitie({required this.filePath, required this.pdfData});
}

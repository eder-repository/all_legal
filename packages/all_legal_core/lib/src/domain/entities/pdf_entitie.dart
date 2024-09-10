import 'package:hive/hive.dart';

part 'pdf_entitie.g.dart';

@HiveType(typeId: 0)
class PdfEntitie extends HiveObject {
  @HiveField(0)
  String filePath;

  PdfEntitie({required this.filePath});
}

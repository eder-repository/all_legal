import 'package:all_legal_core/src/domain/entities/pdf_entitie.dart';

abstract class IUploadDocumentRepository {
  Future<bool?> uploadDocument();

  Future<List<PdfEntitie>> getSavedPDFs();

  Future<bool?> deletePdf(int index);

  Future<bool?> saveSignature();

  Future<List<PdfEntitie>> getSignature();

  Future<bool?> deleteSignature(int index);
}

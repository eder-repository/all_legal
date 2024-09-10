import 'dart:io';

import 'package:all_legal_core/all_legal_core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UploadDocumentRepository implements IUploadDocumentRepository {
  @override
  Future<bool?> uploadDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        final pdfData = await file.readAsBytes();

        // Guarda la ruta del archivo en un modelo PDF
        PdfEntitie pdf = PdfEntitie(filePath: file.path, pdfData: pdfData);

        // Abre o crea una caja Hive para almacenar PDFs

        var box = await Hive.openBox<PdfEntitie>('pdfs');

        // Agrega el PDF a la caja
        await box.add(pdf);
        return true;
      }
    } catch (e) {
      return false;
    }
    return null;
  }

  // Recuperar archivos PDF guardados
  Future<List<PdfEntitie>> getSavedPDFs() async {
    var box = await Hive.openBox<PdfEntitie>('pdfs');
    return box.values.toList();
  }

  @override
  Future<bool?> deletePdf(int index) async {
    try {
      var box = await Hive.openBox<PdfEntitie>('pdfs');
      box.deleteAt(index);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool?> deleteSignature(int index) async {
    try {
      var box = await Hive.openBox<PdfEntitie>('images');
      box.deleteAt(index);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<PdfEntitie>> getSignature() async {
    var box = await Hive.openBox<PdfEntitie>('images');
    return box.values.toList();
  }

  @override
  Future<bool?> saveSignature() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        final pdfData = await file.readAsBytes();

        PdfEntitie pdf = PdfEntitie(filePath: file.path, pdfData: pdfData);

        var box = await Hive.openBox<PdfEntitie>('images');

        await box.add(pdf);
        return true;
      }
    } catch (e) {
      return false;
    }
    return null;
  }
}

import 'package:all_legal_core/all_legal_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'src/core/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Hive
  var appDocumentDir = await getApplicationDocumentsDirectory();

  await Hive.initFlutter(appDocumentDir.path);

  // Registra el adaptador generado automáticamente
  Hive.registerAdapter(PdfEntitieAdapter());

  final uploadDocument = UploadDocumentRepository();
  runApp(AllLegalApp(
    iUploadDocumentRepository: uploadDocument,
  ));
}

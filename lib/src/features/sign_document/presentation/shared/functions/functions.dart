import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf_image_renderer/pdf_image_renderer.dart';

Future<Uint8List> loadImageBytes(String filePath) async {
  final file = File(filePath);
  if (!await file.exists()) {
    throw Exception("File does not exist");
  }
  return await file.readAsBytes();
}

Future<Uint8List> loadPageImage(String pdfData, int pageIndex) async {
  final pdf = PdfImageRendererPdf(path: pdfData);
  await pdf.open();

  // Verificar que el índice de página esté dentro del rango válido

  final img = await pdf.renderPage(
    pageIndex: pageIndex,
    x: 0,
    y: 0,
    width: 600, // you can pass a custom size here to crop the image
    height: 800, // you can pass a custom size here to crop the image
    scale: 1, // increase the scale for better quality (e.g. for zooming)
    background: Colors.white,
  );
  return img!;
}

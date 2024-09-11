import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:all_legal/src/features/features.dart';
import 'package:all_legal/src/i18n/translations.g.dart';
import 'package:all_legal_core/all_legal_core.dart';
import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdfx/pdfx.dart' as pdfx;

class PositionSignature extends StatefulWidget {
  const PositionSignature({
    super.key,
    required this.pdfs,
    required this.tabController,
  });

  final List<PdfEntitie> pdfs;

  final TabController tabController;

  @override
  State<PositionSignature> createState() => _PositionSignatureState();
}

class _PositionSignatureState extends State<PositionSignature> {
  late PageController _pageController;

  late Future<List<Uint8List>> _pdfsFuture;
  final _imagePositions = ValueNotifier<Map<int, Set<Offset>>>({});

  final indexPage = ValueNotifier<int>(0);
  final loadingGeneratePdf = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pdfsFuture = _loadDocument();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<Uint8List> readPdfFileBytes(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      return await file.readAsBytes();
    } else {
      throw Exception('File not found: $filePath');
    }
  }

  Future<List<Uint8List>> _loadDocument() async {
    return Future.value(
        widget.pdfs.map((filePath) => filePath.pdfData).toList());
  }

  void _alertDialog(BuildContext context, {required VoidCallback onConfirm}) {
    final texts = context.texts.sign.sign;
    return AlAlertDigalog.showCustomDialog(context,
        title: texts.changePdf, description: texts.alert, onConfirm: onConfirm);
  }

  void _goToPreviousPage() {
    if (_imagePositions.value.isNotEmpty) {
      _alertDialog(
        context,
        onConfirm: () {
          _imagePositions.value = {};
          Navigator.pop(context);
          if (_pageController.hasClients) {
            final currentPage = _pageController.page?.toInt() ?? 0;
            if (currentPage > 0) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          }
        },
      );
    } else {
      if (_pageController.hasClients) {
        final currentPage = _pageController.page?.toInt() ?? 0;
        if (currentPage > 0) {
          _pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    }
  }

  void _goToNextPage() {
    if (_imagePositions.value.isNotEmpty) {
      _alertDialog(
        context,
        onConfirm: () {
          _imagePositions.value = {};
          Navigator.pop(context);
          if (_pageController.hasClients) {
            final currentPage = _pageController.page?.toInt() ?? 0;
            if (currentPage > 0) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          }
        },
      );
    } else {
      if (_pageController.hasClients) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final texts = context.texts.sign.sign;
    return BlocBuilder<SignDocumentBloc, SignDocumentState>(
      buildWhen: (previous, current) => previous.pdfs != current.pdfs,
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              gap50,
              Text(
                texts.positionSignature,
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: AppFontWeight.semiBold,
                ),
              ),
              gap10,
              Text(
                texts.selectSigner,
                style: context.textTheme.titleSmall?.copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              gap20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: _goToPreviousPage,
                  ),
                  const AlCard(
                      padding: edgeInsets8, child: Text('Paul Quinonez')),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: _goToNextPage,
                  ),
                ],
              ),
              gap20,
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.8,
                child: FutureBuilder<List<Uint8List>>(
                    future: _pdfsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No PDFs found.'));
                      }

                      final pdfs = snapshot.data!;

                      return Stack(
                        children: [
                          GestureDetector(
                            onTapUp: (details) {
                              final tappedPosition = details.localPosition;

                              final currentPage = indexPage.value;
                              final currentPositions =
                                  _imagePositions.value[currentPage] ?? {};
                              if (currentPositions.contains(tappedPosition)) {
                                currentPositions.remove(tappedPosition);
                              } else {
                                currentPositions.add(tappedPosition);
                              }
                              _imagePositions.value = {
                                ..._imagePositions.value,
                                currentPage: Set.from(currentPositions),
                              };
                            },
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: pdfs.length,
                              itemBuilder: (context, index) {
                                final pdfData = pdfs[index];
                                return Column(
                                  children: [
                                    Expanded(
                                      child: pdfx.PdfView(
                                        controller: pdfx.PdfController(
                                          document: pdfx.PdfDocument.openData(
                                              pdfData),
                                        ),
                                        onPageChanged: (page) {
                                          indexPage.value = page;
                                        },
                                      ),
                                    ),
                                    gap20,
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.info_outline),
                                        space10,
                                        Expanded(
                                          child:
                                              Text(texts.importantCertificate),
                                        )
                                      ],
                                    ),
                                    gap20,
                                    ValueListenableBuilder(
                                        valueListenable: loadingGeneratePdf,
                                        builder: (context, loading, _) {
                                          return AlPrimaryButton(
                                            text: texts.finish,
                                            icon: loading
                                                ? const CircularProgressIndicator()
                                                : null,
                                            onPressed: () async {
                                              loadingGeneratePdf.value = true;
                                              final pagePositions =
                                                  _imagePositions.value
                                                      .map((key, value) =>
                                                          MapEntry(key,
                                                              value.toList()))
                                                      .values
                                                      .toList();

                                              Uint8List signatureImageBytes;
                                              try {
                                                signatureImageBytes =
                                                    await loadImageBytes(state
                                                        .selectedSignature!
                                                        .filePath);
                                                if (signatureImageBytes
                                                    .isEmpty) {
                                                  throw Exception(texts
                                                      .signatureImageBytesAreEmpty);
                                                }
                                              } catch (e) {
                                                return;
                                              }

                                              // Open the PDF
                                              final pdfPath = widget
                                                  .pdfs[_pageController.page!
                                                      .round()]
                                                  .filePath;
                                              final pdfDoc =
                                                  await pdfx.PdfDocument
                                                      .openFile(pdfPath);
                                              final pageCount =
                                                  pdfDoc.pagesCount;

                                              final pdfDocument = pw.Document();

                                              // Add each page to the PDF
                                              for (var pageIndex = 0;
                                                  pageIndex < pageCount;
                                                  pageIndex++) {
                                                final pageImage =
                                                    await loadPageImage(
                                                        pdfPath, pageIndex);

                                                if (pageImage.isEmpty) {
                                                  continue;
                                                }

                                                final currentPositions =
                                                    pagePositions.length >
                                                            pageIndex
                                                        ? pagePositions[
                                                            pageIndex]
                                                        : [];

                                                pdfDocument.addPage(
                                                  pw.Page(
                                                    build:
                                                        (pw.Context context) {
                                                      return pw.Stack(
                                                        children: [
                                                          pw.Image(
                                                              pw.MemoryImage(
                                                                  pageImage)),
                                                          ...currentPositions
                                                              .map(
                                                            (position) =>
                                                                pw.Positioned(
                                                              left: position.dx,
                                                              top: position.dy,
                                                              child: pw.Image(
                                                                pw.MemoryImage(
                                                                    signatureImageBytes),
                                                                width: 100,
                                                                height: 50,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                );
                                              }

                                              try {
                                                final pdfBytes =
                                                    await pdfDocument.save();
                                                final outputDir =
                                                    await getApplicationDocumentsDirectory();
                                                final outputFile = File(
                                                    "${outputDir.path}/signed_document${pdfBytes.first}.pdf");
                                                await outputFile
                                                    .writeAsBytes(pdfBytes);

                                                if (mounted) {
                                                  context
                                                      .read<SignDocumentBloc>()
                                                      .add(SignDocumentEvent
                                                          .savePdfSigned(
                                                              outputFile));
                                                }
                                                loadingGeneratePdf.value =
                                                    false;

                                                widget.tabController
                                                    .animateTo(4);
                                              } catch (e) {
                                                log(e.toString());
                                              }
                                            },
                                          );
                                        })
                                  ],
                                );
                              },
                            ),
                          ),
                          ValueListenableBuilder(
                              valueListenable: indexPage,
                              builder: (context, valueIndex, _) {
                                return ValueListenableBuilder<
                                    Map<int, Set<Offset>>>(
                                  valueListenable: _imagePositions,
                                  builder: (context, pageImagePositions, _) {
                                    final imagePositions =
                                        pageImagePositions[valueIndex] ?? {};
                                    return Stack(
                                      children: imagePositions.map((position) {
                                        return BlocSelector<SignDocumentBloc,
                                            SignDocumentState, PdfEntitie?>(
                                          selector: (state) =>
                                              state.selectedSignature,
                                          builder:
                                              (context, selectedSignature) {
                                            if (selectedSignature == null) {
                                              return const SizedBox.shrink();
                                            }

                                            return Positioned(
                                              left: position.dx - 50,
                                              top: position.dy -
                                                  50, // Ajusta la posición para centrar la imagen
                                              child: Image.file(
                                                File(
                                                    selectedSignature.filePath),
                                                height: 50,
                                                width: 200,
                                              ),
                                            );
                                          },
                                        );
                                      }).toList(),
                                    );
                                  },
                                );
                              }),
                        ],
                      );
                    }),
              ),
              gap30,
            ],
          ),
        );
      },
    );
  }
}

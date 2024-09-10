import 'dart:io';

import 'package:all_legal/src/core/core.dart';
import 'package:all_legal/src/features/features.dart';
import 'package:all_legal/src/features/sign_document/presentation/bloc/bloc/sign_document_bloc.dart';
import 'package:all_legal_core/all_legal_core.dart';
import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdfx/pdfx.dart' as pdfx;

class SignDocument extends StatelessWidget {
  const SignDocument._();

  static Widget builder(BuildContext _, GoRouterState __) {
    return const SignDocument._();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AlAppBar(
        automaticallyImplyLeading: false,
      ),
      body: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignDocumentBloc(
          uploadDocumentRepository: RepositoryProvider.of(context))
        ..add(
          const SignDocumentEvent.getListPdf(),
        )
        ..add(const SignDocumentEvent.getSignature()),
      child: Padding(
        padding: edgeInsetsH20,
        child: Column(
          children: [
            gap20,
            Row(
              children: [
                InkWell(
                    onTap: () => context.pop(),
                    child: const Icon(
                      Icons.chevron_left,
                      size: 30,
                    )),
                space12,
                Text(
                  'Firmar Documentos',
                  style: context.textTheme.titleLarge?.copyWith(
                      color: context.colorScheme.secondary, fontSize: 30),
                ),
              ],
            ),
            gap30,
            Expanded(
              child: TabBarCustom(
                  physics: const BouncingScrollPhysics(),
                  dividerColor: Palette.black,
                  colorTab: Colors.transparent,
                  borderRadiusTab: BorderRadius.zero,
                  paddingTab: EdgeInsets.zero,
                  labelColor: Colors.black,
                  heightTab: 60,
                  unselectedLabelColor: Palette.smokeGray.withOpacity(.5),
                  indicatorColor: Palette.darkCyan,
                  defaultIndicator: true,
                  enableShadow: false,
                  isScrollable: true,
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.document_scanner),
                      text: 'Cargar documentos',
                    ),
                    Tab(
                      icon: Icon(Icons.document_scanner),
                      text: 'Cargar firmas',
                    ),
                    Tab(
                      icon: Icon(Icons.supervisor_account_rounded),
                      text: 'Indicar firmantes',
                    ),
                    Tab(
                      icon: Icon(Icons.document_scanner),
                      text: 'Personalizaciones',
                    ),
                    Tab(
                      icon: Icon(Icons.document_scanner),
                      text: 'Resumen',
                    ),
                  ],
                  tabViews: [
                    const UploadDocument(),
                    const UploadSign(),
                    const IndicateSignatory(),
                    BlocSelector<SignDocumentBloc, SignDocumentState,
                        List<PdfEntitie>>(
                      selector: (state) => state.pdfs,
                      builder: (context, pdfs) {
                        return PositionSignature(
                          pdfs: pdfs,
                        );
                      },
                    ),
                    const Text('data')
                  ]),
            )
          ],
        ),
      ),
    );
  }
}

class PositionSignature extends StatefulWidget {
  const PositionSignature({
    super.key,
    required this.pdfs,
  });

  final List<PdfEntitie> pdfs;

  @override
  State<PositionSignature> createState() => _PositionSignatureState();
}

class _PositionSignatureState extends State<PositionSignature> {
  late PageController _pageController;

  late Future<List<Uint8List>> _pdfsFuture;
  final _imagePositions = ValueNotifier<Map<int, Set<Offset>>>({});

  final indexPage = ValueNotifier<int>(0);

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

  void _goToPreviousPage() {
    if (_imagePositions.value.isNotEmpty) {
      AlAlertDigalog.showCustomDialog(
        context,
        title: '¿Estas seguro de cambiar de pdf?',
        description:
            'Se perderan todos los cambios realizados hasta este momento, respecto a tus firmas',
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
      AlAlertDigalog.showCustomDialog(
        context,
        title: '¿Estas seguro de cambiar de pdf?',
        description:
            'Se perderan todos los cambios realizados hasta este momento, respecto a tus firmas',
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
    return BlocBuilder<SignDocumentBloc, SignDocumentState>(
      buildWhen: (previous, current) => previous.pdfs != current.pdfs,
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              gap50,
              Text(
                'Posicionar las firma',
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: AppFontWeight.semiBold,
                ),
              ),
              gap10,
              Text(
                'Seleccione el firmante y pincha en donde deseas que se estampen las firmas e iniciales',
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
                height: MediaQuery.sizeOf(context).height * 0.6,
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
                          PageView.builder(
                            controller: _pageController,
                            itemCount: pdfs.length,
                            itemBuilder: (context, index) {
                              final pdfData = pdfs[index];
                              return pdfx.PdfView(
                                controller: pdfx.PdfController(
                                  document: pdfx.PdfDocument.openData(pdfData),
                                ),
                                onPageChanged: (page) {
                                  indexPage.value = page;
                                },
                              );
                            },
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
                                            if (selectedSignature == null)
                                              return const SizedBox();
                                            return Positioned(
                                              left: position.dx -
                                                  50, // Ajusta la posición para centrar la imagen
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
                          Positioned.fill(
                            child: GestureDetector(
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
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              gap20,
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline),
                  space10,
                  Expanded(
                    child: Text(
                        'Importante: El certificado de Firma Electrónica, solo se podrá posicionar una vez en el documento. Toma en cuenta que el certificado firma todo el documento y no sólo unahoja en particular.'),
                  )
                ],
              ),
              gap20,
              AlPrimaryButton(
                text: 'Finalizar',
                onPressed: () async {
                  final file = await _generatePdf(
                      state.pdfs, state.selectedSignature, context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => pdfx.PdfView(
                              controller: pdfx.PdfController(
                                document: pdfx.PdfDocument.openFile(file.path),
                              ),
                              onPageChanged: (page) {
                                indexPage.value = page;
                              },
                            )),
                  );
                },
              ),
              gap30,
            ],
          ),
        );
      },
    );
  }

  // Función para generar el PDF
  Future<File> _generatePdf(
    List<PdfEntitie> pdfs,
    PdfEntitie? selectedSignature,
    BuildContext context,
  ) async {
    final pdf = pw.Document();

    // Aquí puedes agregar una página por cada PDF en pdfs
    for (int i = 0; i < pdfs.length; i++) {
      final pdfData = pdfs[i];

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Stack(
              children: [
                // Puedes agregar imágenes aquí si las tienes
                pw.Positioned(
                  left: 50,
                  top: 50,
                  child: pw.Image(
                    pw.MemoryImage(pdfData.pdfData),
                    width: 200,
                    height: 200,
                  ),
                ),
                // Aquí agregamos las imágenes de firmas
                ..._imagePositions.value[i]?.map((position) {
                      return pw.Positioned(
                        left: position.dx,
                        top: position.dy,
                        child: pw.Image(
                          // Debes cargar las imágenes desde un archivo o una red
                          // Aquí usamos un placeholder para demostrar
                          pw.MemoryImage(
                              pdfData.pdfData), // Reemplaza con la imagen real
                          width: 100,
                          height: 100,
                        ),
                      );
                    }) ??
                    [],
              ],
            );
          },
        ),
      );
    }
    // Guardar PDF en almacenamiento temporal
    final outputDir = await getApplicationDocumentsDirectory();
    final filePath = '${outputDir.path}/example.pdf';
    // await outputFile.writeAsBytes(await pdf.save());
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PDF guardado en $filePath')),
    );
    // print('PDF guardado en $outputFile');
    // final url = Uri.file(outputFile.path).toString();
    // if (await launchUrlString(url)) {
    //   await launchUrlString(url);
    // } else {
    //   throw 'No se pudo abrir el archivo: $outputFile';
    // }
    return file;
  }
}

Future<void> _sendEmailWithAttachment(File pdfFile) async {
  final email = Email(
    body: 'Por favor, encuentra el PDF adjunto con la imagen superpuesta.',
    subject: 'PDF con Imágenes',
    recipients: ['ederzambranomero@gmail.com'],
    attachmentPaths: [pdfFile.path],
    isHTML: false,
  );
  await FlutterEmailSender.send(email);
}

class IndicateSignatory extends StatefulWidget {
  const IndicateSignatory({
    super.key,
  });

  @override
  State<IndicateSignatory> createState() => _IndicateSignatoryState();
}

class _IndicateSignatoryState extends State<IndicateSignatory> {
  final TextEditingController _textController = TextEditingController();
  final obscuredText = ValueNotifier(true);
  @override
  void dispose() {
    _textController.dispose();
    obscuredText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        gap30,
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Tu Firma',
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Firmante registrado:',
                      style:
                          context.textTheme.titleSmall?.copyWith(fontSize: 16),
                    ),
                    space10,
                    Text(
                      'Paúl Quiñonez',
                      style: context.textTheme.titleLarge?.copyWith(
                        color: context.colorScheme.onPrimary,
                      ),
                    )
                  ],
                ),
                gap4,
                Text(
                  '(paul.quinonez@todolegal.com)',
                  style: context.textTheme.bodyLarge
                      ?.copyWith(color: context.colorScheme.onSurface),
                ),
                gap20,
                BlocBuilder<SignDocumentBloc, SignDocumentState>(
                  buildWhen: (previous, current) =>
                      previous.selectedSignature != current.selectedSignature,
                  builder: (context, state) {
                    String filePath = state.selectedSignature?.filePath ?? '';
                    String fileName = p.basename(filePath);

                    _textController.text = fileName;

                    return GestureDetector(
                      onTap: () => SignatureModal.show(context,
                          signDocumentBloc: context.read<SignDocumentBloc>()),
                      child: InputField(
                        label: 'Selecciona certificado',
                        labelColor: context.colorScheme.onSurface,
                        controller: _textController,
                        hintText: 'Seleccione',
                        enabled: false,
                        borderColor:
                            context.colorScheme.primary.withOpacity(.5),
                        suffix: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: context.colorScheme.primary.withOpacity(.5),
                        ),
                      ),
                    );
                  },
                ),
                gap20,
                ValueListenableBuilder(
                    valueListenable: obscuredText,
                    builder: (context, value, _) {
                      return InputField(
                        label: 'Contrasena',
                        obscureText: value,
                        labelColor: context.colorScheme.onSurface,
                        borderColor:
                            context.colorScheme.primary.withOpacity(.5),
                        suffix: GestureDetector(
                          onTap: () => obscuredText.value = !obscuredText.value,
                          child: const Icon(
                            Icons.remove_red_eye,
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
        AlExtraButton(
          text: 'Cancelar',
          borderColor: context.theme.primaryColor,
        ),
        gap20,
        BlocSelector<SignDocumentBloc, SignDocumentState, PdfEntitie?>(
          selector: (state) => state.selectedSignature,
          builder: (context, selectedSignature) {
            return AlExtraButton(
              text: 'Continuar',
              color: selectedSignature == null
                  ? context.colorScheme.onSecondary
                  : context.theme.primaryColor,
              textColor: selectedSignature == null
                  ? context.theme.colorScheme.primary.withOpacity(.5)
                  : context.theme.colorScheme.onPrimary,
            );
          },
        ),
        gap30,
      ],
    );
  }
}

class UploadDocument extends StatelessWidget {
  const UploadDocument({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        gap30,
        Expanded(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sube tus documentos y ordenalos',
                    textAlign: TextAlign.center,
                  ),
                  Icon(Icons.question_mark_outlined)
                ],
              ),
              gap30,
              BlocBuilder<SignDocumentBloc, SignDocumentState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status,
                builder: (context, state) {
                  if (state.status == PdfStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.pdfs.isEmpty) {
                    return GestureDetector(
                      onTap: () {
                        context
                            .read<SignDocumentBloc>()
                            .add(const SignDocumentEvent.savePdf());
                      },
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * .38,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: context.colorScheme.onSecondary,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AlIcon(
                              icon: AllLegalIcons.doc,
                              size: AlIconSize.bigBigger,
                            ),
                            gap20,
                            Text(
                              'Subir Documentos',
                              style: context.textTheme.titleMedium?.copyWith(
                                color: context.colorScheme.onSurface,
                              ),
                            ),
                            gap4,
                            Text(
                              'PDF 20MB',
                              style: context.textTheme.bodyLarge?.copyWith(
                                color: context.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => gap10,
                      itemCount: state.pdfs.length + 1,
                      itemBuilder: (context, index) {
                        if (index == state.pdfs.length) {
                          return AlCard(
                              onPressed: () =>
                                  context.read<SignDocumentBloc>().add(
                                        const SignDocumentEvent.savePdf(),
                                      ),
                              padding: edgeInsets16,
                              shadow: false,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: context.colorScheme.onSurface,
                                  ),
                                  space10,
                                  Expanded(
                                    child: Text(
                                      'Añadir mas elementos',
                                      style: context.textTheme.titleLarge
                                          ?.copyWith(
                                        color: context.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Max. 2MB',
                                    style:
                                        context.textTheme.titleLarge?.copyWith(
                                      color: context.colorScheme.primary,
                                    ),
                                  )
                                ],
                              ));
                        }
                        String filePath = state.pdfs[index].filePath;
                        String fileName = p.basename(filePath);

                        if (!fileName.endsWith('.pdf')) {
                          fileName = '$fileName.pdf';
                        }

                        String baseName = fileName.replaceAll('.pdf', '');
                        if (baseName.length > 20) {
                          baseName = '${baseName.substring(0, 25)}...';
                        }

                        // Luego añade de nuevo la extensión .pdf
                        String displayName = '$baseName.pdf';

                        return AlCard(
                          padding: edgeInsets16,
                          shadow: false,
                          child: Row(
                            children: [
                              Icon(
                                Icons.more_vert_sharp,
                                color: context.theme.primaryColor,
                              ),
                              space10,
                              Expanded(
                                child: Text(displayName,
                                    style: context.textTheme.bodyLarge
                                        ?.copyWith(
                                            color: context
                                                .theme.colorScheme.primary),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              space4,
                              Icon(
                                Icons.question_mark_sharp,
                                color: context.colorScheme.primary,
                              ),
                              space4,
                              GestureDetector(
                                onTap: () => context
                                    .read<SignDocumentBloc>()
                                    .add(SignDocumentEvent.deletePdf(index)),
                                child: Icon(Icons.delete,
                                    color: context.colorScheme.primary),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        AlExtraButton(
          text: 'Cancelar',
          borderColor: context.theme.primaryColor,
        ),
        gap20,
        BlocSelector<SignDocumentBloc, SignDocumentState, List<PdfEntitie>>(
          selector: (state) => state.pdfs,
          builder: (context, pdfs) {
            return AlExtraButton(
              text: 'Continuar',
              color: pdfs.isEmpty
                  ? context.colorScheme.onSecondary
                  : context.theme.primaryColor,
              textColor: pdfs.isEmpty
                  ? context.theme.colorScheme.primary.withOpacity(.5)
                  : context.theme.colorScheme.onPrimary,
            );
          },
        ),
        gap30,
      ],
    );
  }
}

class UploadSign extends StatelessWidget {
  const UploadSign({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        gap30,
        Expanded(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sube tus documentos y ordenalos',
                    textAlign: TextAlign.center,
                  ),
                  Icon(Icons.question_mark_outlined)
                ],
              ),
              gap30,
              BlocBuilder<SignDocumentBloc, SignDocumentState>(
                buildWhen: (previous, current) =>
                    previous.signatureStatus != current.signatureStatus,
                builder: (context, state) {
                  if (state.signatureStatus == SignatureStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.signs.isEmpty) {
                    return GestureDetector(
                      onTap: () {
                        context
                            .read<SignDocumentBloc>()
                            .add(const SignDocumentEvent.saveSignature());
                      },
                      child: Container(
                        height: MediaQuery.sizeOf(context).height * .38,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: context.colorScheme.onSecondary,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AlIcon(
                              icon: AllLegalIcons.doc,
                              size: AlIconSize.bigBigger,
                            ),
                            gap20,
                            Text(
                              'Subir Documentos',
                              style: context.textTheme.titleMedium?.copyWith(
                                color: context.colorScheme.onSurface,
                              ),
                            ),
                            gap4,
                            Text(
                              'IMG 20MB',
                              style: context.textTheme.bodyLarge?.copyWith(
                                color: context.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => gap10,
                      itemCount: state.signs.length + 1,
                      itemBuilder: (context, index) {
                        if (index == state.signs.length) {
                          return AlCard(
                              onPressed: () =>
                                  context.read<SignDocumentBloc>().add(
                                        const SignDocumentEvent.saveSignature(),
                                      ),
                              padding: edgeInsets16,
                              shadow: false,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: context.colorScheme.onSurface,
                                  ),
                                  space10,
                                  Expanded(
                                    child: Text(
                                      'Añadir mas elementos',
                                      style: context.textTheme.titleLarge
                                          ?.copyWith(
                                        color: context.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Max. 2MB',
                                    style:
                                        context.textTheme.titleLarge?.copyWith(
                                      color: context.colorScheme.primary,
                                    ),
                                  )
                                ],
                              ));
                        }
                        String filePath = state.signs[index].filePath;
                        String fileName = p.basename(filePath);

                        return AlCard(
                          padding: edgeInsets16,
                          shadow: false,
                          child: Row(
                            children: [
                              Icon(
                                Icons.more_vert_sharp,
                                color: context.theme.primaryColor,
                              ),
                              space10,
                              Expanded(
                                child: Text(fileName,
                                    style: context.textTheme.bodyLarge
                                        ?.copyWith(
                                            color: context
                                                .theme.colorScheme.primary),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              space4,
                              Icon(
                                Icons.question_mark_sharp,
                                color: context.colorScheme.primary,
                              ),
                              space4,
                              GestureDetector(
                                onTap: () => context
                                    .read<SignDocumentBloc>()
                                    .add(SignDocumentEvent.deleteSignature(
                                        index)),
                                child: Icon(Icons.delete,
                                    color: context.colorScheme.primary),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        AlExtraButton(
          text: 'Cancelar',
          borderColor: context.theme.primaryColor,
        ),
        gap20,
        BlocSelector<SignDocumentBloc, SignDocumentState, List<PdfEntitie>>(
          selector: (state) => state.signs,
          builder: (context, signs) {
            return AlExtraButton(
              text: 'Continuar',
              color: signs.isEmpty
                  ? context.colorScheme.onSecondary
                  : context.theme.primaryColor,
              textColor: signs.isEmpty
                  ? context.theme.colorScheme.primary.withOpacity(.5)
                  : context.theme.colorScheme.onPrimary,
            );
          },
        ),
        gap30,
      ],
    );
  }
}

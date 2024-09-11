import 'package:all_legal/src/features/features.dart';
import 'package:all_legal/src/i18n/translations.g.dart';
import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;
import 'package:pdfx/pdfx.dart';

class DocumentSignedList extends StatefulWidget {
  const DocumentSignedList({
    super.key,
  });

  @override
  State<DocumentSignedList> createState() => _DocumentSignedListState();
}

class _DocumentSignedListState extends State<DocumentSignedList> {
  @override
  void initState() {
    context
        .read<SignDocumentBloc>()
        .add(const SignDocumentEvent.getPdfSigned());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final texts = context.texts.sign.sign;
    return BlocBuilder<SignDocumentBloc, SignDocumentState>(
      builder: (context, state) {
        if (state.signatureSignedStatus == SignatureSignedStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.signedPdfs.isEmpty) {
          return Center(child: Text(texts.thereAreNoSignedFiles));
        }

        return Column(
          children: [
            gap20,
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => gap10,
                itemCount: state.signedPdfs.length,
                itemBuilder: (context, index) {
                  String filePath = state.signedPdfs[index].filePath;
                  String fileName = p.basename(filePath);

                  return AlCard(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PdfView(
                              controller: PdfController(
                                document: PdfDocument.openFile(filePath),
                              ),
                            ),
                          ),
                        );
                      },
                      padding: edgeInsets8,
                      child: Text(fileName));
                },
              ),
            )
          ],
        );
      },
    );
  }
}

import 'package:all_legal/src/features/sign_document/sign_document.dart';
import 'package:all_legal/src/i18n/translations.g.dart';
import 'package:all_legal_core/all_legal_core.dart';
import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;

class UploadDocument extends StatelessWidget {
  const UploadDocument({
    super.key,
    required this.tabController,
  });
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final texts = context.texts.sign.sign;
    return Column(
      children: [
        gap30,
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    texts.uploadDocumentsAndOrder,
                    textAlign: TextAlign.center,
                  ),
                  const Icon(Icons.question_mark_outlined)
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
                              texts.uploadDocument,
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
                                      texts.addMore,
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
          text: texts.cancel,
          borderColor: context.theme.primaryColor,
        ),
        gap20,
        BlocSelector<SignDocumentBloc, SignDocumentState, List<PdfEntitie>>(
          selector: (state) => state.pdfs,
          builder: (context, pdfs) {
            return AlExtraButton(
              onPressed: () => tabController.animateTo(1),
              text: texts.continues,
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

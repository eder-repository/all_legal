import 'package:all_legal/src/features/sign_document/presentation/presentation.dart';
import 'package:all_legal/src/i18n/translations.g.dart';
import 'package:all_legal_core/all_legal_core.dart';
import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;

class UploadSign extends StatelessWidget {
  const UploadSign({
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
                              texts.uploadSignatures,
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
          text: texts.cancel,
          borderColor: context.theme.primaryColor,
        ),
        gap20,
        BlocSelector<SignDocumentBloc, SignDocumentState, List<PdfEntitie>>(
          selector: (state) => state.signs,
          builder: (context, signs) {
            return AlExtraButton(
              onPressed: () => tabController.animateTo(2),
              text: texts.continues,
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

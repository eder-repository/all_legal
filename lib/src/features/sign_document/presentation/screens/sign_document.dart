import 'package:all_legal/src/core/core.dart';
import 'package:all_legal/src/features/sign_document/presentation/bloc/bloc/sign_document_bloc.dart';
import 'package:all_legal_core/all_legal_core.dart';
import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;

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

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignDocumentBloc(
          uploadDocumentRepository: RepositoryProvider.of(context))
        ..add(
          const SignDocumentEvent.getListPdf(),
        ),
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
                  tabViews: const [
                    UploadDocument(),
                    Text('data'),
                    Text('data'),
                    Text('data')
                  ]),
            )
          ],
        ),
      ),
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

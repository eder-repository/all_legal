import 'package:all_legal/src/core/core.dart';
import 'package:all_legal/src/features/features.dart';
import 'package:all_legal/src/i18n/translations.g.dart';
import 'package:all_legal_core/all_legal_core.dart';
import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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

class _BodyState extends State<_Body> with SingleTickerProviderStateMixin {
  // Declarar el TabController
  late TabController _tabController;
  final changePageSummary = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final homeTexts = context.texts.home.home;
    final signTexts = context.texts.sign.sign;
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
                Expanded(
                  child: FittedBox(
                    child: Text(
                      homeTexts.signDocuments,
                      style: context.textTheme.titleLarge?.copyWith(
                          color: context.colorScheme.secondary, fontSize: 30),
                    ),
                  ),
                ),
              ],
            ),
            gap30,
            Expanded(
              child: TabBarCustom(
                  onTabChanged: (value) {},
                  controller: _tabController,
                  physics: const BouncingScrollPhysics(),
                  dividerColor: Palette.black,
                  colorTab: Colors.transparent,
                  borderRadiusTab: BorderRadius.zero,
                  paddingTab: EdgeInsets.zero,
                  labelColor: Colors.black,
                  heightTab: 60,
                  tabViewPhysics: const NeverScrollableScrollPhysics(),
                  unselectedLabelColor: Palette.smokeGray.withOpacity(.5),
                  indicatorColor: Palette.darkCyan,
                  defaultIndicator: true,
                  enableShadow: false,
                  isScrollable: true,
                  tabs: [
                    Tab(
                      icon: const Icon(Icons.document_scanner),
                      text: signTexts.uploadDocument,
                    ),
                    Tab(
                      icon: const Icon(Icons.document_scanner),
                      text: signTexts.uploadSignatures,
                    ),
                    Tab(
                      icon: const Icon(Icons.supervisor_account_rounded),
                      text: signTexts.indicateSignatories,
                    ),
                    Tab(
                      icon: const Icon(Icons.document_scanner),
                      text: signTexts.customizations,
                    ),
                    Tab(
                      icon: const Icon(Icons.document_scanner),
                      text: signTexts.summary,
                    ),
                  ],
                  tabViews: [
                    UploadDocument(
                      tabController: _tabController,
                    ),
                    UploadSign(
                      tabController: _tabController,
                    ),
                    IndicateSignatory(
                      tabController: _tabController,
                    ),
                    BlocSelector<SignDocumentBloc, SignDocumentState,
                        List<PdfEntitie>>(
                      selector: (state) => state.pdfs,
                      builder: (context, pdfs) {
                        return PositionSignature(
                          pdfs: pdfs,
                          tabController: _tabController,
                        );
                      },
                    ),
                    ValueListenableBuilder(
                        valueListenable: changePageSummary,
                        builder: (context, value, _) {
                          if (value) {
                            return DocumentSignedSuccess(
                              tabController: _tabController,
                            );
                          }
                          return Summary(
                            changePageSummary: changePageSummary,
                          );
                        })
                  ]),
            )
          ],
        ),
      ),
    );
  }
}

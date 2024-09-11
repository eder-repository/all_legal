import 'package:all_legal/src/core/core.dart';
import 'package:all_legal/src/features/sign_document/sign_document.dart';
import 'package:all_legal/src/i18n/translations.g.dart';
import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DocumentSignedSuccess extends StatefulWidget {
  const DocumentSignedSuccess({
    super.key,
    required this.tabController,
  });
  final TabController tabController;

  @override
  State<DocumentSignedSuccess> createState() => _DocumentSignedSuccessState();
}

class _DocumentSignedSuccessState extends State<DocumentSignedSuccess> {
  final documentSign = ValueNotifier(false);

  @override
  void dispose() {
    documentSign.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final texts = context.texts.sign.sign;
    return ValueListenableBuilder(
        valueListenable: documentSign,
        builder: (context, value, _) {
          if (value) {
            return const DocumentSignedList();
          }
          return Column(
            children: [
              gap30,
              Text(
                '!${texts.documentSignedSendSuccess}!',
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: AppFontWeight.semiBold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              gap20,
              Icon(
                Icons.check_circle,
                size: 130,
                color: context.colorScheme.onPrimaryContainer,
              ),
              gap20,
              AlPrimaryButton(
                text: texts.viewSignedDocuments,
                onPressed: () {
                  documentSign.value = true;
                },
              ),
              gap10,
              AlPrimaryButton(
                text: texts.signAnotherDocument,
                onPressed: () => widget.tabController.animateTo(2),
              ),
              gap10,
              AlExtraButton(
                text: texts.backToDashboard,
                onPressed: () => context.goNamed(Routes.home.name),
                borderColor: context.theme.colorScheme.onSurface,
                textColor: context.theme.colorScheme.onSurface,
              ),
            ],
          );
        });
  }
}

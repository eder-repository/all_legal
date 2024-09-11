import 'package:all_legal/src/features/features.dart';
import 'package:all_legal/src/i18n/translations.g.dart';
import 'package:all_legal_core/all_legal_core.dart';
import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;

class IndicateSignatory extends StatefulWidget {
  const IndicateSignatory({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

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
    final texts = context.texts.sign.sign;
    return Column(
      children: [
        gap30,
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  texts.yourSignature,
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${texts.signerRegistered}:',
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
                        label: texts.selectCertificate,
                        labelColor: context.colorScheme.onSurface,
                        controller: _textController,
                        hintText: texts.select,
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
                        label: texts.password,
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
          text: texts.cancel,
          borderColor: context.theme.primaryColor,
        ),
        gap20,
        BlocSelector<SignDocumentBloc, SignDocumentState, PdfEntitie?>(
          selector: (state) => state.selectedSignature,
          builder: (context, selectedSignature) {
            return AlExtraButton(
              onPressed: () => widget.tabController.animateTo(3),
              text: texts.continues,
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

import 'package:all_legal/src/i18n/translations.g.dart';
import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Summary extends StatefulWidget {
  const Summary({
    super.key,
    required this.changePageSummary,
  });
  final ValueNotifier<bool> changePageSummary;

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  final check = ValueNotifier(false);

  @override
  void dispose() {
    check.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final texts = context.texts.sign.sign;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          gap30,
          Text(
            '!${texts.weAre}!',
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: AppFontWeight.semiBold,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          gap20,
          Icon(
            Icons.library_add_check_sharp,
            size: 160,
            color: context.theme.primaryColor,
          ),
          gap20,
          Text(
            '${texts.sendTo}:',
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: AppFontWeight.semiBold,
              fontSize: 16,
              color: context.colorScheme.onPrimary,
            ),
            textAlign: TextAlign.left,
          ),
          gap40,
          Text(
            'Paúl Quiñonez',
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: AppFontWeight.semiBold,
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
          gap4,
          Text(
            '@ paul.quinonez@todolegal.com',
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: AppFontWeight.medium,
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
          gap10,
          Text(
            'Mario Salas',
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: AppFontWeight.semiBold,
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
          gap4,
          Text(
            '@ admin@asb.com',
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: AppFontWeight.medium,
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
          gap30,
          Text(
            '${texts.docuemnt}:',
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: AppFontWeight.medium,
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
          gap4,
          Text(
            'Contrato de Arrendamiento',
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: 16,
            ),
            textAlign: TextAlign.left,
          ),
          gap30,
          CheckboxCustom(
            onChangedCheckbox: (value) {
              check.value = value;
            },
            child: RichText(
              text: TextSpan(
                text: '${texts.readAndAccept} ',
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: texts.termsAndConditions,
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("Navegar a Términos del Servicio");
                      },
                  ),
                  TextSpan(
                    text: ' ${texts.and} ',
                    style: const TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: texts.privacyPolicy,
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    // Simula la navegación a política de privacidad
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("Navegar a Política de Privacidad");
                      },
                  ),
                ],
              ),
            ),
          ),
          gap20,
          ValueListenableBuilder(
              valueListenable: check,
              builder: (context, value, _) {
                return AlPrimaryButton(
                  text: texts.send,
                  onPressed: value
                      ? () {
                          widget.changePageSummary.value = true;
                        }
                      : null,
                );
              }),
          gap20
        ],
      ),
    );
  }
}

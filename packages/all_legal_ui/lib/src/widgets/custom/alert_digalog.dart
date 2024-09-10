import 'package:all_legal_ui/src/src.dart';
import 'package:flutter/material.dart';

class AlAlertDigalog extends StatelessWidget {
  const AlAlertDigalog({
    super.key,
    this.onConfirm,
    required this.title,
    required this.description,
    this.titleConfirm,
    this.onCancel,
  });

  static void showCustomDialog(BuildContext context,
      {VoidCallback? onConfirm,
      VoidCallback? onCancel,
      required String title,
      required String description,
      String? titleConfirm}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: AlAlertDigalog(
            onConfirm: onConfirm,
            title: title,
            description: description,
          ),
        );
      },
    );
  }

  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final String title;
  final String description;
  final String? titleConfirm;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 40,
                  width: 100,
                  child: AlExtraButton(
                    onPressed: onConfirm,
                    text: titleConfirm ?? 'Aceptar',
                    color: context.theme.primaryColor,
                    textColor: context.theme.colorScheme.primary,
                  )),
              space20,
              SizedBox(
                  height: 40,
                  width: 100,
                  child: AlExtraButton(
                    onPressed: onCancel ?? () => Navigator.pop(context),
                    text: 'Cerrar',
                    color: context.colorScheme.primary,
                    textColor: context.theme.colorScheme.onSecondary,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

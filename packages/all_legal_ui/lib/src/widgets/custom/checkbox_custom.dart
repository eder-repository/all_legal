import 'package:flutter/material.dart';

class CheckboxCustom extends StatefulWidget {
  const CheckboxCustom(
      {super.key, required this.child, required this.onChangedCheckbox});

  final Widget child;
  final ValueChanged<bool> onChangedCheckbox;

  @override
  CheckboxCustomState createState() => CheckboxCustomState();
}

class CheckboxCustomState extends State<CheckboxCustom> {
  final _acceptedTerms = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ValueListenableBuilder(
                valueListenable: _acceptedTerms,
                builder: (context, value, _) {
                  return Checkbox(
                    value: value,
                    onChanged: (bool? value) {
                      widget.onChangedCheckbox(value ?? false);
                      _acceptedTerms.value = value ?? false;
                    },
                  );
                }),
            Expanded(child: widget.child),
          ],
        ),
      ],
    );
  }
}

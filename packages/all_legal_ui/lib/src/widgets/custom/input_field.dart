import 'package:all_legal_ui/all_legal_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    this.hintText,
    this.controller,
    this.inputType,
    this.maxLines = 1,
    this.readOnly = false,
    this.onChanged,
    this.initialValue,
    this.autofocus = false,
    this.obscureText = false,
    this.prefix,
    this.suffix,
    this.label,
    this.textAlign = TextAlign.start,
    this.inputFormatters = const [],
    this.hintStyle,
    this.textInputAction,
    this.errorBuilder,
    this.errorFutureBuilder,
    this.validate = false,
    this.widget,
    this.borderRadius = borderRadius8,
    this.crossAxisAlignment,
    this.backgroundColor,
    this.boxShadow,
    this.labelColor,
    this.hasBorderColor = true,
    this.enabled = true,
    this.textStyle,
    this.cursorColor,
    this.labelRequired = false,
    this.isNullSelect = false,
    this.focusNode,
    this.borderColor = Colors.white,
    this.paddingVertical,
    this.paddingHorizontal,
    this.opacity = 1,
    this.labelFontSize,
    this.autovalidateMode,
    this.inputDecoration,
    this.labelFontWeight,
    this.warning,
    this.obscuringCharacter = '•',
    this.errorSpacing = 4,
    this.errorFontSize,
  });

  /// The hint text to display when the input field is empty.
  final String? hintText;

  /// The controller to control the input field.
  final TextEditingController? controller;

  /// The input type of the input field.
  final TextInputType? inputType;

  /// The max lines of the input field.
  final int? maxLines;

  /// The radius in input.
  final BorderRadiusGeometry borderRadius;

  /// Whether the input field is read only.
  final bool readOnly;

  /// The on changed callback.
  final void Function(String)? onChanged;

  /// The initial value of the input field.
  final String? initialValue;

  /// Whether the input field should autofocus.
  final bool autofocus;

  /// Whether the input field should obscure text.
  final bool obscureText;

  /// The prefix widget.
  final Widget? prefix;

  /// The suffix widget.
  final Widget? suffix;

  final String? label;

  /// The text align of the input field.
  final TextAlign textAlign;

  /// The input formatters of the input field.
  final List<TextInputFormatter> inputFormatters;

  /// The text style of the input field.
  final TextStyle? textStyle;

  /// The hint style of the input field.
  final TextStyle? hintStyle;

  /// CrossAxisAlignment input field.
  final CrossAxisAlignment? crossAxisAlignment;

  /// The text input action of the input field.
  final TextInputAction? textInputAction;

  /// The error builder of the input field.
  final dynamic Function()? errorBuilder;

  /// The error future builder of the input field.
  final Future<dynamic> Function()? errorFutureBuilder;

  /// Whether the input field should validate.
  final bool validate;

  /// Custom widget for the body.
  final Widget? widget;

  /// BackgroundColor
  final Color? backgroundColor;

  /// BoxShadow
  final List<BoxShadow>? boxShadow;

  final Color? labelColor;
  final bool hasBorderColor;
  final bool enabled;
  final Color? cursorColor;
  final Color borderColor;
  final bool labelRequired;
  final bool isNullSelect;

  final FocusNode? focusNode;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final double opacity;
  final double? labelFontSize;
  final AutovalidateMode? autovalidateMode;
  final InputDecoration? inputDecoration;
  final FontWeight? labelFontWeight;
  final bool? warning;
  final String obscuringCharacter;
  final double errorSpacing;
  final double? errorFontSize;

  @override
  Widget build(BuildContext context) {
    String? errorString;

    if (validate) {
      errorString = errorBuilder?.call() is String?
          ? errorBuilder?.call() as String?
          : null;
    }

    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.stretch,
      children: [
        if (labelRequired && label != null) ...[
          Row(
            children: [
              Text(
                label!,
                style: context.textTheme.displaySmall?.copyWith(
                  color: labelColor ?? context.colorScheme.tertiary,
                ),
              ),
              space4,
              Text(
                '(*)',
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Palette.white,
                ),
              ),
            ],
          ),
          gap8,
        ] else if (label != null) ...[
          Text(
            label!,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: labelFontWeight ?? FontWeight.w700,
              color: labelColor ?? context.colorScheme.tertiary,
              fontSize: labelFontSize,
            ),
          ),
          gap8,
        ],
        Opacity(
          opacity: opacity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: backgroundColor ?? context.colorScheme.onSecondary,
              borderRadius: borderRadius,
              boxShadow: boxShadow ?? [],
              border: hasBorderColor
                  ? Border.all(
                      color: errorString != null && errorString.isNotEmpty
                          ? warning == true
                              ? context.colorScheme.surface.withOpacity(.2)
                              : context.colorScheme.surface
                          : borderColor,
                    )
                  : isNullSelect
                      ? Border.all(
                          color: context.colorScheme.surface,
                        )
                      : null,
            ),
            child: widget ??
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: paddingHorizontal ?? 15,
                    vertical: paddingVertical ?? 0,
                  ),
                  child: Row(
                    children: [
                      if (prefix != null) ...[
                        prefix!,
                        space10,
                      ],
                      Expanded(
                        child: TextFormField(
                          obscuringCharacter: obscuringCharacter,
                          autovalidateMode: autovalidateMode ??
                              AutovalidateMode.onUserInteraction,
                          autocorrect: false,
                          enableSuggestions: false,
                          focusNode: focusNode,
                          enabled: enabled,
                          style: textStyle ??
                              context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.tertiary,
                              ),
                          autofocus: autofocus,
                          initialValue: initialValue,
                          controller: controller,
                          textInputAction: textInputAction,
                          decoration: inputDecoration ??
                              InputDecoration(
                                hintText: hintText,
                                hintStyle: hintStyle ??
                                    context.textTheme.titleMedium?.copyWith(
                                      color: context.colorScheme.tertiary
                                          .withOpacity(.5),
                                    ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                errorStyle: TextStyle(
                                  color: context.colorScheme.surface,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                          maxLines: maxLines,
                          cursorColor:
                              cursorColor ?? context.theme.primaryColor,
                          obscureText: obscureText,
                          inputFormatters: inputFormatters,
                          cursorWidth: 1.5,
                          readOnly: readOnly,
                          cursorRadius: const Radius.circular(20),
                          keyboardType: inputType,
                          onChanged: onChanged,
                          textAlign: textAlign,
                          onTapOutside: (event) => focusNode?.unfocus(),
                        ),
                      ),
                      if (suffix != null) suffix!,
                    ],
                  ),
                ),
          ),
        ),
        if (errorString != null)
          _buildErrorColumn(
            context,
            errorString,
            warning,
            errorFontSize: errorFontSize,
            errorSpacing: errorSpacing,
          ),
        if (errorFutureBuilder != null)
          FutureBuilder(
            future: (errorFutureBuilder ?? Future.value)(),
            builder: (context, snapshot) {
              final text = snapshot.data as String? ?? '';

              if (text.isNotEmpty) {
                return _buildErrorColumn(
                  context,
                  text,
                  warning,
                  errorFontSize: errorFontSize,
                  errorSpacing: errorSpacing,
                );
              }

              return const Offstage();
            },
          ),
      ],
    );
  }

  Widget _buildErrorColumn(
    BuildContext context,
    String text,
    bool? warning, {
    double errorSpacing = 4,
    double? errorFontSize,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: errorSpacing,
        ),
        Text(
          text,
          style: context.textTheme.bodySmall?.copyWith(
            color: warning == true
                ? context.colorScheme.surface.withOpacity(.2)
                : context.colorScheme.surface,
            fontSize: errorFontSize,
          ),
        ),
      ],
    );
  }
}

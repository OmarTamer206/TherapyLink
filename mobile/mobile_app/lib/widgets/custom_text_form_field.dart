import 'package:flutter/material.dart';
import 'package:mobile_app/theme/theme_helper.dart';

extension TextFormFiledStyleHelper on CustomTextFormField {
  static OutlineInputBorder get outlinePrimaryContainer => OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(
          color: theme.colorScheme.primaryContainer,
          width: 1,
        ),
      );

  static OutlineInputBorder get outlinePrimary => OutlineInputBorder(
        borderRadius: BorderRadius.circular(26),
        borderSide: BorderSide.none,
      );

  static UnderlineInputBorder get underLinePrimaryContainer =>
      UnderlineInputBorder(
          borderSide: BorderSide(
        color: theme.colorScheme.primaryContainer,
      ));

  static OutlineInputBorder get fillGray => OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide.none,
      );
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      this.alignment,
      this.width,
      this.boxDecoration,
      this.scrollPadding,
      this.controller,
      this.focusNode,
      this.autofocus = false,
      this.textStyle,
      this.obscureText = false,
      this.readOnly = false,
      this.onTap,
      this.textInputAction = TextInputAction.next,
      this.textInputType = TextInputType.text,
      this.maxLines,
      this.hintText,
      this.hintStyle,
      this.prefix,
      this.prefixConstraints,
      this.suffix,
      this.suffixConstraints,
      this.contentPadding,
      this.borderDecoration,
      this.fillColor,
      this.filled = true,
      this.validator})
      : super(
          key: key,
        );

  final Alignment? alignment;

  final double? width;

  final BoxDecoration? boxDecoration;

  final EdgeInsets? scrollPadding;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final bool? obscureText;

  final bool? readOnly;

  final VoidCallback? onTap;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget(context),
          )
        : textFormFieldWidget(context);
  }
   Widget textFormFieldWidget(BuildContext context) => Container(
        width: width ?? double.maxFinite,
        decoration: boxDecoration,
        child: TextFormField(
         scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
         controller: controller,
         focusNode: focusNode,
         onTapOutside: (event){
          if(focusNode != null){
            focusNode?.unfocus();
          }else{
            FocusManager.instance.primaryFocus?.unfocus();
          }
         },
         autofocus: autofocus!,
         style: textStyle ?? theme.textTheme.titleMedium,
         obscureText: obscureText!,
         readOnly: readOnly!,
         onTap: () {
           onTap?.call();
         },
         textInputAction: textInputAction,
         keyboardType: textInputType,
         maxLines: maxLines ?? 1,
         decoration: decoration,
         validator: validator,
        ),
      );

  InputDecoration get decoration => InputDecoration(
    hintText: hintText ?? "",
    hintStyle: hintStyle ?? theme.textTheme.titleLarge,
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding:
            contentPadding ??const EdgeInsets.symmetric(horizontal: 10,vertical: 12),
        fillColor: fillColor ?? theme.colorScheme.onErrorContainer,
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none,
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none,
            ),
        focusedBorder: (borderDecoration ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ))
            .copyWith(
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 1,
          ),
        ),
      );
}

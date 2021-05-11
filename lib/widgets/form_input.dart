import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FormFieldSetter<String> onChanged;
  final FormFieldValidator<String> validator;
  final Function onEditingComplete;
  final bool obscureText;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  final AutovalidateMode autovalidateMode;
  final bool showSuffix;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final bool showPrefix;

  FormInput({
    this.controller,
    this.focusNode,
    this.inputAction,
    this.inputType,
    this.obscureText = false,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.hint,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.showSuffix = true,
    this.suffixIcon,
    this.prefixIcon,
    this.showPrefix = true,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: TextFormField(
        onEditingComplete: onEditingComplete,
        autovalidateMode: autovalidateMode,
        controller: controller,
        focusNode: focusNode,
        textInputAction: inputAction,
        obscureText: obscureText,
        onSaved: onSaved,
        onChanged: onChanged,
        validator: validator,
        style: Theme.of(context).textTheme.headline3,
        decoration: InputDecoration(
            prefixIconConstraints: BoxConstraints(minHeight: 8),
            suffixIconConstraints: BoxConstraints(minHeight: 8),
            prefixIcon: showPrefix
                ? Padding(
                    padding: EdgeInsets.only(
                      bottom: 8,
                      right: showPrefix ? 10 : 0,
                    ),
                    child: prefixIcon,
                  )
                : null,
            suffixIcon: showSuffix
                ? Padding(
                    padding: EdgeInsets.only(
                      bottom: 8,
                      right: showSuffix ? 10 : 0,
                    ),
                    child: suffixIcon,
                  )
                : null,
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.headline3,
            isDense: true,
            contentPadding: EdgeInsets.only(
              bottom: 8,
            )),
      ),
    );
  }
}

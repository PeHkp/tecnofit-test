import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final void Function(String value) onChanged;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String label;
  final bool autofocus;
  final Icon icon;
  final bool enabled;
  final bool isPrefix;
  final TextEditingController controller;

  TextInputWidget(
      {required this.onChanged,
      required this.keyboardType,
      required this.textInputAction,
      required this.enabled,
      required this.label,
      required this.icon,
      this.isPrefix = false,
      this.autofocus = false,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      showCursor: true,
      autofocus: autofocus,
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      enabled: enabled,
      validator: (value) {
        print(value);
        if (value!.isEmpty || value == null) {
          return 'Esse campo e obrigatório';
        }
      },
      onChanged: onChanged,
      cursorColor: Colors.blueAccent,
      style: const TextStyle(color: Colors.blueAccent),
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent, width: 2)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent, width: 2)),
          prefixIcon: icon,
          labelText: label,
          labelStyle: const TextStyle(color: Colors.blueAccent)),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String? Function(String?)? validate,
  VoidCallback? onPressed,
  VoidCallback? onTap,
  dynamic? onChange,
  required IconData prefixIcon,
  required String label,
  IconData? suffixIcon,
  bool isPassword = false,
  bool readOnly = false,
  String? initValue,
}) =>
    TextFormField(
      // initialValue: initValue,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon != null
            ? IconButton(
          onPressed: onPressed,
          icon: Icon(
            suffixIcon,
          ),
        )
            : null,
      ),
      validator: validate,
      onChanged: onChange,
      onTap: onTap,
      readOnly: readOnly,
    );

Widget customButton({
  Color color = Colors.deepOrange,
  double width = double.infinity,
  required Function() onPressed,
  required String text,
}) =>
    Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
        ),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ));

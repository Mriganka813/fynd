import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gofoods/utils/mediaqury.dart';

class Customtextfield extends StatefulWidget {
  final Function(String)? onChanged;
  final Function(String?)? onSave;
  final Function(String?)? validator;
  final String? name;
  final String? hintText;
  final Color? textcolor;
  final double? wi;
  final IconData? icon;
  final Color? fillcolor;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;

  Customtextfield(
      {Key? key,
      this.onChanged,
      this.onSave,
      this.validator,
      this.hintText,
      this.textcolor,
      this.wi,
      this.icon,
      this.fillcolor,
      this.name,
      this.inputType,
      this.inputFormatters})
      : super(key: key);

  @override
  State<Customtextfield> createState() => _CustomtextfieldState();
}

class _CustomtextfieldState extends State<Customtextfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height / 16,
      width: widget.wi,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(13),
        ),
      ),
      child: TextFormField(
        style: TextStyle(color: widget.textcolor),
        decoration: InputDecoration(
          fillColor: widget.fillcolor,
          filled: true,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          border: InputBorder.none,
          prefixIcon: Icon(widget.icon, size: height / 35),
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        keyboardType: widget.inputType,
        inputFormatters: widget.inputFormatters,
        validator: (e) {
          if (widget.validator != null) {
            return widget.validator!(e);
          }
          if (e == null || e.isEmpty) {
            return '${widget.name ?? "Field"} is required';
          }
          return null;
        },
        onChanged: (e) {
          if (widget.onChanged == null) {
            return;
          }
          widget.onChanged!(e);
        },
        onSaved: (e) {
          if (widget.onSave == null) {
            return;
          }
          widget.onSave!(e);
        },
      ),
    );
  }
}

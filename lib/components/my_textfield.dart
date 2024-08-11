import 'package:flutter/material.dart';

class mytextfield extends StatelessWidget {
  final String hinttext;
  final bool obsecuretext;
  final FocusNode? focusNode;

  final TextEditingController controller;
  const mytextfield({
    super.key,
    required this.hinttext,
    required this.obsecuretext,
    required this.controller,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        obscureText: obsecuretext,
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          hintText: hinttext,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

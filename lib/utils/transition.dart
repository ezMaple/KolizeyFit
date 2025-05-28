import 'package:flutter/material.dart';

void navigateTo(BuildContext context, String route) {
  Navigator.pushReplacementNamed(context, route);
}

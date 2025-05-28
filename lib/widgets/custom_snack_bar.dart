import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  final String message;
  final bool isError;

  CustomSnackBar({
    super.key,
    required this.message,
    this.isError = false,
    super.action,
    super.duration = const Duration(seconds: 3),
  }) : super(
         content: ConstrainedBox(
           constraints: const BoxConstraints(maxWidth: 300),
           child: Row(
             mainAxisSize: MainAxisSize.min,
             children: [
               Icon(
                 isError ? Icons.error : Icons.check_circle,
                 color: Colors.white,
               ),
               const SizedBox(width: 8),
               Expanded(
                 child: Text(
                   message,
                   style: const TextStyle(
                     fontSize: 16.0,
                     fontWeight: FontWeight.bold,
                     color: Colors.white,
                   ),
                 ),
               ),
             ],
           ),
         ),
         backgroundColor: isError ? Colors.red : Colors.green,
         behavior: SnackBarBehavior.floating,
         margin: const EdgeInsets.all(10),
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
       );
}

import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class ProfilePictureSection extends StatelessWidget {
  const ProfilePictureSection({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final double screenWidth = MediaQuery.of(context).size.width;
    double avatarRadius = screenWidth * 0.15;
    double buttonFontSize = screenWidth * 0.045;
    double padding = screenWidth * 0.04;
    double spacing = screenWidth * 0.06;

    return Card(
      color: Colors.grey[700],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: avatarRadius,
              backgroundImage: const AssetImage('assets/images/Dani.jpeg'),
            ),
            SizedBox(width: spacing),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: padding * 0.6,
                  horizontal: padding * 1.2,
                ),
                textStyle: TextStyle(fontSize: buttonFontSize),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(local.changePhotoButton),
            ),
          ],
        ),
      ),
    );
  }
}

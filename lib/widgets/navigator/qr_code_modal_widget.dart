import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../l10n/app_localizations.dart';

class QrCodeModalWidget extends StatelessWidget {
  final String data;

  const QrCodeModalWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final TextStyle qrTextStyle = Theme.of(context).textTheme.bodyLarge!;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 400,
          margin: const EdgeInsets.only(top: 40),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(local.qrCodeTitle, style: qrTextStyle),
              const SizedBox(height: 20),
              QrImageView(
                data: data,
                version: QrVersions.auto,
                size: 200.0,
                dataModuleStyle: QrDataModuleStyle(
                  color: qrTextStyle.color ?? Colors.black,
                  dataModuleShape: QrDataModuleShape.square,
                ),
                eyeStyle: QrEyeStyle(
                  color: qrTextStyle.color ?? Colors.black,
                  eyeShape: QrEyeShape.square,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  local.qrCodeInstruction,
                  style: qrTextStyle.copyWith(fontSize: 22.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 20,
          left: (MediaQuery.of(context).size.width - 40) / 2,
          child: Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
    );
  }
}

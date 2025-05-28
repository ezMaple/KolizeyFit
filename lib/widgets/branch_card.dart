import 'package:flutter/material.dart';

class BranchCard extends StatelessWidget {
  final String address;
  final String phone;

  const BranchCard({
    super.key,
    required this.address,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      color: theme.cardColor, // Устанавливаем цвет карточки
      child: ListTile(
        leading: const Icon(Icons.location_on, color: Colors.black),
        title: null, // Убираем отображение имени
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              address,
              style: theme.textTheme.bodyMedium, // Используем текстовый стиль из темы
            ),
            const SizedBox(height: 4.0),
            Text(
              phone,
              style: theme.textTheme.bodyMedium, // Используем текстовый стиль из темы
            ),
          ],
        ),
      ),
    );
  }
}

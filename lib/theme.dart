import 'package:flutter/material.dart';

// Определяем тему для всего приложения
final ThemeData appTheme = ThemeData(

  fontFamily: 'Montserrat', // Указываем шрифт по умолчанию для всего приложения
  // Основные цвета приложения

  scaffoldBackgroundColor: Color(0xFF4C4C4C), // Цвет фона для всех экранов

  //primarySwatch: Colors.blue,  // Цвет для первичных элементов (кнопки, AppBar и т.д.)
  //accentColor: Colors.orange,  // Дополнительный цвет (акцентный цвет)

   // AppBar
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF4C4C4C), // Цвет фона AppBar
    foregroundColor: Colors.white, // Цвет текста и иконок на AppBar
  ),

  inputDecorationTheme: InputDecorationTheme(
  filled: true,
  fillColor: Color(0xFFD9D7D0), // Цвет фона для поля ввода
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16.0), // Скругленные углы
    borderSide: BorderSide.none, // Убираем стандартную границу
  ),
  contentPadding: EdgeInsets.all(16.0), // Отступы внутри поля ввода
  hintStyle: TextStyle(fontSize: 18.0), // Цвет подсказки (если нужно)
  labelStyle: TextStyle(fontSize: 18.0), // Размер текста метки (label)
  // Стиль текста внутри поля ввода
  ),



  // Тема для текста
  textTheme: TextTheme(
    headlineMedium: const TextStyle(fontSize: 35.0, color: Colors.white, fontFamily: 'Montserrat'),
    bodyLarge: TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
      color: Color(0xFFF8CF3F) // Основной цвет текста для QR-кода
    ),
    bodySmall: TextStyle( color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: Color(0xFFF8CF3F), // Цвет текста в карточках
    ),
    labelLarge: const TextStyle(
      fontSize: 15,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    // titleLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
    // headline2: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.black),
    // bodyText1: TextStyle(fontSize: 16.0, color: Colors.black),
    // bodyText2: TextStyle(fontSize: 14.0, color: Colors.grey),
    // subtitle1: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic, color: Colors.black87),
    // subtitle2: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic, color: Colors.grey),
  ),

  // // Стили для кнопок
  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ElevatedButton.styleFrom(
  //     primary: Colors.blue, // Цвет фона кнопки
  //     onPrimary: Colors.white, // Цвет текста на кнопке
  //     padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20), // Отступы кнопки
  //   ),
  // ),

  cardColor: Colors.grey[700],

   // Тема для ElevatedButton
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFFF8CF3F), // Цвет фона кнопки
      foregroundColor: Colors.black,  // Цвет текста кнопки
      textStyle: const TextStyle(
        fontSize: 20, // Размер шрифта
        fontWeight: FontWeight.bold, // Жирный шрифт
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Скругление углов
      ),
    ),
  ),
  // // Стили для AppBar
  // appBarTheme: AppBarTheme(
  //   backgroundColor: Colors.blue, // Цвет фона AppBar
  //   foregroundColor: Colors.white, // Цвет текста и иконок на AppBar
  //   elevation: 4.0, // Тень для AppBar
  // ),
  // Тема для BottomNavigationBar
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.yellow, // Цвет активных иконок
    unselectedItemColor: Colors.grey, // Цвет неактивных иконок
    backgroundColor: const Color(0xFF3E3E3E), // Фон навигационной панели
  ),


  textButtonTheme: TextButtonThemeData(
  style: ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Colors.white),
    alignment: Alignment.centerLeft,
    padding: WidgetStateProperty.all(EdgeInsets.only(left: 16.0, bottom: 20.0)),
    textStyle: WidgetStateProperty.all(
      const TextStyle(
        fontSize: 20,
      ),
    ),
  
  ),
  
),
);

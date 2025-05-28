// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'КолизейФит';

  @override
  String get cartTitle => 'Корзина';

  @override
  String get pay => 'Оплатить';

  @override
  String get total => 'Итого';

  @override
  String get paymentSuccess => 'Оплата прошла';

  @override
  String get emptyCart => 'Корзина пуста';

  @override
  String get loginTitle => 'Авторизация';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Пароль';

  @override
  String get noAccount => 'Нет аккаунта?';

  @override
  String get registerButton => 'Зарегистрироваться';

  @override
  String get loginButton => 'Войти';

  @override
  String get loginSuccess => 'Вход выполнен!';

  @override
  String get enterEmailAndPassword => 'Введите email и пароль';

  @override
  String get registerTitle => 'Регистрация';

  @override
  String get fillAllFields => 'Пожалуйста, заполните все поля';

  @override
  String get invalidEmail => 'Введите корректный Email';

  @override
  String get invalidPhone => 'Номер телефона должен содержать от 10 до 15 символов';

  @override
  String get registrationSuccess => 'Успешная регистрация!';

  @override
  String get alreadyHaveAccount => 'Уже есть аккаунт? ';

  @override
  String get loginLink => 'Войти';

  @override
  String get homeTitle => 'Главная';

  @override
  String get noAvailableSubscriptions => 'Нет доступных абонементов';

  @override
  String get branchesTitle => 'Филиалы';

  @override
  String get branchesNotFound => 'Филиалы не найдены';

  @override
  String apiError(Object message, Object statusCode) {
    return 'Ошибка $statusCode: $message';
  }

  @override
  String unexpectedError(Object error) {
    return 'Непредвиденная ошибка: $error';
  }

  @override
  String get loginRequiredToViewCart => 'Чтобы просматривать корзину,\nнужно войти в аккаунт.';

  @override
  String get cartLoadError => 'Ошибка загрузки корзины';

  @override
  String get cartIsEmpty => 'Корзина пуста';

  @override
  String cartTotal(Object amount) {
    return 'Итого: $amount руб.';
  }

  @override
  String get payButton => 'Оплатить';

  @override
  String get removedFromCart => 'Удалено из корзины!';

  @override
  String get paymentError => 'Произошла ошибка при оплате';

  @override
  String get detailsTitle => 'Детали';

  @override
  String get addToCartButton => 'Добавить';

  @override
  String get addedToCartSuccess => 'Добавлено в корзину!';

  @override
  String get productIdNotSet => 'ID продукта не задан';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get saveButton => 'Сохранить';

  @override
  String get emailChangedLoginAgain => 'Email изменён. Пожалуйста, войдите заново.';

  @override
  String get profileUpdated => 'Профиль обновлён!';

  @override
  String get profileLoadError => 'Ошибка загрузки профиля';

  @override
  String get parametersTitle => 'Мои параметры';

  @override
  String get editButton => 'Редактировать';

  @override
  String get createButton => 'Создать';

  @override
  String get parametersSaved => 'Параметры сохранены!';

  @override
  String fieldRequired(Object label) {
    return 'Заполните поле \"$label\"';
  }

  @override
  String get invalidFieldValue => 'Введите корректное значение';

  @override
  String get chestLabel => 'Грудь (см)';

  @override
  String get hipsLabel => 'Бедра (см)';

  @override
  String get heightLabel => 'Рост (см)';

  @override
  String get neckLabel => 'Шея (см)';

  @override
  String get bicepsLabel => 'Бицепс (см)';

  @override
  String get weightLabel => 'Вес (кг)';

  @override
  String get profileTitle => 'Профиль';

  @override
  String get myParametersButton => 'Мои параметры';

  @override
  String get notificationSettingsButton => 'Настройки уведомлений';

  @override
  String get deleteAccountButton => 'Удалить учетную запись';

  @override
  String get notImplemented => 'Пока не реализовано';

  @override
  String get logoutButton => 'Выйти';

  @override
  String get splashWelcomeText => 'Добро пожаловать в Kolizey!';

  @override
  String get navHome => 'Главная';

  @override
  String get navBranches => 'Филиалы';

  @override
  String get navCart => 'Корзина';

  @override
  String get navProfile => 'Профиль';

  @override
  String get qrCodeTitle => 'Ваш QR-код';

  @override
  String get qrCodeInstruction => 'Покажите этот код на стойке администратора';

  @override
  String get emailHint => 'Введите Email';

  @override
  String get nameHint => 'Введите имя';

  @override
  String get phoneHint => 'Введите телефон';

  @override
  String get passwordHint => 'Пароль';

  @override
  String get registerTextButton => 'Нет аккаунта? Зарегистрироваться';

  @override
  String get qrCodeGenerationError => 'Ошибка при генерации QR-кода';

  @override
  String get retryButton => 'Повторить';

  @override
  String get changePhotoButton => 'Изменить фото';

  @override
  String get kolizeyLogoAlt => 'Логотип Kolizey';
}

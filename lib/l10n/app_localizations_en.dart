// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'KolizeyFit';

  @override
  String get cartTitle => 'Cart';

  @override
  String get pay => 'Pay';

  @override
  String get total => 'Total';

  @override
  String get paymentSuccess => 'Payment successful';

  @override
  String get emptyCart => 'Your cart is empty';

  @override
  String get loginTitle => 'Login';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get registerButton => 'Register';

  @override
  String get loginButton => 'Login';

  @override
  String get loginSuccess => 'Login successful!';

  @override
  String get enterEmailAndPassword => 'Please enter email and password';

  @override
  String get registerTitle => 'Register';

  @override
  String get fillAllFields => 'Please fill in all fields';

  @override
  String get invalidEmail => 'Enter a valid email';

  @override
  String get invalidPhone => 'Phone number must be 10 to 15 characters';

  @override
  String get registrationSuccess => 'Registration successful!';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get loginLink => 'Login';

  @override
  String get homeTitle => 'Home';

  @override
  String get noAvailableSubscriptions => 'No available subscriptions';

  @override
  String get branchesTitle => 'Branches';

  @override
  String get branchesNotFound => 'No branches found';

  @override
  String apiError(Object message, Object statusCode) {
    return 'Error $statusCode: $message';
  }

  @override
  String unexpectedError(Object error) {
    return 'Unexpected error: $error';
  }

  @override
  String get loginRequiredToViewCart => 'To view the cart,\nyou need to be logged in.';

  @override
  String get cartLoadError => 'Failed to load cart';

  @override
  String get cartIsEmpty => 'Your cart is empty';

  @override
  String cartTotal(Object amount) {
    return 'Total: $amount RUB';
  }

  @override
  String get payButton => 'Pay';

  @override
  String get removedFromCart => 'Removed from cart!';

  @override
  String get paymentError => 'Payment failed';

  @override
  String get detailsTitle => 'Details';

  @override
  String get addToCartButton => 'Add to cart';

  @override
  String get addedToCartSuccess => 'Added to cart!';

  @override
  String get productIdNotSet => 'Product ID not set';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get saveButton => 'Save';

  @override
  String get emailChangedLoginAgain => 'Email changed. Please log in again.';

  @override
  String get profileUpdated => 'Profile updated!';

  @override
  String get profileLoadError => 'Failed to load profile';

  @override
  String get parametersTitle => 'My Parameters';

  @override
  String get editButton => 'Edit';

  @override
  String get createButton => 'Create';

  @override
  String get parametersSaved => 'Parameters saved!';

  @override
  String fieldRequired(Object label) {
    return 'Please fill the \"$label\" field';
  }

  @override
  String get invalidFieldValue => 'Enter a valid number';

  @override
  String get chestLabel => 'Chest (cm)';

  @override
  String get hipsLabel => 'Hips (cm)';

  @override
  String get heightLabel => 'Height (cm)';

  @override
  String get neckLabel => 'Neck (cm)';

  @override
  String get bicepsLabel => 'Biceps (cm)';

  @override
  String get weightLabel => 'Weight (kg)';

  @override
  String get profileTitle => 'Profile';

  @override
  String get myParametersButton => 'My parameters';

  @override
  String get notificationSettingsButton => 'Notification settings';

  @override
  String get deleteAccountButton => 'Delete account';

  @override
  String get notImplemented => 'Not implemented yet';

  @override
  String get logoutButton => 'Logout';

  @override
  String get splashWelcomeText => 'Welcome to Kolizey!';

  @override
  String get navHome => 'Home';

  @override
  String get navBranches => 'Branches';

  @override
  String get navCart => 'Cart';

  @override
  String get navProfile => 'Profile';

  @override
  String get qrCodeTitle => 'Your QR Code';

  @override
  String get qrCodeInstruction => 'Show this code at the front desk';

  @override
  String get emailHint => 'Enter Email';

  @override
  String get nameHint => 'Enter Name';

  @override
  String get phoneHint => 'Enter Phone';

  @override
  String get passwordHint => 'Password';

  @override
  String get registerTextButton => 'Don\'t have an account? Register';

  @override
  String get qrCodeGenerationError => 'QR code generation failed';

  @override
  String get retryButton => 'Retry';

  @override
  String get changePhotoButton => 'Change Photo';

  @override
  String get kolizeyLogoAlt => 'Kolizey Logo';
}

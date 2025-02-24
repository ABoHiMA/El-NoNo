import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @ahmed.
  ///
  /// In en, this message translates to:
  /// **'Eng. Ahmed Ebrahim Khalel'**
  String get ahmed;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome with El NoNo'**
  String get welcome;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @nono.
  ///
  /// In en, this message translates to:
  /// **'El NoNo'**
  String get nono;

  /// No description provided for @admin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get admin;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @activated.
  ///
  /// In en, this message translates to:
  /// **'Activated'**
  String get activated;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @national.
  ///
  /// In en, this message translates to:
  /// **'National ID'**
  String get national;

  /// No description provided for @enter_national_reset.
  ///
  /// In en, this message translates to:
  /// **'Enter Admin National ID To Reset App'**
  String get enter_national_reset;

  /// No description provided for @enter_national.
  ///
  /// In en, this message translates to:
  /// **'Enter Your National ID, Please'**
  String get enter_national;

  /// No description provided for @national_required.
  ///
  /// In en, this message translates to:
  /// **'National ID Required'**
  String get national_required;

  /// No description provided for @reset_app.
  ///
  /// In en, this message translates to:
  /// **'Reset App'**
  String get reset_app;

  /// No description provided for @reset_successfully.
  ///
  /// In en, this message translates to:
  /// **'Reset App Successfully'**
  String get reset_successfully;

  /// No description provided for @reset_failed.
  ///
  /// In en, this message translates to:
  /// **'Reset App Failed'**
  String get reset_failed;

  /// No description provided for @activation_successfully.
  ///
  /// In en, this message translates to:
  /// **'Successfully...^^ \n Activation code has been successfully registered. \n You are now enjoying the full version of the program.'**
  String get activation_successfully;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning:'**
  String get warning;

  /// No description provided for @sure_register.
  ///
  /// In en, this message translates to:
  /// **'Are you sure about your data because it is impossible to go back or change it?'**
  String get sure_register;

  /// No description provided for @sure_reset.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reset the program?'**
  String get sure_reset;

  /// No description provided for @sure.
  ///
  /// In en, this message translates to:
  /// **'Sure'**
  String get sure;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @enter_name.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Name'**
  String get enter_name;

  /// No description provided for @enter_email.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Email'**
  String get enter_email;

  /// No description provided for @enter_phone.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Phone'**
  String get enter_phone;

  /// No description provided for @enter_username.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Username'**
  String get enter_username;

  /// No description provided for @enter_password.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Password'**
  String get enter_password;

  /// No description provided for @enter_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Confirm Password'**
  String get enter_confirm_password;

  /// No description provided for @repeat_password.
  ///
  /// In en, this message translates to:
  /// **'Repeat Password'**
  String get repeat_password;

  /// No description provided for @by.
  ///
  /// In en, this message translates to:
  /// **'By '**
  String get by;

  /// No description provided for @key_wrong.
  ///
  /// In en, this message translates to:
  /// **'Keys are Wrong'**
  String get key_wrong;

  /// No description provided for @enter_activation.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Activation Key, Please'**
  String get enter_activation;

  /// No description provided for @activation_key.
  ///
  /// In en, this message translates to:
  /// **'Activation Key'**
  String get activation_key;

  /// No description provided for @activation_key_full.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Activation Key To Get Full Version'**
  String get activation_key_full;

  /// No description provided for @check_both.
  ///
  /// In en, this message translates to:
  /// **'Check username or password'**
  String get check_both;

  /// No description provided for @reset_user_pass.
  ///
  /// In en, this message translates to:
  /// **'Reset User Password'**
  String get reset_user_pass;

  /// No description provided for @admin_id.
  ///
  /// In en, this message translates to:
  /// **'Admin National ID'**
  String get admin_id;

  /// No description provided for @enter_admin_id.
  ///
  /// In en, this message translates to:
  /// **'Enter Admin National ID'**
  String get enter_admin_id;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// No description provided for @enter_new_password.
  ///
  /// In en, this message translates to:
  /// **'Enter New Password'**
  String get enter_new_password;

  /// No description provided for @repeat_new_password.
  ///
  /// In en, this message translates to:
  /// **'Repeat New Password'**
  String get repeat_new_password;

  /// No description provided for @enter_repeat_new_password.
  ///
  /// In en, this message translates to:
  /// **'Enter Repeat New Password'**
  String get enter_repeat_new_password;

  /// No description provided for @reset_username.
  ///
  /// In en, this message translates to:
  /// **'Reset Username'**
  String get reset_username;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password;

  /// No description provided for @check_admin_id.
  ///
  /// In en, this message translates to:
  /// **'Check Admin National ID'**
  String get check_admin_id;

  /// No description provided for @update_password.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get update_password;

  /// No description provided for @reset_user_username.
  ///
  /// In en, this message translates to:
  /// **'Reset User Username'**
  String get reset_user_username;

  /// No description provided for @reset_admin_username.
  ///
  /// In en, this message translates to:
  /// **'Reset Admin Username'**
  String get reset_admin_username;

  /// No description provided for @new_username.
  ///
  /// In en, this message translates to:
  /// **'New Username'**
  String get new_username;

  /// No description provided for @enter_new_username.
  ///
  /// In en, this message translates to:
  /// **'Enter New Username'**
  String get enter_new_username;

  /// No description provided for @repeat_username.
  ///
  /// In en, this message translates to:
  /// **'Repeat Username'**
  String get repeat_username;

  /// No description provided for @enter_repeat_username.
  ///
  /// In en, this message translates to:
  /// **'Enter Repeat Username'**
  String get enter_repeat_username;

  /// No description provided for @update_username.
  ///
  /// In en, this message translates to:
  /// **'Update Username'**
  String get update_username;

  /// No description provided for @product_name_.
  ///
  /// In en, this message translates to:
  /// **'Product Name: '**
  String get product_name_;

  /// No description provided for @product_name.
  ///
  /// In en, this message translates to:
  /// **'Product Name'**
  String get product_name;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @more_quantity.
  ///
  /// In en, this message translates to:
  /// **'More than current quantity'**
  String get more_quantity;

  /// No description provided for @invalid_quantity.
  ///
  /// In en, this message translates to:
  /// **'Invalid quantity'**
  String get invalid_quantity;

  /// No description provided for @total_price_.
  ///
  /// In en, this message translates to:
  /// **'Total Price: '**
  String get total_price_;

  /// No description provided for @total_price.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get total_price;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @no_note.
  ///
  /// In en, this message translates to:
  /// **'No Note'**
  String get no_note;

  /// No description provided for @num.
  ///
  /// In en, this message translates to:
  /// **'No.'**
  String get num;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @admin_password.
  ///
  /// In en, this message translates to:
  /// **'Admin Password'**
  String get admin_password;

  /// No description provided for @enter_admin_password.
  ///
  /// In en, this message translates to:
  /// **'Enter Admin Password, Please'**
  String get enter_admin_password;

  /// No description provided for @add_product.
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get add_product;

  /// No description provided for @new_.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get new_;

  /// No description provided for @hey.
  ///
  /// In en, this message translates to:
  /// **'Hey'**
  String get hey;

  /// No description provided for @product_details.
  ///
  /// In en, this message translates to:
  /// **'Product Details'**
  String get product_details;

  /// No description provided for @enter_product_name.
  ///
  /// In en, this message translates to:
  /// **'Enter Product Name'**
  String get enter_product_name;

  /// No description provided for @product_quantity.
  ///
  /// In en, this message translates to:
  /// **'Product Quantity'**
  String get product_quantity;

  /// No description provided for @enter_product_quantity.
  ///
  /// In en, this message translates to:
  /// **'Enter Product Quantity'**
  String get enter_product_quantity;

  /// No description provided for @product_price.
  ///
  /// In en, this message translates to:
  /// **'Product Price'**
  String get product_price;

  /// No description provided for @enter_product_price.
  ///
  /// In en, this message translates to:
  /// **'Enter Product Price'**
  String get enter_product_price;

  /// No description provided for @product_description.
  ///
  /// In en, this message translates to:
  /// **'Product Description'**
  String get product_description;

  /// No description provided for @no_description.
  ///
  /// In en, this message translates to:
  /// **'No Description'**
  String get no_description;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @delete_product.
  ///
  /// In en, this message translates to:
  /// **'Delete Product'**
  String get delete_product;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get language;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

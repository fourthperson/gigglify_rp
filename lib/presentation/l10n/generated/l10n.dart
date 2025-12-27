// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Gigglify`
  String get app_name {
    return Intl.message('Gigglify', name: 'app_name', desc: '', args: []);
  }

  /// `Press anywhere on the screen for another joke`
  String get usage_description {
    return Intl.message(
      'Press anywhere on the screen for another joke',
      name: 'usage_description',
      desc: '',
      args: [],
    );
  }

  /// `Tap the screen to load a joke`
  String get usage_description1 {
    return Intl.message(
      'Tap the screen to load a joke',
      name: 'usage_description1',
      desc: '',
      args: [],
    );
  }

  /// `Preferences`
  String get preferences {
    return Intl.message('Preferences', name: 'preferences', desc: '', args: []);
  }

  /// `Allowed categories`
  String get allowed_categories {
    return Intl.message(
      'Allowed categories',
      name: 'allowed_categories',
      desc: '',
      args: [],
    );
  }

  /// `Any`
  String get category_any {
    return Intl.message('Any', name: 'category_any', desc: '', args: []);
  }

  /// `Dark`
  String get category_dark {
    return Intl.message('Dark', name: 'category_dark', desc: '', args: []);
  }

  /// `Pun`
  String get category_pun {
    return Intl.message('Pun', name: 'category_pun', desc: '', args: []);
  }

  /// `Spooky`
  String get category_spooky {
    return Intl.message('Spooky', name: 'category_spooky', desc: '', args: []);
  }

  /// `Christmas`
  String get category_christmas {
    return Intl.message(
      'Christmas',
      name: 'category_christmas',
      desc: '',
      args: [],
    );
  }

  /// `Programming`
  String get category_programming {
    return Intl.message(
      'Programming',
      name: 'category_programming',
      desc: '',
      args: [],
    );
  }

  /// `Miscellaneous`
  String get category_misc {
    return Intl.message(
      'Miscellaneous',
      name: 'category_misc',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `Empty`
  String get history_empty {
    return Intl.message('Empty', name: 'history_empty', desc: '', args: []);
  }

  /// `Error Loading History`
  String get history_error {
    return Intl.message(
      'Error Loading History',
      name: 'history_error',
      desc: '',
      args: [],
    );
  }

  /// `Blacklisted categories`
  String get blacklisted_categories {
    return Intl.message(
      'Blacklisted categories',
      name: 'blacklisted_categories',
      desc: '',
      args: [],
    );
  }

  /// `NSFW`
  String get blacklist_nsfw {
    return Intl.message('NSFW', name: 'blacklist_nsfw', desc: '', args: []);
  }

  /// `Religious`
  String get blacklist_religious {
    return Intl.message(
      'Religious',
      name: 'blacklist_religious',
      desc: '',
      args: [],
    );
  }

  /// `Political`
  String get blacklist_political {
    return Intl.message(
      'Political',
      name: 'blacklist_political',
      desc: '',
      args: [],
    );
  }

  /// `Racist`
  String get blacklist_racist {
    return Intl.message('Racist', name: 'blacklist_racist', desc: '', args: []);
  }

  /// `Sexist`
  String get blacklist_sexist {
    return Intl.message('Sexist', name: 'blacklist_sexist', desc: '', args: []);
  }

  /// `Explicit`
  String get blacklist_explicit {
    return Intl.message(
      'Explicit',
      name: 'blacklist_explicit',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

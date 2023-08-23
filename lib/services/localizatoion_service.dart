import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vc/helper/db_sh.dart';

enum Language { english, swedish }

LocaleService localeService = Get.find();

class LocaleService extends GetxService {
  final SharedPreferences sharedPreferences =
      Shared_Preference.sharedPreferences!;

  static const Locale _default = _english;
  static const Locale _english = Locale('en', 'US');
  static const Locale _swedish = Locale('sv', 'SW');

  Locale get handleLocaleInMain {
    switch (_getLanguage) {
      case 'sv':
        return _swedish;
      case 'en':
        return _english;
      default:
        return _default;
    }
  }

  Language getLocale() {
    if (Get.locale?.languageCode == 'sv') {
      return Language.swedish;
    } else {
      return Language.english;
    }
  }

  Future<void> changeLocale(Language language) async {
    if (language == Language.swedish) {
      Get.updateLocale(_swedish);
      await _setLanguage(_swedish.languageCode);
    } else {
      Get.updateLocale(_english);
      await _setLanguage(_english.languageCode);
    }
  }

  Language get getLanguage {
    if (localeService.isEnglish) {
      return Language.english;
    } else {
      return Language.swedish;
    }
  }

  Future<void> toggleLocale() async {
    if (!isEnglish) {
      changeLocale(Language.english);
    } else {
      changeLocale(Language.swedish);
    }
  }

  Locale get defaultLocale => _default;

  bool get isEnglish => Get.locale == _english;

  String? get _getLanguage {
    return sharedPreferences.getString("applanguage");
  }

  Future<bool> _setLanguage(String langCode) async {
    return sharedPreferences.setString("applanguage", langCode);
  }
}

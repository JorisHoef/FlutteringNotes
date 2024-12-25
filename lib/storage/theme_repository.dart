import '../models/theme_model.dart';

abstract class ThemeRepository {
  Future<List<ThemeModel>> fetchThemes();
  Future<void> saveTheme(ThemeModel theme);
  Future<void> deleteTheme(String themeName);
  Future<void> saveSelectedTheme(String themeName);
  Future<String?> fetchSelectedTheme();
  Future<void> saveDarkMode(bool isDarkMode);
  Future<bool?> fetchDarkMode();
}
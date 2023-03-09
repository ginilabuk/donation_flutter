class LocalStorageKeys {
  static String settingsPassword = "70maf00d";

  static bool checkSettingsPassword(String? password) {
    return password == settingsPassword;
  }
}

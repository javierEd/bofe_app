class Config {
  static final Uri bofeApiUrl = Uri.parse(
    const String.fromEnvironment('BOFE_API_URL', defaultValue: 'https://api.bofe.app/'),
  );

  static final String bofeAppToken = const String.fromEnvironment('BOFE_APP_TOKEN');

  static final Uri bofeUrl = Uri.parse(const String.fromEnvironment('BOFE_URL', defaultValue: 'https://bofe.app/'));
}

class Config {
  static final Uri apiUrl = Uri.parse(const String.fromEnvironment('API_URL', defaultValue: 'https://api.bofe.app/'));

  static final String appToken = const String.fromEnvironment('APP_TOKEN');

  static final Uri appUrl = Uri.parse(const String.fromEnvironment('APP_URL', defaultValue: 'https://bofe.app/'));

  static final Uri webSocketUrl = Uri.parse(
    const String.fromEnvironment('WEBSOCKET_URL', defaultValue: 'wss://api.bofe.app/'),
  );
}

class Config {
  static final Uri boardsApiUrl = Uri.parse(
    const String.fromEnvironment('BOARDS_API_URL', defaultValue: 'https://api.boards.mango3.app/'),
  );

  static final Uri boardsUrl = Uri.parse(
    const String.fromEnvironment('BOARDS_URL', defaultValue: 'https://boards.mango3.app/'),
  );
}

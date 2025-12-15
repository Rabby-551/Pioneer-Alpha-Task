base class ApiEndpoints {
  static const String baseUrl = _LocalHostWifi.baseUrl;
  static const String refreshToken = _Auth.refreshToken;

  static const String githubBaseUrl = _GitHub.baseUrl;
  static const String githubTopRepositories = _GitHub.searchRepositories;
}

class _LocalHostWifi {
  static const String baseUrl = 'http://10.10.5.46:8001/api';
}

class _GitHub {
  static const String baseUrl = 'https://api.github.com';
  static const String searchRepositories = '$baseUrl/search/repositories';
}

class _Auth {
  static const String _authRoute = '${_LocalHostWifi.baseUrl}/auth';
  static const String refreshToken = '$_authRoute/refresh-token';
}

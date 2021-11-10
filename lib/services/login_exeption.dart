class LoginException {
  final String code;
  final String message;

  LoginException(this.code, this.message);

  LoginException.fromMap(Map map)
      : this.code = map['code'] ?? map['error'] ?? 'XX',
        this.message = map['message'] ??
            map['error_description'] ??
            map['response']['data']['error'];
}

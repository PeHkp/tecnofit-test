class LoginDetailed {
  final String? token;

  LoginDetailed({required this.token});

  LoginDetailed.fromResponseContent(Map content)
      : this.token = content['token'];

  toMap() {
    return {
      'token': this.token,
    };
  }
}

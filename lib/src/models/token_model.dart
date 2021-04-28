class Token {
  String tokenType;
  int expiresIn;
  String accessToken;

  Token({this.tokenType, this.expiresIn, this.accessToken});

  Token.fromJsonMap(Map<String, dynamic> json) {
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    accessToken = json['access_token'];
  }

  @override
  String toString() {
    return 'type: $tokenType | expires: $expiresIn | token: $accessToken';
  }
}

class TokenData {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final bool phoneVerified;

  TokenData(
      this.accessToken, this.refreshToken, this.expiresIn, this.phoneVerified);

  factory TokenData.fromJson(Map<String, dynamic> json) {
    final String accessToken = json["accessToken"];
    final String refreshToken = json["refreshToken"];
    final int expiresIn = json["expiresIn"];
    final bool phoneVerified = json["phoneVerified"];

    return TokenData(accessToken, refreshToken, expiresIn, phoneVerified);
  }

  Map<String, dynamic> toJson() {
    return {
      "accessToken": accessToken,
      "refreshToken": refreshToken,
      "expiresIn": expiresIn,
      "phoneVerified": phoneVerified
    };
  }
}

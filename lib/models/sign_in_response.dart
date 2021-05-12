class SignInResponse {
  final String token;
  final String userId;
  final String expiresAt;

  SignInResponse({this.expiresAt, this.token, this.userId});

  factory SignInResponse.fromJson(json) {
    return SignInResponse(
      token: json["token"],
      expiresAt: json["expiresAt"],
      userId: json["userId"],
    );
  }
}

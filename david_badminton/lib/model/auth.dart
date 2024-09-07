class Auth {
  String client_id;
  String client_secret;
  String grant_type;
  String username;
  String password;

  Auth(
      {required this.client_id,
      required this.client_secret,
      required this.grant_type,
      required this.username,
      required this.password});

  factory Auth.fromJson(Map<String, dynamic> json) {
    //chuyeenr json thanh
    return Auth(
      client_id: json['client_id'],
      client_secret: json['client_secret'],
      grant_type: json['grant_type'],
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['client_id'] = client_id;
    data['client_secret'] = client_secret;
    data['grant_type'] = grant_type;
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}

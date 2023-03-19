class SteamUser {
  final String personaName;
  final String avatarUrl;

  SteamUser({required this.personaName, required this.avatarUrl});

  factory SteamUser.fromJson(Map<String, dynamic> json) {
    return SteamUser(
      personaName: json['personaname'],
      avatarUrl: json['avatarfull'],
    );
  }
}

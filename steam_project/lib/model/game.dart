class Game {
  String steam_appid;
  String name;
  bool isFree;
  String shortDescription;
  String description;
  String headerImage;
  List<String> developers;
  String backgroundRaw;
  String background;
  String? final_formatted;
  Game({
    required this.steam_appid,
    required this.name,
    required this.isFree,
    required this.shortDescription,
    required this.description,
    required this.headerImage,
    required this.developers,
    required this.backgroundRaw,
    required this.background,
    this.final_formatted,
  }) {
    if (isFree) {
      final_formatted = null;
    }
  }

  Game.fromJson(Map<String, dynamic> json)
      : steam_appid = json['steam_appid'],
        name = json['name'],
        isFree = json['is_free'],
        shortDescription = json['short_description'],
        description = json['about_the_game'],
        headerImage = json['header_image'],
        developers = json['developers'].cast<String>(),
        backgroundRaw = json['background_raw'],
        background = json['background'],
        final_formatted = json['final_formatted'];

  Map<String, dynamic> toJson() => {
        'steam_appid': steam_appid,
        'name': name,
        'is_free': isFree,
        'short_description': shortDescription,
        'description': description,
        'header_image': headerImage,
        'developers': developers,
        'backgroundRaw': backgroundRaw,
        'background': background,
        'final_formatted': final_formatted,
      };
}

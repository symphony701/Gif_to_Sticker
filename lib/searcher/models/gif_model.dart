class Gif {
  String? name;
  String? url;
  double? height;
  double? width;
  String? mediumUrl;
  double? mediumHeight;
  double? mediumWidth;
  String? nanoUrl;
  String? nameFile;
  String? urlWebp;

  Gif({this.url, this.width, this.height});

  Gif.fromJson(Map<String, dynamic> json) {
    url = json['media_formats']['tinygif']['url'];
    width = json['media_formats']['tinygif']['dims'][0].toDouble();
    height = json['media_formats']['tinygif']['dims'][1].toDouble();
    nameFile =
        '${json['content_description']}_${DateTime.now().toString().replaceAll(':', '')}.webp';
    name = json['content_description'];
    nanoUrl = json['media_formats']['nanogif']['url'];
    mediumUrl = json['media_formats']['mediumgif']['url'];
    mediumWidth = json['media_formats']['mediumgif']['dims'][0].toDouble();
    mediumHeight = json['media_formats']['mediumgif']['dims'][1].toDouble();
  }
}

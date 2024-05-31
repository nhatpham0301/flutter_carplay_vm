class CPMapPoint {
  final String? title;
  final String? subTitle;
  final double? lat;
  final double? lng;

  CPMapPoint({
    this.title,
    this.subTitle,
    this.lng,
    this.lat,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'subTitle': subTitle,
        'lng': lng,
        'lat': lat,
      };
}

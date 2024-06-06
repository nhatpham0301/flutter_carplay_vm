class CPMapListHeader {
  final String? nameTrip;
  final String? title;
  final String? titleTime;
  final String? distance;
  final String? time;

  CPMapListHeader({
    this.nameTrip,
    this.title,
    this.titleTime,
    this.distance,
    this.time,
  });

  Map<String, dynamic> toJson() => {
        'nameTrip': nameTrip,
        'title': title,
        'titleTime': titleTime,
        'distance': distance,
        'time': time,
      };

  CPMapListHeader copyWith({
    String? nameTrip,
    String? title,
    String? titleTime,
    String? distance,
    String? time,
  }) {
    return CPMapListHeader(
      nameTrip: nameTrip ?? this.nameTrip,
      title: title ?? this.title,
      titleTime: titleTime ?? this.titleTime,
      distance: distance ?? this.distance,
      time: time ?? this.time,
    );
  }
}

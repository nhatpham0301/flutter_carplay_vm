class CPMapListHeader {
  final String? title;
  final String? titleTime;
  final String? distance;
  final String? time;

  CPMapListHeader({
    this.title,
    this.titleTime,
    this.distance,
    this.time,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'titleTime': titleTime,
        'distance': distance,
        'time': time,
      };

  CPMapListHeader copyWith({
    String? title,
    String? titleTime,
    String? distance,
    String? time,
  }) {
    return CPMapListHeader(
      title: title ?? this.title,
      titleTime: titleTime ?? this.titleTime,
      distance: distance ?? this.distance,
      time: time ?? this.time,
    );
  }
}

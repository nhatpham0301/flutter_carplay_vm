class CPMapList {
  final String? time;
  final String? title;
  final String? address;
  final bool? isCheckIn;
  final bool? isCurrentPoint;
  final bool? isNextPoint;
  final bool? isShowLabelUserConfirm;
  final bool? isShowUserDrop;
  final bool? isShowUserPick;
  final bool? isConfirmUser;
  final String? confirmUser;
  final String? userPick;
  final String? userDrop;
  final String? estimateTime;
  final bool? lateEstimateTimeLate;
  final double? lat;
  final double? lng;

  CPMapList({
    this.time,
    this.title,
    this.address,
    this.isCheckIn,
    this.isCurrentPoint,
    this.isNextPoint,
    this.isShowLabelUserConfirm,
    this.isShowUserDrop,
    this.isShowUserPick,
    this.isConfirmUser,
    this.confirmUser,
    this.userPick,
    this.userDrop,
    this.estimateTime,
    this.lateEstimateTimeLate,
    this.lng,
    this.lat,
  });

  Map<String, dynamic> toJson() => {
        'time': time,
        'title': title,
        'address': address,
        'isCheckIn': isCheckIn,
        'isCurrentPoint': isCurrentPoint,
        'isNextPoint': isNextPoint,
        'isShowLabelUserConfirm': isShowLabelUserConfirm,
        'isShowUserDrop': isShowUserDrop,
        'isShowUserPick': isShowUserPick,
        'isConfirmUser': isConfirmUser,
        'confirmUser': confirmUser,
        'userPick': userPick,
        'userDrop': userDrop,
        'estimateTime': estimateTime,
        'lateEstimateTimeLate': lateEstimateTimeLate,
        'lng': lng,
        'lat': lat,
      };

  CPMapList copyWith({
    String? time,
    String? title,
    String? address,
    bool? isCheckIn,
    bool? isCurrentPoint,
    bool? isNextPoint,
    bool? isShowLabelUserConfirm,
    bool? isShowUserDrop,
    bool? isShowUserPick,
    bool? isConfirmUser,
    String? confirmUser,
    String? userPick,
    String? userDrop,
    String? estimateTime,
    bool? lateEstimateTimeLate,
    double? lat,
    double? lng,
  }) {
    return CPMapList(
      time: time ?? this.time,
      title: title ?? this.title,
      address: address ?? this.address,
      isCheckIn: isCheckIn ?? this.isCheckIn,
      isCurrentPoint: isCurrentPoint ?? this.isCurrentPoint,
      isNextPoint: isNextPoint ?? this.isNextPoint,
      isShowLabelUserConfirm:
          isShowLabelUserConfirm ?? this.isShowLabelUserConfirm,
      isShowUserDrop: isShowUserDrop ?? this.isShowUserDrop,
      isShowUserPick: isShowUserPick ?? this.isShowUserPick,
      isConfirmUser: isConfirmUser ?? this.isConfirmUser,
      confirmUser: confirmUser ?? this.confirmUser,
      userPick: userPick ?? this.userPick,
      userDrop: userDrop ?? this.userDrop,
      estimateTime: estimateTime ?? this.estimateTime,
      lateEstimateTimeLate: lateEstimateTimeLate ?? this.lateEstimateTimeLate,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }
}

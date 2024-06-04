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
        'lng': lng,
        'lat': lat,
      };
}

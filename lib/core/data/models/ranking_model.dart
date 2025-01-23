

import 'package:citizen_app/core/entity/leaderboards.dart';

class LeaderboardModel extends LeaderboardEntity {

  LeaderboardModel({
    super.id,
    super.avatar,
    super.points,
    super.userId,
    super.username,
});


  factory LeaderboardModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardModel(
      id: json['id'],
      avatar: json['avatar'],
      points: json['points'],
      userId: json['id'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toMap (){
    return {
      "username" : username,
      "points": points,
      "avatar": avatar,
    };
}

}
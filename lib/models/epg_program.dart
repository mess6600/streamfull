class EPGProgram {
  final String channelId;
  final String title;
  final String? description;
  final DateTime startTime;
  final DateTime endTime;
  final String? category;
  final String? icon;

  EPGProgram({
    required this.channelId,
    required this.title,
    this.description,
    required this.startTime,
    required this.endTime,
    this.category,
    this.icon,
  });

  bool get isCurrentlyAiring {
    final now = DateTime.now();
    return now.isAfter(startTime) && now.isBefore(endTime);
  }

  String get duration {
    final diff = endTime.difference(startTime);
    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;
    if (hours > 0) return '${hours}h ${minutes}m';
    return '${minutes}m';
  }

  Map<String, dynamic> toJson() {
    return {
      'channelId': channelId,
      'title': title,
      'description': description,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'category': category,
      'icon': icon,
    };
  }

  factory EPGProgram.fromJson(Map<String, dynamic> json) {
    return EPGProgram(
      channelId: json['channelId'],
      title: json['title'],
      description: json['description'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      category: json['category'],
      icon: json['icon'],
    );
  }
}

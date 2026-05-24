import 'channel.dart';

class Playlist {
  final String id;
  final String name;
  final String? url;
  final List<Channel> channels;
  final DateTime createdAt;
  final String? epgUrl;
  bool isActive;

  Playlist({
    required this.id,
    required this.name,
    this.url,
    required this.channels,
    required this.createdAt,
    this.epgUrl,
    this.isActive = true,
  });

  List<String> get groups {
    final groups = channels.map((c) => c.group).whereType<String>().toSet().toList();
    groups.sort();
    return groups;
  }

  List<Channel> getChannelsByGroup(String group) {
    if (group == 'All') return channels;
    if (group == 'Favorites') return channels.where((c) => c.isFavorite).toList();
    return channels.where((c) => c.group == group).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'channels': channels.map((c) => c.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'epgUrl': epgUrl,
      'isActive': isActive,
    };
  }

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      channels: (json['channels'] as List).map((c) => Channel.fromJson(c)).toList(),
      createdAt: DateTime.parse(json['createdAt']),
      epgUrl: json['epgUrl'],
      isActive: json['isActive'] ?? true,
    );
  }
}

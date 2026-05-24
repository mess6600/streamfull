import 'package:flutter/foundation.dart';

class Channel {
  final String id;
  final String name;
  final String url;
  final String? logo;
  final String? group;
  final String? epgId;
  bool isFavorite;
  final Map<String, dynamic>? extraData;

  Channel({
    required this.id,
    required this.name,
    required this.url,
    this.logo,
    this.group,
    this.epgId,
    this.isFavorite = false,
    this.extraData,
  });

  Channel copyWith({
    String? id,
    String? name,
    String? url,
    String? logo,
    String? group,
    String? epgId,
    bool? isFavorite,
    Map<String, dynamic>? extraData,
  }) {
    return Channel(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      logo: logo ?? this.logo,
      group: group ?? this.group,
      epgId: epgId ?? this.epgId,
      isFavorite: isFavorite ?? this.isFavorite,
      extraData: extraData ?? this.extraData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'logo': logo,
      'group': group,
      'epgId': epgId,
      'isFavorite': isFavorite,
      'extraData': extraData,
    };
  }

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      logo: json['logo'],
      group: json['group'],
      epgId: json['epgId'],
      isFavorite: json['isFavorite'] ?? false,
      extraData: json['extraData'] != null ? Map<String, dynamic>.from(json['extraData']) : null,
    );
  }
}

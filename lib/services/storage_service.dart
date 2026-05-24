import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/channel.dart';
import '../models/playlist.dart';
import '../models/epg_program.dart';

class StorageService {
  static const String _playlistsKey = 'playlists';
  static const String _epgKey = 'epg_data';
  static const String _favoritesKey = 'favorites';
  static const String _settingsKey = 'settings';

  Future<void> savePlaylist(Playlist playlist) async {
    final prefs = await SharedPreferences.getInstance();
    final playlists = await getAllPlaylists();

    playlists.removeWhere((p) => p.id == playlist.id);
    playlists.add(playlist);

    final data = playlists.map((p) => p.toJson()).toList();
    await prefs.setString(_playlistsKey, jsonEncode(data));
  }

  Future<List<Playlist>> getAllPlaylists() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_playlistsKey);

    if (data == null) return [];

    final List<dynamic> jsonList = jsonDecode(data);
    return jsonList.map((j) => Playlist.fromJson(j)).toList();
  }

  Future<void> deletePlaylist(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final playlists = await getAllPlaylists();
    playlists.removeWhere((p) => p.id == id);

    final data = playlists.map((p) => p.toJson()).toList();
    await prefs.setString(_playlistsKey, jsonEncode(data));
  }

  Future<void> toggleFavorite(String channelId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];

    if (favorites.contains(channelId)) {
      favorites.remove(channelId);
    } else {
      favorites.add(channelId);
    }

    await prefs.setStringList(_favoritesKey, favorites);
  }

  Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoritesKey) ?? [];
  }

  Future<void> saveEPG(List<EPGProgram> programs) async {
    final prefs = await SharedPreferences.getInstance();
    final data = programs.map((p) => p.toJson()).toList();
    await prefs.setString(_epgKey, jsonEncode(data));
  }

  Future<List<EPGProgram>> getAllEPG() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_epgKey);

    if (data == null) return [];

    final List<dynamic> jsonList = jsonDecode(data);
    return jsonList.map((j) => EPGProgram.fromJson(j)).toList();
  }

  Future<void> saveSettings(Map<String, dynamic> settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_settingsKey, jsonEncode(settings));
  }

  Future<Map<String, dynamic>> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_settingsKey);
    return data != null ? jsonDecode(data) : {};
  }
}

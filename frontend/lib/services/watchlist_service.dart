import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class WatchlistService {
  static const String _key = 'watchlist';

  static Future<void> addToWatchlist(Map<String, dynamic> movie) async {
    final prefs = await SharedPreferences.getInstance();
    final String? existing = prefs.getString(_key);
    List<dynamic> watchlist = existing != null ? jsonDecode(existing) : [];
    
    // Check if already exists
    if (!watchlist.any((m) => m['id'] == movie['id'])) {
      watchlist.add(movie);
      await prefs.setString(_key, jsonEncode(watchlist));
    }
  }

  static Future<List<Map<String, dynamic>>> getWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    final String? existing = prefs.getString(_key);
    if (existing == null) return [];
    return List<Map<String, dynamic>>.from(jsonDecode(existing));
  }

  static Future<void> removeFromWatchlist(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? existing = prefs.getString(_key);
    if (existing == null) return;
    
    List<dynamic> watchlist = jsonDecode(existing);
    watchlist.removeWhere((m) => m['id'] == movieId);
    await prefs.setString(_key, jsonEncode(watchlist));
  }
}

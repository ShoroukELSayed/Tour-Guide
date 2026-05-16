import 'dart:convert';
import 'package:http/http.dart' as http;

class WikiService {

  String extractMainName(String name) {
    if (name.isEmpty) return name;
    return name.split(',').first.trim();
  }

  Future<String> getPlaceDescription(String placeName) async {
    try {
      final cleanName = extractMainName(placeName);

      // 🔥 نحاول كذا query
      final queries = [
        "$cleanName Egypt",
        cleanName,
      ];

      for (String q in queries) {
        final result = await _tryFetch(q);
        if (result != null) return result;
      }

      return 'No description found.';
    } catch (e) {
      return 'Error loading description.';
    }
  }

  Future<String?> _tryFetch(String query) async {
    try {
      final encoded = Uri.encodeComponent(query);

      final searchUrl =
          'https://en.wikipedia.org/w/rest.php/v1/search/title?q=$encoded&limit=1';

      final searchResponse = await http.get(Uri.parse(searchUrl));

      if (searchResponse.statusCode == 200) {
        final searchData = jsonDecode(searchResponse.body);

        if (searchData['pages'] != null &&
            searchData['pages'].isNotEmpty) {

          final title = searchData['pages'][0]['title']
              .toString()
              .replaceAll(' ', '_');

          final summary = await _fetchSummary(title);

          if (summary != null) return summary;
        }
      }

      // 🔥 fallback: نجرب query مباشرة كـ title
      final fallbackTitle = query.replaceAll(' ', '_');
      final summary = await _fetchSummary(fallbackTitle);

      return summary;

    } catch (e) {
      return null;
    }
  }

  Future<String?> _fetchSummary(String title) async {
    try {
      final url =
          'https://en.wikipedia.org/api/rest_v1/page/summary/$title';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['extract'] != null &&
            data['extract'].toString().isNotEmpty) {
          return data['extract'];
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }
}
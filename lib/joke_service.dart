import 'dart:convert';
import 'package:http/http.dart' as http;
import 'joke_model.dart';

class JokeService {
  final String baseUrl = 'https://v2.jokeapi.dev/joke/Any';

  Future<Joke> fetchRandomJoke() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['type'] == 'single') {
        return Joke(setup: '', punchline: jsonResponse['joke']);
      } else {
        return Joke(setup: jsonResponse['setup'], punchline: jsonResponse['delivery']);
      }
    } else {
      throw Exception('Failed to load joke');
    }
  }
}
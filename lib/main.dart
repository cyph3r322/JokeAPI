import 'package:flutter/material.dart';
import 'joke_service.dart';
import 'joke_model.dart';

void main() {
  runApp(JokeApp());
}

class JokeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Генератор не очень смешных шуток(EN)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JokeHomePage(),
    );
  }
}

class JokeHomePage extends StatefulWidget {
  @override
  _JokeHomePageState createState() => _JokeHomePageState();
}

class _JokeHomePageState extends State<JokeHomePage> {
  late Future<Joke> futureJoke;

  @override
  void initState() {
    super.initState();
    futureJoke = JokeService().fetchRandomJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Joke'),
      ),
      body: Center(
        child: FutureBuilder<Joke>(
          future: futureJoke,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    snapshot.data!.setup,
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    snapshot.data!.punchline,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        futureJoke = JokeService().fetchRandomJoke();
                      });
                    },
                    child: Text('Сгенерировать шутку'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
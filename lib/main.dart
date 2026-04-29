import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Act. 3.5 HomeScreen',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 134, 46, 175)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Scaffold(
      body: Stack(
        children: [

          // Imagen de fondo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondo.jfif'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Capa oscura para mejor visibilidad del texto
          Container(
            color: Colors.black.withOpacity(0.4),
          ),

          // Contenido principal
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // Nombre de la aplicación
                  Text(
                    'Mi Primera App Flutter',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 20),

                  // Mensaje de bienvenida
                  Text(
                    'Bienvenido a tu aplicación móvil',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 30),

                  // Tarjeta principal
                  BigCard(pair: pair),

                  SizedBox(height: 20),

                  // Botones
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      ElevatedButton.icon(
                        onPressed: () {
                          appState.toggleFavorite();
                        },
                        icon: Icon(icon),
                        label: Text('Like'),
                      ),

                      SizedBox(width: 10),

                      ElevatedButton(
                        onPressed: () {
                          appState.getNext();
                        },
                        child: Text('Next'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
} 

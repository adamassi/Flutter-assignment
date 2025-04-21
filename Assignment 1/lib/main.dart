// // // import 'package:flutter/material.dart';
// // // // Add this line.
// // // import 'package:english_words/english_words.dart';  // Add this line.
// // // import 'package:flutter/material.dart';
// // // void main() {
// // //   runApp(const MyApp());
// // // }

// // // class MyApp extends StatelessWidget {
// // //   const MyApp({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final wordPair = WordPair.random(); // Add this line.
// // //     return MaterialApp(
// // //       title: 'Welcome to Flutter',
// // //       home: Scaffold(
// // //         appBar: AppBar(
// // //           title: const Text('Welcome to Flutter'),
// // //         ),
// // //         body: const Center(
// // //           child: Text('Hello World'),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:english_words/english_words.dart';
// // import 'package:flutter/material.dart';

// // class RandomWords extends StatefulWidget {
// //   const RandomWords({super.key});

// //   @override
// //   State<RandomWords> createState() => _RandomWordsState();
// // }
// // class _RandomWordsState extends State<RandomWords> {
// //   void _pushSaved() {
// //     Navigator.of(context).push(
// //       MaterialPageRoute<void>(
// //         builder: (context) {
// //           final tiles = _saved.map(
// //             (pair) {
// //               return ListTile(
// //                 title: Text(
// //                   pair.asPascalCase,
// //                   style: _biggerFont,
// //                 ),
// //               );
// //             },
// //           );
// //           final divided = tiles.isNotEmpty
// //               ? ListTile.divideTiles(
// //                   context: context,
// //                   tiles: tiles,
// //                 ).toList()
// //               : <Widget>[];

// //           return Scaffold(
// //             appBar: AppBar(
// //               title: const Text('Saved Suggestions'),
// //             ),
// //             body: ListView(children: divided),
// //           );
// //         },
// //       ), // 
// //   );
// //   }
// //   final _suggestions = <WordPair>[];
// //    final _saved = <WordPair>{};     // NEW                 // NEW
// //   final _biggerFont = const TextStyle(fontSize: 18); // NEW
// //   @override                                  
// //   Widget build(BuildContext context) {
// //      return Scaffold(   // NEW from here ...
// //       appBar: AppBar(  
// //         title: const Text('Startup Name Generator'),
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.list),
// //             onPressed: _pushSaved,
// //             tooltip: 'Saved Suggestions',
// //           ),
// //         ],
// //       ),               
// //       body: ListView.builder(  // to here.
// //     // final wordPair = WordPair.random();      // NEW
// //     // return Text(wordPair.asPascalCase);      // NEW

// //       padding: const EdgeInsets.all(16.0),
// //       itemBuilder: (context, i) {
// //         if (i.isOdd) return const Divider();

// //         final index = i ~/ 2;
// //         if (index >= _suggestions.length) {
// //           _suggestions.addAll(generateWordPairs().take(10));
// //         }
// //         final alreadySaved = _saved.contains(_suggestions[index]); // NEW
// //         return ListTile(
// //   title: Text(
// //     _suggestions[index].asPascalCase,
// //     style: _biggerFont,
// //   ),
// //   trailing: Icon(
// //     alreadySaved ? Icons.favorite : Icons.favorite_border,
// //     color: alreadySaved ? Colors.red : null,
// //     semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
// //   ),
// //   onTap: () {          // NEW from here ...
// //     setState(() {
// //       if (alreadySaved) {
// //         _saved.remove(_suggestions[index]);
// //       } else {
// //         _saved.add(_suggestions[index]);
// //       }
// //     });                // to here.
// //   },
        
// // );

// //         },),
// //     );
// //   }                                         
// // }

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     //final wordPair = WordPair.random(); // Add this line.
// //     return MaterialApp(          // Remove the const from here
// //       title: 'Startup Name Generator',
// //       theme: ThemeData(          // Add the 5 lines from here... 
// //         appBarTheme: const AppBarTheme(
// //           backgroundColor: Colors.white,
// //           foregroundColor: Colors.black,
// //         ),
// //       ),                         // ... to here.
// //       home: const RandomWords(), // And add the const back here.
// //     );
// //   }
// // }







// import 'package:english_words/english_words.dart';
// import 'package:flutter/material.dart';

// class RandomWords extends StatefulWidget {
//   const RandomWords({super.key});

//   @override
//   State<RandomWords> createState() => _RandomWordsState();
// }

// class _RandomWordsState extends State<RandomWords> {
//   void _pushSaved() {
//     Navigator.of(context).push(
//       MaterialPageRoute<void>(
//         builder: (context) {
//           final tiles = _saved.map(
//             (pair) {
//               return ListTile(
//                 title: Text(
//                   pair.asPascalCase,
//                   style: _biggerFont,
//                 ),
//               );
//             },
//           );
//           final divided = tiles.isNotEmpty
//               ? ListTile.divideTiles(
//                   context: context,
//                   tiles: tiles,
//                 ).toList()
//               : <Widget>[];

//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('Saved Suggestions'),
//             ),
//             body: ListView(children: divided),
//           );
//         },
//       ),
//     );
//   }

//   final _suggestions = <WordPair>[];
//   final _saved = <WordPair>{};
//   final _biggerFont = const TextStyle(fontSize: 18);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Startup Name Generator'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.list),
//             onPressed: _pushSaved,
//             tooltip: 'Saved Suggestions',
//           ),
//           IconButton(
//             icon: const Icon(Icons.login),
//             onPressed: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(builder: (context) => const LoginScreen()),
//               );
//             },
//             tooltip: 'Login',
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16.0),
//         itemBuilder: (context, i) {
//           if (i.isOdd) return const Divider();

//           final index = i ~/ 2;
//           if (index >= _suggestions.length) {
//             _suggestions.addAll(generateWordPairs().take(10));
//           }
//           final alreadySaved = _saved.contains(_suggestions[index]);
//           return ListTile(
//             title: Text(
//               _suggestions[index].asPascalCase,
//               style: _biggerFont,
//             ),
//             trailing: Icon(
//               alreadySaved ? Icons.favorite : Icons.favorite_border,
//               color: alreadySaved ? Colors.red : null,
//               semanticLabel:
//                   alreadySaved ? 'Remove from saved' : 'Save',
//             ),
//             onTap: () {
//               setState(() {
//                 if (alreadySaved) {
//                   _saved.remove(_suggestions[index]);
//                 } else {
//                   _saved.add(_suggestions[index]);
//                 }
//               });
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final _formKey = GlobalKey<FormState>();
//     String email = '';
//     String password = '';

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                     return 'Please enter a valid email address';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   email = value!;
//                 },
//               ),
//               const SizedBox(height: 16.0),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Password',
//                   border: OutlineInputBorder(),
//                 ),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   password = value!;
//                 },
//               ),
//               const SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Logging in as $email')),
//                     );
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: const Text('Login'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Startup Name Generator',
//       theme: ThemeData(
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black,
//         ),
//       ),
//       home: const RandomWords(),
//     );
//   }
// }
//Exercise 1: Write your rst Flutter ::



import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView.builder(
              itemCount: _saved.length,
              itemBuilder: (context, index) {
                final suggestion = _saved.elementAt(index);
                return Dismissible(
                  key: Key(suggestion.asPascalCase),
                  direction: DismissDirection.horizontal,
                  background: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: const [
                        Icon(Icons.delete, color: Colors.white),
                        SizedBox(width: 8.0),
                        Text(
                          'Delete Suggestion',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          'Delete Suggestion',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 8.0),
                        Icon(Icons.delete, color: Colors.white),
                      ],
                    ),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      _saved.remove(suggestion);
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${suggestion.asPascalCase} deleted'),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(
                      suggestion.asPascalCase,
                      style: _biggerFont,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: 'Saved Suggestions',
          ),
          IconButton(
            icon: const Icon(Icons.login),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            tooltip: 'Login',
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          final alreadySaved = _saved.contains(_suggestions[index]);
          return ListTile(
            title: Text(
              _suggestions[index].asPascalCase,
              style: _biggerFont,
            ),
            trailing: Icon(
              alreadySaved ? Icons.star : Icons.star_border, // Changed to star icon
              color: alreadySaved ? Colors.deepPurple : null, // Matches the primary color
              semanticLabel:
                  alreadySaved ? 'Remove from saved' : 'Save',
            ),
            onTap: () {
              setState(() {
                if (alreadySaved) {
                  _saved.remove(_suggestions[index]);
                } else {
                  _saved.add(_suggestions[index]);
                }
              });
            },
          );
        },
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String email = '';
    String password = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onSaved: (value) {
                  email = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onSaved: (value) {
                  password = value!;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Logging in as $email')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, // Changed to deepPurple
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple, // Matches primary color
          foregroundColor: Colors.white,
        ),
      ),
      home: const RandomWords(),
    );
  }
}

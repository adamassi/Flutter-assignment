import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import
import 'package:english_words/english_words.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(snapshot.error.toString(),
                  textDirection: TextDirection.ltr),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);

  // Add Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Modify _pushSaved to use Firestore and user-specific collection
  void _pushSaved() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('users').doc(user.uid).collection('suggestions').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final suggestions = snapshot.data!.docs.map((doc) => WordPair(doc['first'], doc['second'])).toList();
                return ListView.builder(
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final suggestion = suggestions[index];
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
                      confirmDismiss: (direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete Suggestion'),
                              content: Text('Are you sure you want to delete this suggestion?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(true),
                                  child: Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      onDismissed: (direction) {
                        _firestore.collection('users').doc(user.uid).collection('suggestions').doc(snapshot.data!.docs[index].id).delete();
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
                        trailing: Icon(
                          _saved.contains(suggestion) ? Icons.star : Icons.star_border,
                          color: _saved.contains(suggestion) ? Colors.yellow : null,
                        ),
                        onTap: () {
                          setState(() {
                            if (_saved.contains(suggestion)) {
                              _saved.remove(suggestion);
                              _firestore.collection('users').doc(user.uid).collection('suggestions').doc(snapshot.data!.docs[index].id).delete();
                            } else {
                              _saved.add(suggestion);
                              _firestore.collection('users').doc(user.uid).collection('suggestions').add({'first': suggestion.first, 'second': suggestion.second});
                            }
                          });
                        },
                      ),
                    );
                  },
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
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hide the back arrow
        title: const Text('Startup Name Generator'),
        actions: [
          IconButton(
            icon: Icon(user != null ? Icons.exit_to_app : Icons.login),
            onPressed: () async {
              if (user != null) {
                await FirebaseAuth.instance.signOut();
                setState(() {
                  _saved.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Successfully logged out')),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              }
            },
            tooltip: user != null ? 'Logout' : 'Login',
          ),
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: 'Saved Suggestions',
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
              alreadySaved ? Icons.star : Icons.star_border,
              color: alreadySaved ? Colors.deepPurple : null,
              semanticLabel:
                  alreadySaved ? 'Remove from saved' : 'Save',
            ),
            onTap: () {
              setState(() {
                if (alreadySaved) {
                  _saved.remove(_suggestions[index]);
                  _firestore.collection('users').doc(user?.uid).collection('suggestions').where('first', isEqualTo: _suggestions[index].first).where('second', isEqualTo: _suggestions[index].second).get().then((snapshot) {
                    for (DocumentSnapshot doc in snapshot.docs) {
                      doc.reference.delete();
                    }
                  });
                } else {
                  _saved.add(_suggestions[index]);
                  _firestore.collection('users').doc(user?.uid).collection('suggestions').add({'first': _suggestions[index].first, 'second': _suggestions[index].second});
                }
              });
            },
          );
        },
      ),
    );
  }
}

// create myApp class
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
    );
  }
}


// Define an enum for the authentication status
enum Status { Unauthenticated, Authenticating, Authenticated }

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Add the _status variable
  Status _status = Status.Unauthenticated;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _status = Status.Authenticating;
      });

      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        setState(() {
          _status = Status.Authenticated;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully logged in as ${userCredential.user?.email}')),
        );
        // Navigate to RandomWords screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RandomWords()),
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          _status = Status.Unauthenticated;
        });

        String message;
        switch (e.code) {
          case 'invalid-email':
            message = 'The email address is not valid.';
            break;
          case 'user-disabled':
            message = 'The user account has been disabled.';
            break;
          case 'user-not-found':
            message = 'No user found for that email.';
            break;
          case 'wrong-password':
            message = 'Wrong password provided.';
            break;
          default:
            message = 'An unknown error occurred: ${e.message}';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RandomWords()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully signed up')),
        );
      } on FirebaseAuthException catch (e) {
        String message;
        switch (e.code) {
          case 'email-already-in-use':
            message = 'The email address is already in use.';
            break;
          case 'invalid-email':
            message = 'The email address is not valid.';
            break;
          case 'operation-not-allowed':
            message = 'Email/password accounts are not enabled.';
            break;
          case 'weak-password':
            message = 'The password is too weak.';
            break;
          default:
            message = 'An unknown error occurred: ${e.message}';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              if (_status == Status.Authenticating) CircularProgressIndicator(),
              if (_status == Status.Unauthenticated)
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Login'),
                ),
              if (_status == Status.Authenticated)
                Text('You are logged in!'),
              SizedBox(height: 20),
              if (_status == Status.Unauthenticated || _status == Status.Authenticated)
                ElevatedButton(
                  onPressed: _signUp,
                  child: Text('Sign up'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully signed up')),
        );

        Navigator.pop(context); // Navigate back to the login screen
      } on FirebaseAuthException {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('There was an error signing up')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _signUp,
                      child: Text('Sign Up'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}


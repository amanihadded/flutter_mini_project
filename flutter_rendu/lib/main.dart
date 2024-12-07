import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rendu/firebase_options.dart';
import 'package:flutter_rendu/screens/pet_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AdoPet - Adoption de Chiens',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Arial', // Typographie principale
      ),
      home: AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isSignIn = true;
  final _formKey = GlobalKey<FormState>();
  String emailAddress = '';
  String password = '';

  void _switchAuthMode() {
    setState(() {
      _isSignIn = !_isSignIn;
    });
  }

  Future<void> _authenticate() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (_isSignIn) {
          final credential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );
          _navigateToDogList();
        } else {
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );
          _navigateToDogList();
        }
      } on FirebaseAuthException catch (e) {
        _handleAuthError(e);
      } catch (e) {
        print(e);
      }
    }
  }

  void _navigateToDogList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DogListScreen()),
    );
  }

  void _handleAuthError(FirebaseAuthException e) {
    String message;
    if (e.code == 'user-not-found' || e.code == 'wrong-password') {
      message = 'Identifiant ou mot de passe incorrect.';
    } else if (e.code == 'weak-password') {
      message = 'Le mot de passe est trop faible.';
    } else if (e.code == 'email-already-in-use') {
      message = 'Le compte existe déjà pour cet email.';
    } else {
      message = 'Une erreur inconnue est survenue.';
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isSignIn ? 'Connexion' : 'Inscription'),
        actions: [
          TextButton(
            onPressed: _switchAuthMode,
            child: Text(_isSignIn ? 'Créer un compte' : 'Se connecter'),
          ),
        ],
        backgroundColor: Colors.teal, // Couleur de fond de l'appBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                _isSignIn
                    ? 'Bienvenue sur AdoPet!'
                    : 'Créez un compte sur AdoPet!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal, // Couleur du texte
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.teal),
                  prefixIcon: Icon(Icons.email, color: Colors.teal),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Veuillez entrer un email valide';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    emailAddress = value;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  labelStyle: TextStyle(color: Colors.teal),
                  prefixIcon: Icon(Icons.lock, color: Colors.teal),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty || value.length < 6) {
                    return 'Le mot de passe doit comporter au moins 6 caractères';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _authenticate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Couleur du bouton
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  _isSignIn ? 'Se connecter' : 'S\'inscrire',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

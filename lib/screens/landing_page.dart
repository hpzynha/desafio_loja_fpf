import 'package:desafio_loja/constants.dart';
import 'package:desafio_loja/screens/home_page.dart';
import 'package:desafio_loja/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Se snapshot der error // If Firebase App init, snapshot has error
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }
        // Conection Initialized - Firebasse App is running
        if (snapshot.connectionState == ConnectionState.done) {
          // StreamBuilder permite checar o login state ao vivo.
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (contex, streamSnapshot) {
              // Se StreamSnapshot der error
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error: ${streamSnapshot.error}'),
                  ),
                );
              }
              // Connection state active - O usuario fez o login
              if (streamSnapshot.connectionState == ConnectionState.active) {
                // Get the User
                // Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();
                Object? _user = streamSnapshot.data;
                // If the user is null, não está logado
                if (_user == null) {
                  // User not logged in, vai pro login
                  return LoginPage();
                } else {
                  // The user is logged in,vai pra homepage
                  return HomePage();
                }
              }

              // checando o auth start - Loading
              return Scaffold(
                body: Center(
                  child: Text(
                    'Checking Authentication...',
                    style: Constants.regularHeading,
                  ),
                ),
              );
            },
          );
        }
        //conectando ao firebase - Loading
        return Scaffold(
          body: Center(
            child: Text(
              'Initalization App...',
              style: Constants.regularHeading,
            ),
          ),
        );
      },
    );
  }
}

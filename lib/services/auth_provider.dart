import 'package:coffeasy/services/auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends InheritedWidget {
  AuthProvider({
    Key? key,
    required this.auth,
    required this.child,
  }) : super(key: key, child: child);

  final AuthBase auth;
  final Widget child;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static AuthBase of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<AuthProvider>();
    if (provider != null){
      return provider.auth;
    } else {
      throw StateError('Could not find ancestor widget of type AuthProvider');
    }
  }
}

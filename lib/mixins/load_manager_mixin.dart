import 'package:flutter/material.dart';
import 'package:flutter_itschools_login/utils/auth_states.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

mixin LoadManagerMixin {
  AuthState authState = AuthState.loggedOut;

  void setLoading(State state) {
    state.setState(() {
      authState = AuthState.loading;
    });
  }

  void setLoggedIn(State state) {
    state.setState(() {
      authState = AuthState.loggedIn;
    });
  }

  void setLoggedOut(State state) {
    state.setState(() {
      authState = AuthState.loggedOut;
    });
  }

  Widget buildLoader(double size, Color color) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(color: color, size: size),
    );
  }
}

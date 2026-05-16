import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final supabase = Supabase.instance.client;

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
      log("${supabase.auth.currentUser}");
      log("${supabase.auth.currentUser?.id}");
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await supabase.auth.signUp(
        data: {'name': username},
        email: email,
        password: password,
      );
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<String> getUserName() async {
    final user = Supabase.instance.client.auth.currentUser;
    final name = user?.userMetadata?['name'];
    return name;
  }
}

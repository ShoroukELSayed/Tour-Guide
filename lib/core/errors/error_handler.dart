import 'dart:io';
import 'package:city_tales/core/errors/failures.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ErrorHandler {
  static Failure handle(dynamic e) {
    if (e is SocketException) {
      return const NetworkFailure();
    }
    if (e is PostgrestException) {
      return ServerFailure(e.message);
    }
     if (e is AuthException) {
      return ServerFailure(e.message);
    }

     if (e.toString().contains("HiveError")) {
      return const ServerFailure("Local database error");
    }

    return const UnknownFailure();
  }
}

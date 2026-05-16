abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super("Check your internet connection");
}

class LocationServiceFailure extends Failure {
  const LocationServiceFailure(super.message);
}

class LocationPermissionFailure extends Failure {
  final bool permanentlyDenied;

  const LocationPermissionFailure(
    super.message, {
    this.permanentlyDenied = false,
  });
}

class UnknownFailure extends Failure {
  const UnknownFailure() : super("Something went wrong");
}

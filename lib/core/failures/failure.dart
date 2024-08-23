class Failure {
  final String message;

  Failure({this.message = "Sorry, an unexpected error has occurred!"});

  @override
  String toString() => "Failure(message: $message)";
}

class ServerFailure extends Failure {
  ServerFailure({super.message = "Sorry, an unexpected Server error has occurred!"});

  @override
  String toString() => "ServerFailure(message: $message)";
}

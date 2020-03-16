import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;

  @override
  List<Object> get props => ['message'];
}

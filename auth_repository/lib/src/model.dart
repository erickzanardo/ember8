import 'package:equatable/equatable.dart';

/// {@template ember_8_user_model}
///
/// Model representing an Ember 8 user
///
/// {@endtemplate}
class Ember8User extends Equatable {

  /// {@macro ember_8_user_model}
  const Ember8User({required this.id, this.name});

  /// Id of the user
  final String id;
  /// Name of the user
  final String? name;

  @override
  List<Object?> get props => [id, name];
}

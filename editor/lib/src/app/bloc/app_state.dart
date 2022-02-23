part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState({
    this.user,
  });
  
  const AppState.initial() : this();

  final Ember8User? user;

  @override
  List<Object?> get props => [user];

  AppState copyWith({
    required Ember8User? user,
  }) {
    return AppState(
        user: user ?? this.user,
    );
  }
}

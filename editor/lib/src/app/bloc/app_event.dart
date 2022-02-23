part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

class Ember8UserLoaded extends AppEvent {

  const Ember8UserLoaded(this.user);

  final Ember8User user;

  @override
  List<Object?> get props => [user];
}

class GoogleSignInRequested extends AppEvent {
  const GoogleSignInRequested();

  @override
  List<Object?> get props => [];
}

class SignOutRequested extends AppEvent {
  const SignOutRequested();

  @override
  List<Object?> get props => [];
}

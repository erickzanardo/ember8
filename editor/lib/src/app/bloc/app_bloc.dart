import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const AppState.initial()) {
    on<Ember8UserLoaded>(_handleGameUserLoaded);
    on<GoogleSignInRequested>(_handleGoogleSignInRequested);
    on<SignOutRequested>(_handleSignOutRequested);

    authRepository.listenUserState((user) {
      if (user != null) {
        add(Ember8UserLoaded(user));
      }
    });
  }

  final AuthRepository _authRepository;

  void _handleGameUserLoaded(
    Ember8UserLoaded event,
    Emitter<AppState> emit,
  ) {
    emit(state.copyWith(user: event.user));
  }

  void _handleGoogleSignInRequested(
    GoogleSignInRequested event,
    Emitter<AppState> emit,
  ) {
    _authRepository.signInWithGoogle();
  }

  Future<void> _handleSignOutRequested(
    SignOutRequested event,
    Emitter<AppState> emit,
  ) async {
    await _authRepository.signOut();
    emit(const AppState.initial());
  }
}

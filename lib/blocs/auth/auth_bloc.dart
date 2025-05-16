import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService = AuthService();

  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final user = _authService.currentUser;
    if (user != null) {
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    emit(Authenticated(event.user));
  }

  Future<void> _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    await _authService.logout();
    emit(Unauthenticated());
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_checkup_food_app/features/auth/data/repositories/auth_repository.dart';

/// Provider for AuthRepository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

/// Provider for authentication state
final authStateProvider = StreamProvider<User?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
});

/// Provider for current user
final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.maybeWhen(
    data: (user) => user,
    orElse: () => null,
  );
});

/// Provider for authentication status
final authStatusProvider = Provider<AuthStatus>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.maybeWhen(
    data: (user) =>
        user != null ? AuthStatus.authenticated : AuthStatus.unauthenticated,
    loading: () => AuthStatus.loading,
    orElse: () => AuthStatus.unauthenticated,
  );
});

/// Enum for authentication status
enum AuthStatus {
  authenticated,
  unauthenticated,
  loading,
}

/// Provider for sign in functionality
final signInProvider =
    StateNotifierProvider<SignInNotifier, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignInNotifier(authRepository);
});

class SignInNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _authRepository;

  SignInNotifier(this._authRepository) : super(const AsyncValue.data(null));

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await _authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

/// Provider for sign up functionality
final signUpProvider =
    StateNotifierProvider<SignUpNotifier, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignUpNotifier(authRepository);
});

class SignUpNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _authRepository;

  SignUpNotifier(this._authRepository) : super(const AsyncValue.data(null));

  Future<void> signUp(String email, String password, String displayName) async {
    state = const AsyncValue.loading();
    try {
      await _authRepository.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name after account creation
      if (displayName.isNotEmpty) {
        await _authRepository.updateDisplayName(displayName);
      }

      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

/// Provider for sign out functionality
final signOutProvider =
    StateNotifierProvider<SignOutNotifier, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return SignOutNotifier(authRepository);
});

class SignOutNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _authRepository;

  SignOutNotifier(this._authRepository) : super(const AsyncValue.data(null));

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    try {
      await _authRepository.signOut();
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

/// Provider for password reset functionality
final passwordResetProvider =
    StateNotifierProvider<PasswordResetNotifier, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return PasswordResetNotifier(authRepository);
});

class PasswordResetNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _authRepository;

  PasswordResetNotifier(this._authRepository)
      : super(const AsyncValue.data(null));

  Future<void> sendPasswordResetEmail(String email) async {
    state = const AsyncValue.loading();
    try {
      await _authRepository.sendPasswordResetEmail(email);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

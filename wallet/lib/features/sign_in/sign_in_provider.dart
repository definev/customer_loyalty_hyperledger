import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet/features/sign_in/sign_in_state.dart';

final signInStateProvider = StateProvider<SignInState>((ref) {
  return SignInState.guest();
});

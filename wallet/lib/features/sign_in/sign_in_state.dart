/*
*	Copyright PKA.CPD . All Rights Reserved.
*	SPDX-License-Identifier: Apache-2.0
 */

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet/features/wallet/member.dart';

part 'sign_in_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  factory SignInState.guest() = _Guest;
  factory SignInState.signedIn(Member member) = _SignedIn;
}

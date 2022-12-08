import 'package:dio/dio.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wallet/config/gateway.dart';
import 'package:wallet/features/dashboard/repository/remote.dart';
import 'package:wallet/features/sign_in/sign_in_provider.dart';
import 'package:wallet/features/sign_in/sign_in_state.dart';

class SignInView extends HookConsumerWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountNumberTextController = useTextEditingController();
    final cardIdTextController = useTextEditingController();

    final navigator = Navigator.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng nhập'),
      ),
      body: PaddedColumn(
        padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
        children: [
          TextField(
            controller: accountNumberTextController,
            decoration: const InputDecoration(
              hintText: 'Account number',
            ),
          ),
          const Gap(15),
          TextField(
            controller: cardIdTextController,
            decoration: const InputDecoration(
              hintText: 'Card id',
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          try {
            showDialog(
              context: context,
              builder: (_) => const Center(child: CircularProgressIndicator()),
              barrierDismissible: false,
            );
            final data = await RestClient(Dio(), baseUrl: GATEWAY_URL).signIn({
              'accountNumber': accountNumberTextController.text,
              'cardId': cardIdTextController.text,
            });
            navigator.pop();

            ref.read(signInStateProvider.notifier).state = SignInState.signedIn(data);
          } on DioError catch (e) {
            navigator.pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.response.toString())),
            );
          }
        },
        label: const Text('Đăng nhập'),
      ),
    );
  }
}

/*
*	Copyright PKA.CPD . All Rights Reserved.
*	SPDX-License-Identifier: Apache-2.0
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icon.dart';
import 'package:wallet/config/gateway.dart';
import 'package:wallet/features/dashboard/repository/remote.dart';
import 'package:wallet/features/sign_in/sign_in_provider.dart';
import 'package:wallet/features/wallet/point_transaction.dart';
import 'package:wallet/resources/resources.dart';

final fetchTransactionsProvider = FutureProvider<List<PointTransaction>>((ref) async {
  final dio = RestClient(Dio(), baseUrl: GATEWAY_URL);
  final usePointsResponse = await dio.getUsePoints({
    'accountNumber': ref.read(
      signInStateProvider.select((value) => value.mapOrNull(signedIn: (value) => value)!.member.accountNumber),
    )
  });
  final earnPointsResponse = await dio.getEarnPoints({
    'accountNumber': ref.read(
      signInStateProvider.select((value) => value.mapOrNull(signedIn: (value) => value)!.member.accountNumber),
    )
  });

  return [...usePointsResponse, ...earnPointsResponse]..sort((a, b) => a.timestamp.compareTo(b.timestamp));
});

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final PointTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: transaction.type == 'earn' ? const Color(0xFFA6FDB9) : const Color(0xFFffd2dd),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Text(
                                transaction.partner,
                                style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                LineIcon.clockAlt(
                                  color: Colors.black.withOpacity(0.45),
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  DateFormat('HH:mm || yyyy-MM-dd', 'vi_VN').format(transaction.timestamp),
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                    color: Colors.black.withOpacity(0.45),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 90,
                        height: 72,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: transaction.type == 'earn' ? const Color(0xFFCBFFD6) : const Color(0xFFfec7d4),
                          ),
                          child: Center(
                            child: Text(
                              '🛍️',
                              style: theme.textTheme.headline2!.copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Số coin ${transaction.type == 'use' ? 'sử dụng' : 'nhận được'}',
                              style: theme.textTheme.headline6!.copyWith(fontWeight: FontWeight.w500),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 22,
                                  child: Image.asset(WalletImages.dollarFrontColor),
                                ),
                                const Gap(3),
                                Text(
                                  transaction.points.toString(),
                                  style: theme.textTheme.subtitle1!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      LineIcon.info(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*
*	Copyright PKA.CPD . All Rights Reserved.
*	SPDX-License-Identifier: Apache-2.0
 */

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wallet/config/gateway.dart';
import 'package:wallet/features/wallet/member.dart';
import 'package:wallet/features/wallet/point_transaction.dart';

part 'remote.g.dart';

@RestApi(baseUrl: GATEWAY_URL)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/api/client/usePoints")
  Future<List<PointTransaction>> getUsePoints(@Body() Map<String, dynamic> accountNumber);

  @POST("/api/client/earnPoints")
  Future<List<PointTransaction>> getEarnPoints(@Body() Map<String, dynamic> accountNumber);

  @POST("/api/client/memberData")
  Future<Member> signIn(@Body() Map<String, dynamic> body);
}

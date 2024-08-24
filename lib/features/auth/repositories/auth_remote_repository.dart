import 'dart:convert';

import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/failures/failure.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class AuthRemoteRepository {
  Future<Either<ServerFailure, UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ServerConstant.serverUrl}/auth/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          <String, String>{
            'name': name,
            'email': email,
            'password': password,
          },
        ),
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 201) {
        return Left(ServerFailure(message: resBodyMap['message']));
      }

      return Right(UserModel.fromJson(resBodyMap));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<ServerFailure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${ServerConstant.serverUrl}/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          <String, String>{
            'email': email,
            'password': password,
          },
        ),
      );
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200) {
        return Left(ServerFailure(message: resBodyMap['detail']));
      }

      return Right(UserModel.fromJson(resBodyMap));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

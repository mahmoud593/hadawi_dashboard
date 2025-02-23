import 'package:dartz/dartz.dart';
import 'package:hadawi_dathboard/features/auth/domain/user_entities/user_entity.dart';
import 'package:hadawi_dathboard/utiles/error_handling/faliure/faliure.dart';

abstract class UserRepo {
  /// 🔹 تسجيل الدخول
  Future<Either<Faliure, void>> login({
    required String email,
    required String password,
  });

  /// 🔹 حفظ بيانات المستخدم
  Future<Either<Faliure, void>> saveUserData({
    required String email,
    required String name, // ✅ تغيير `password` إلى `name`
    required String uId,
  });

  /// 🔹 تسجيل الخروج
  Future<Either<Faliure, void>> logout();

  /// 🔹 جلب بيانات المستخدم
  Future<Either<Faliure, UserEntity>> getUserData({required String uId});
}

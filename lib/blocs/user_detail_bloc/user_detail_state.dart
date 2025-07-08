import 'package:equatable/equatable.dart';
import 'package:userlist_bloc_app_api/models/user.dart';

abstract class UserDetailState extends Equatable {
  const UserDetailState();

  @override
  List<Object> get props => [];
}

// สถานะเริ่มต้นของ BLoC
class UserDetailInitial extends UserDetailState {
  const UserDetailInitial();
}

// สถานะเมื่อกำลังโหลดข้อมูลผู้ใช้
class UserDetailLoading extends UserDetailState {
  const UserDetailLoading();
}

// สถานะเมื่อโหลดข้อมูลผู้ใช้สำเร็จ
class UserDetailLoaded extends UserDetailState {
  final User user; // ข้อมูลผู้ใช้ที่โหลดมา

  const UserDetailLoaded({required this.user});

  @override
  List<Object> get props => [user];  
}

// สถานะเมื่อโหลดข้อมูลผู้ใช้ผิดพลาด
class UserDetailError extends UserDetailState{
  final String message;

  const UserDetailError({required this.message});

  @override
  List<Object> get props => [message];
}

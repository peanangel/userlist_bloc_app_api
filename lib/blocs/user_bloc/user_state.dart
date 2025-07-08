// lib/blocs/user_bloc/user_state.dart
import 'package:equatable/equatable.dart';
import '../../models/user.dart'; // Import User model

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

// สถานะเริ่มต้นของ BLoC
class UserInitial extends UserState {}

// สถานะเมื่อกำลังโหลดข้อมูล
class UserLoading extends UserState {}

// สถานะเมื่อโหลดข้อมูลสำเร็จ
class UserLoaded extends UserState {
  final List<User> users;

  const UserLoaded({required this.users});

  @override
  List<Object?> get props => [users];
}

// สถานะเมื่อโหลดข้อมูลผิดพลาด
class UserError extends UserState {
  final String message;

  const UserError({required this.message});

  @override
  List<Object?> get props => [message];
}
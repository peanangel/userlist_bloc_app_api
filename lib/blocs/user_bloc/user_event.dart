// lib/blocs/user_bloc/user_event.dart
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

// Event ที่จะถูกส่งเมื่อต้องการโหลดข้อมูลผู้ใช้
class FetchUsers extends UserEvent {}
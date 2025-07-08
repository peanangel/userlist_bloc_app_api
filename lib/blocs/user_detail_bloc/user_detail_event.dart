import 'package:equatable/equatable.dart';

abstract class UserDetailEvent extends Equatable{
  const UserDetailEvent();

  @override
  List<Object> get props => [];
}

class SelectUser extends UserDetailEvent{
  final int userId;

  const SelectUser({required this.userId});

  @override
  List<Object> get props => [userId];
}
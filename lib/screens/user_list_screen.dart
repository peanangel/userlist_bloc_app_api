// lib/screens/user_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user_bloc/user_bloc.dart';
import '../blocs/user_bloc/user_event.dart';
import '../blocs/user_bloc/user_state.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List with BLoC')),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInitial) {
            // สถานะเริ่มต้น: แสดงปุ่มโหลด
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  // เมื่อกดปุ่ม ให้ส่ง Event FetchUsers ไปยัง UserBloc
                  context.read<UserBloc>().add(FetchUsers());
                },
                child: const Text('Load Users'),
              ),
            );
          } else if (state is UserLoading) {
            // สถานะกำลังโหลด: แสดงแถบความคืบหน้า
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            // สถานะโหลดสำเร็จ: แสดงรายการผู้ใช้
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    onTap: () {
                      // เมื่อกดที่รายการผู้ใช้ ให้ไปยังหน้ารายละเอียดผู้ใช้
                      Navigator.pushNamed(
                        context,
                        '/user-detail',
                        arguments: user.id,
                      );
                    },
                    leading: CircleAvatar(child: Text('${user.id}')),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                  ),
                );
              },
            );
          } else if (state is UserError) {
            // สถานะเกิดข้อผิดพลาด: แสดงข้อความผิดพลาด
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  ElevatedButton(
                    onPressed: () {
                      // เมื่อกดปุ่ม ลองโหลดใหม่
                      context.read<UserBloc>().add(FetchUsers());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink(); // กรณีที่ไม่ตรงกับสถานะใดๆ
        },
      ),
    );
  }
}

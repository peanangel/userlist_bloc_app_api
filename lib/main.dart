// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userlist_bloc_app_api/blocs/user_bloc/user_bloc.dart';
import 'package:userlist_bloc_app_api/repositories/user_repository.dart';
import 'package:userlist_bloc_app_api/screens/user_detail_screen.dart';
import 'package:userlist_bloc_app_api/screens/user_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      // MultiRepositoryProvider ใช้สำหรับ provide Repositories
      providers: [
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
      ],
      child: MultiBlocProvider(
        // MultiBlocProvider ใช้สำหรับ provide BLoCs
        providers: [
          BlocProvider<UserBloc>(
            // สร้าง UserBloc โดยส่ง UserRepository ที่ provide ไว้ก่อนหน้านี้
            create: (context) => UserBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context),
            ),
          ),

        ],
        child: MaterialApp(
          title: 'BLoC API Example',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const UserListScreen(), // กำหนดหน้าจอเริ่มต้น
          routes: {
            UserDetailScreen.routeName: (context) => const UserDetailScreen(),
          },
        ),
      ),
    );
  }
}

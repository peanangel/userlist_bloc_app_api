import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userlist_bloc_app_api/blocs/user_bloc/user_bloc.dart';
import 'package:userlist_bloc_app_api/repositories/user_detail_repository.dart';
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
        RepositoryProvider<UserDetailRepository>(
          create: (context) => UserDetailRepository(),
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
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              onSurface: Colors.black87, // สีข้อความบนพื้นผิว
              onPrimary: Colors.white, // สีข้อความบนสีหลัก
              onSecondary: Colors.white, // สีข้อความบนสีรอง
            ),
            textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black87,
              displayColor: Colors.black87,
            ),
          ),

          home: const UserListScreen(),
          routes: {
            UserDetailScreen.routeName: (context) {
              final int userId =
                  ModalRoute.of(context)!.settings.arguments as int;
              return UserDetailScreen(key: Key('user_detail_screen_$userId'));
            },
          },
        ),
      ),
    );
  }
}

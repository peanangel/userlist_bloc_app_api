import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userlist_bloc_app_api/blocs/user_detail_bloc/user_detail_bloc.dart';
import 'package:userlist_bloc_app_api/blocs/user_detail_bloc/user_detail_state.dart';
import 'package:userlist_bloc_app_api/repositories/user_detail_repository.dart';

class UserDetailScreen extends StatelessWidget {
  static const routeName = '/user-detail';

  const UserDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int userId = ModalRoute.of(context)?.settings.arguments as int;
    return BlocProvider<UserDetailBloc>(
      create: (context) => UserDetailBloc(
        userDetailRepository: RepositoryProvider.of<UserDetailRepository>(
          context,
        ),
        userId: userId,
      ),
      child: Builder(builder: (context){
        return Scaffold(
          appBar: AppBar(title: const Text('User Detail')),
          body: BlocBuilder<UserDetailBloc, UserDetailState>(
            builder: (context, state) {
              if (state is UserDetailInitial) {
                return const Center(child: Text('Select a user to view details'));
              } else if (state is UserDetailLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UserDetailLoaded) {
                final user = state.user;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${user.id}', ),
                      Text('Name: ${user.name}', ),
                      Text('Email: ${user.email}', ),
                    ],
                  ),
                );
              } else if (state is UserDetailError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox.shrink();
            },
          ),
        );    
      },),
    );
  }
}

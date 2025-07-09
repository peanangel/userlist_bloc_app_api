import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userlist_bloc_app_api/blocs/user_detail_bloc/user_detail_bloc.dart';
import 'package:userlist_bloc_app_api/blocs/user_detail_bloc/user_detail_event.dart';
import 'package:userlist_bloc_app_api/blocs/user_detail_bloc/user_detail_state.dart';
import 'package:userlist_bloc_app_api/models/user.dart';
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
      ),
      child: Builder(
        builder: (context) {
          context.read<UserDetailBloc>().add(SelectUser(userId: userId));
          return Scaffold(
            appBar: AppBar(title: const Text('User Detail')),
            body: BlocBuilder<UserDetailBloc, UserDetailState>(
              builder: (context, state) {
                if (state is UserDetailInitial) {
                  return const Center(
                    child: Text('Select a user to view details'),
                  );
                } else if (state is UserDetailLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is UserDetailLoaded) {
                  final user = state.user;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.black12,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                user.username,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              Text(user.company.catchPhrase),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 16),
                            _buildDisplayData(Icons.person, 'Name', user.name),
                            const SizedBox(height: 8),
                            _buildDisplayData(Icons.email, 'Email', user.email),
                            const SizedBox(height: 8),
                     
                              _buildDisplayData(Icons.phone, 'Phone', user.phone),
                            const SizedBox(height: 8),
                            Text('Website: ${user.website}'),
                             _buildDisplayData(Icons.abc, 'Website', user.website),
                            const SizedBox(height: 8),
                            Text(
                              'Address: ${user.address.street}, ${user.address.suite}, ${user.address.city}, ${user.address.zipcode}',
                            ),
                          ],
                        ),
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
        },
      ),
    );
  }

  Widget _buildDisplayData(icon, label, text) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 30),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$label:', style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 4),
                  Text('$text', style: const TextStyle(fontSize: 15)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

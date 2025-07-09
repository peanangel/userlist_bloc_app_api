import 'package:bloc/bloc.dart';
import 'package:userlist_bloc_app_api/blocs/user_detail_bloc/user_detail_event.dart';
import 'package:userlist_bloc_app_api/blocs/user_detail_bloc/user_detail_state.dart';
import 'package:userlist_bloc_app_api/repositories/user_detail_repository.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final UserDetailRepository userDetailRepository;

  UserDetailBloc({
    required UserDetailRepository userDetailRepository,

  }) : userDetailRepository = userDetailRepository,
       super(const UserDetailInitial()) {
    on<SelectUser>((event, emit) async {
      emit(UserDetailLoading());
      try {
        final user = await userDetailRepository.fetchUserDetail(event.userId);
        emit(UserDetailLoaded(user: user));
      } catch (e) {
        emit(UserDetailError(message: e.toString()));
      }
    });
  }
}

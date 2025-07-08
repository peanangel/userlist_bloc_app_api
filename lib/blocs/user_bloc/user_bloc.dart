// lib/blocs/user_bloc/user_bloc.dart (ปรับปรุง)
import 'package:bloc/bloc.dart';
import 'package:userlist_bloc_app_api/common/exceptoions/api_exception.dart';
import '../../repositories/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<FetchUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final users = await userRepository.fetchUsers();
        emit(UserLoaded(users: users));
      } on ApiException catch (e) { // จับ Custom Exception ของเรา
        emit(UserError(message: e.message)); // ส่งแค่ข้อความที่เรากำหนด
      } catch (e) { // จับ Exception อื่นๆ ที่ไม่ได้ระบุ
        emit(UserError(message: 'An unknown error occurred: ${e.toString()}'));
      }
    });
  }
}
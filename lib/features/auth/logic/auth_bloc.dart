import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/auth_login/login_response.dart';
import '../../../core/storage/share_pref/shared_preferences_manager.dart';
import '../data/auth_repository.dart';
import '../data/service_locator.dart';

// ----------- Bloc state for login
abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState { final LoginResponse response; AuthSuccess(this.response);}
class AuthError extends AuthState { final String message; AuthError(this.message); }
// ----------- Bloc event for login
abstract class AuthEvent {}
class LoginRequested extends AuthEvent { final String email, password, ipAddress, deviceDetail ; LoginRequested(this.email, this.password, this.ipAddress, this.deviceDetail); }

// --------- Bloc for login page
class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthRepository _authRepository = getIt<AuthRepository>();

  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_loginRequested);
  }

  Future<void> _loginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      debugPrint("the bloc of login");
      final response = await _authRepository.doctorLogin(event.email, event.password, event.ipAddress, event.deviceDetail);
      // final response = await _authRepository.doctorLogin("mahesh", "ff45bda59b7dcea6f916800e0734b550", "27.4.39.204", "mac chrome");
      debugPrint("the bloc of login ${response.doctors?.login?.info?.token} ${event.ipAddress}");
      if (response.doctors?.login?.info?.token != null) {
        await SharedPref().storeAccessToken(response.doctors?.login?.info?.token, response.doctors?.login?.doctor?.doctorId, response.doctors?.login?.doctor?.doctorEmail,);
        // await SharedPref().storeRefreshToken(response.refreshToken ?? "");
        emit(AuthSuccess(response));
      } else {
        emit(AuthError(response.doctors?.login?.authStatus.toString() ?? "Login failed"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

}
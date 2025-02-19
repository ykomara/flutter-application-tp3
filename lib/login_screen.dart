import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:go_router/go_router.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            debugPrint("Connexion réussie, ouverture de la liste des restaurants...");
            Future.microtask(() {
              context.go('/restaurants'); 
            });
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Stack(
              children: [
                FlutterLogin(
                  title: 'LOGIN',
                  logo: const AssetImage('assets/images/image.png'),
                  userType: LoginUserType.name,
                  userValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Le nom d'utilisateur est requis";
                    }
                    return null;
                  },
                  onLogin: (data) async {
                    debugPrint("Tentative de connexion avec ${data.name}");

                    context.read<LoginBloc>().add(
                      LoginButtonPressed(username: data.name, password: data.password),
                    );

                    await Future.delayed(const Duration(seconds: 2));

                    final state = context.read<LoginBloc>().state;
                    if (state is LoginFailure) {
                      return state.error;
                    }
                    return null;
                  },
                  onSignup: (_) => Future.delayed(loginTime, () => null),
                  onRecoverPassword: (name) => Future.delayed(loginTime, () {
                    return 'Utilisateur non trouvé';
                  }),
                ),
                if (state is LoginLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

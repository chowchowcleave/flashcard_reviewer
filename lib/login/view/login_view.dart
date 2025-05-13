import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/login_cubit.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TextStyle hintStyle = TextStyle(
      color: Colors.grey.shade400,
    );

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        String userID = context.read<LoginCubit>().userLoggedIn();
        if (state is LoginLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is LoginSuccess) {
          _emailController.clear();
          _passwordController.clear();
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text('You are logged in as $userID.')),
              ElevatedButton(
                onPressed: () {
                  context.read<LoginCubit>().logout();
                },
                child: Text('Logout'),
              ),
            ],
          );
        } else if (state is LoginFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Login failed: ${state.error}',
                  style: TextStyle(color: Colors.red),
                ),
                _buildLoginForm(context, hintStyle),
              ],
            ),
          );
        } else {
          return _buildLoginForm(context, hintStyle);
        }
      },
    );
  }

  Widget _buildLoginForm(BuildContext context, TextStyle hintStyle) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(64.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 24),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: hintStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: hintStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty) {
                  context
                      .read<LoginCubit>()
                      .login(_emailController.text, _passwordController.text);
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Login', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

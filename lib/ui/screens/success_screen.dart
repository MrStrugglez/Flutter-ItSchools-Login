import 'package:flutter/material.dart';
import 'package:flutter_itschools_login/bloc/interfaces/auth_bloc.dart';
import 'package:flutter_itschools_login/models/ui/auth_user.dart';
import 'package:flutter_itschools_login/ui/widgets/logout_button.dart';
import 'package:flutter_itschools_login/ui/widgets/result_banner_widget.dart';
import 'package:flutter_itschools_login/utils/injection_container.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  final bannerPath = "assets/images/success_banner.png";

  final message = "Welcome Back!";

  final AuthBloc _authBloc = injector<AuthBloc>();

  @override
  void initState() {
    super.initState();
    _authBloc.fetchCurrentAuthUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ResultBannerWidget(
                bannerPath: bannerPath,
                icon: Icons.check_circle_outline,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 100,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      message,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  StreamBuilder<AuthUser?>(
                    stream: _authBloc.userAuthStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        AuthUser authUser = snapshot.data!;
                        return _buildUserDetails(authUser);
                      } else {
                        return _buildLoader();
                      }
                    },
                  ),
                  const SizedBox(height: 60),
                  LogoutButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.white,
        size: 35,
      ),
    );
  }

  Widget _buildUserDetails(AuthUser authUser) {
    return Center(
      child: Text(
        "Email: ${authUser.username} \n UserId: ${authUser.hash}",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
      ),
    );
  }

  @override
  void dispose() {
    _authBloc.dispose();
    super.dispose();
  }
}

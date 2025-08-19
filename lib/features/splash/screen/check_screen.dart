import 'package:flutter/material.dart';
import 'package:job_app/cores/data/repositories/authentication/authentication_repository.dart';

class CheckScreen extends StatelessWidget {
  const CheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      AuthenticationRepository.instance.screenRedirect();
    });

    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

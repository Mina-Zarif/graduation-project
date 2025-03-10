import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/loading/view/loading_dialog.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/helpers/custom_toast.dart';
import '../manager/signup_bloc/signup_bloc.dart';
import '../manager/signup_bloc/signup_state.dart';
import '../widgets/complete_profile.dart';
import '../widgets/signup_body.dart';
import '../widgets/verify_email.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late final PageController _pageController;
  int index = 0;

  @override
  void initState() {
    super.initState();
    index = 0;
    _pageController = PageController();
  }

  @override
  void dispose() {
    index = 0;
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupLoading) {
            LoadingDialog.showLoadingDialog(context);
          } else {
            LoadingDialog.hideLoadingDialog();
          }
          if (state is SignupFailure) {
            CustomToast(context).showErrorToast(message: state.error.error);
          }
        },
        builder: (context, state) {
          return PopScope(
            canPop: index > 0,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.linear,
                );
              }
            },
            child: PageView(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  index = value;
                });
              },
              physics: const NeverScrollableScrollPhysics(),
              children:  [
                SignupBody(nextPage: _nextPage),
                VerifyEmailView(),
                CompleteProfileView(),
              ],
            ),
          );
        },
      ),
    );
  }
}

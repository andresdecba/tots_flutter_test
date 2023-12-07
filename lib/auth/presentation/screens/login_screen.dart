import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tots_flutter_test/auth/presentation/widgets/alert_dialog.dart';
import 'package:tots_flutter_test/core/routes/routes.dart';
import 'package:tots_flutter_test/core/styles/base_screen.dart';
import 'package:tots_flutter_test/core/styles/styles.dart';

const _loginEmail = 'test@coda.com';
const _loginPassWord = '123Qwerty';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailCtrlr;
  late TextEditingController passwordCtrlr;
  late GlobalKey<FormState> formStateKey;

  @override
  void initState() {
    super.initState();
    emailCtrlr = TextEditingController();
    passwordCtrlr = TextEditingController();
    formStateKey = GlobalKey<FormState>();
  }

  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final textStyle = Theme.of(context).textTheme;

    return BaseScreen(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: formStateKey,
          child: SizedBox(
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // logo
                SizedBox(
                  height: 100,
                  child: Image.asset('assets/minimal_logo.png'),
                ),
                const SizedBox(height: 10),

                // title
                Text(
                  'LOGIN',
                  style: textStyle.bodyMedium!.copyWith(
                    color: Colors.grey.shade700,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 50),

                // email
                TextFormField(
                  controller: emailCtrlr,
                  keyboardType: TextInputType.emailAddress,
                  decoration: AppStyles.inputDecoration(
                    context: context,
                    labelText: 'Email',
                    hintText: 'email@email.com',
                    sufixIcon: Icons.clear_rounded,
                    onTap: () => emailCtrlr.clear(),
                  ),
                  validator: (value) {
                    if (value != null && !_validateEmail(value)) {
                      return 'Ingrese un email válido';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),

                // password
                TextFormField(
                  obscureText: showPassword,
                  controller: passwordCtrlr,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: AppStyles.inputDecoration(
                    context: context,
                    labelText: 'Password',
                    hintText: 'Ingrese su password',
                    sufixIcon: showPassword == true ? Icons.visibility_rounded : Icons.visibility_off_outlined,
                    onTap: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value != null && value.length < 3) {
                      return 'Ingrese un valor';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),

                // login button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _tryLogin(),
                    child: const Text('LOGIN'),
                  ),
                ),
                const SizedBox(height: 20),

                // ayuda
                Text(
                  '[  user: $_loginEmail / pass: $_loginPassWord  ]',
                  style: textStyle.bodyMedium!.copyWith(
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 40),

                // options buttons
                TextButton(
                  onPressed: () {},
                  child: const Text('Forgot password.'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('create account.'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _tryLogin() {
    if (formStateKey.currentState!.validate()) {
      if (emailCtrlr.text == _loginEmail && passwordCtrlr.text == _loginPassWord) {
        context.goNamed(AppRoutes.homeScreen);
      } else {
        loginErrorDialog(context);
      }
    }
  }

  bool _validateEmail(String value) {
    RegExp regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return (!regex.hasMatch(value)) ? false : true;
  }
}

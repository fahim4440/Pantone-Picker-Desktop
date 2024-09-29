import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantone_book/bloc/signin/signin_bloc.dart';
import 'package:pantone_book/screens/homepage.dart';
import 'signup_page.dart';
import 'package:lottie/lottie.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign In",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 3.0,
        backgroundColor: const Color.fromARGB(255, 225, 237, 240),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Lottie.asset("assets/logo.json", width: MediaQuery.of(context).size.width - 200.0, height: 200,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const EmailInput(),
                  const SizedBox(
                    height: 30,
                  ),
                  const PasswordInput(),
                  const SizedBox(
                    height: 40.0,
                  ),
                  const SigninButton(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Not have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupPage()));
                        },
                        child: const Text("Signup Now!"),
                      )
                    ],
                  ),
                  _ErrorMessage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninBloc, SigninState>(
      builder: (context, state) {
        return TextField(
          onChanged: (email) =>
              context.read<SigninBloc>().add(SigninEmailChanged(email: email)),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            errorText: !state.isValidEmail && state.email.isNotEmpty
                ? 'Invalid Email'
                : null,
            prefixIcon: const Icon(Icons.email_outlined),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 6.0),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ),
            ),
            focusColor: Colors.blueGrey,
            labelText: "Email",
            labelStyle: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}

class PasswordInput extends StatefulWidget {
  const PasswordInput({super.key});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _showPassword = false;

  _toggleObscured() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninBloc, SigninState>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (password) => context
              .read<SigninBloc>()
              .add(SigninPasswordChanged(password: password)),
          obscureText: !_showPassword,
          decoration: InputDecoration(
            errorText: !state.isValidPassword && state.password.isNotEmpty
                ? 'Password is not valid'
                : null,
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
              child: GestureDetector(
                onTap: _toggleObscured,
                child: Icon(
                  _showPassword
                      ? Icons.visibility_rounded
                      : Icons.visibility_off,
                  size: 24,
                ),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 6.0),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
            ),
            focusColor: Colors.blueGrey,
            labelText: "Password",
            labelStyle: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}

class SigninButton extends StatelessWidget {
  const SigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SigninBloc, SigninState>(
      listener: (context, state) {
        if (state.isSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const Homepage()),
              (Route<dynamic> route) => false,
          );
        }
      },
      child: BlocBuilder<SigninBloc, SigninState>(
        builder: (context, state) {
          return state.isSubmitting ? const Center(child: CircularProgressIndicator(),) :
          MaterialButton(
            onPressed: () async {
              context.read<SigninBloc>().add(SigninSubmitted());
            },
            color: Colors.blueGrey,
            child: const Text(
              "Sign In",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninBloc, SigninState>(
      builder: (context, state) {
        return state.isFailure
            ? Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(state.errorMessage,
                    style: const TextStyle(color: Colors.red)),
              )
            : Container();
      },
    );
  }
}

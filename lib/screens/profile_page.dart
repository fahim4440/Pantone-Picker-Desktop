import 'package:flutter/material.dart';
import 'package:pantone_book/screens/signin_page.dart';
import '../widgets/profile_view_text.dart';
import '../bloc/profile/profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
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
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfilePageEnterState) {
                  return Column(
                    children: [
                      const Center(
                        child: Icon(Icons.account_circle_rounded, size: 200.0,
                          color: Colors.blueGrey,),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0),),
                          color: Color.fromARGB(255, 225, 237, 240),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 200.0,
                        child: Column(
                          children: [
                            const SizedBox(height: 40.0,),
                            ProfileViewText(context, 'Account Details', FontWeight.bold, 20.0),
                            ProfileViewText(context, 'Name: ${state.user.name}', FontWeight.w600, 15.0),
                            ProfileViewText(context, 'Email: ${state.user.email}', FontWeight.w600, 15.0),
                            const SizedBox(height: 40.0,),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return const Center(child: CircularProgressIndicator(),);
              },
            ),
            Container(
              color: const Color.fromARGB(255, 225, 237, 240),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  BlocListener<ProfileBloc, ProfileState>(
                    listener: (context, state) {
                      print(state);
                      print(state.isSuccess);
                      if (state.isSuccess) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const SigninPage()),
                              (Route<dynamic> route) => false,
                        );
                      }
                    },
                    child: BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                        return state.isSubmitting ? const Center(child: CircularProgressIndicator(),) :
                        MaterialButton(
                          onPressed: () {
                            context.read<ProfileBloc>().add(ProfileLoggedOutEvent());
                          },
                          color: Colors.white,
                          child: const Text(
                            "Log Out",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      return state.isFailure ?
                      Padding(padding: const EdgeInsets.only(top: 8.0),
                        child: Text(state.errorMessage,
                            style: const TextStyle(color: Colors.red)),
                      ) : Container();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



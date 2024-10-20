import 'package:authentication/screens/signup_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/auth_service_email_password_google.dart';
import 'signup_page.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.yellowAccent, // Yellow at the top
            Colors.orangeAccent, // Orange at the bottom
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Make the Scaffold background transparent
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: _signup(context),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 100,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Signup()),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              decoration: const BoxDecoration(
                  color: Color(0xffF7F7F9), shape: BoxShape.circle),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Hello Again',
                    style: GoogleFonts.raleway(
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 32)),
                  ),
                ),
                const SizedBox(height: 80),
                _emailAddress(),
                const SizedBox(height: 20),
                _password(),
                const SizedBox(height: 50),
                _signin(context),
                const SizedBox(height: 20),
                _googleSignInButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailAddress() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email Address',
          style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 16)),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
              filled: true,
              hintText: 'ABC@gmail.com',
              hintStyle: const TextStyle(
                  color: Color(0xff6A6A6A),
                  fontWeight: FontWeight.normal,
                  fontSize: 14),
              fillColor: const Color(0xffF7F7F9),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(14))),
        )
      ],
    );
  }

  Widget _password() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 16)),
        ),
        const SizedBox(height: 16),
        TextField(
          obscureText: true,
          controller: _passwordController,
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffF7F7F9),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(14))),
        )
      ],
    );
  }

  Widget _signin(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff0D6EFD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize: const Size(double.infinity, 60),
        elevation: 0,
      ),
      onPressed: () async {
        await AuthService().signin(
            email: _emailController.text,
            password: _passwordController.text,
            context: context);
      },
      child: const Text("Sign In", style: TextStyle(color: Colors.white),),
    );
  }

  Widget _signup(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            const TextSpan(
              text: "New User? ",
              style: TextStyle(
                  color: Color(0xff6A6A6A),
                  fontWeight: FontWeight.normal,
                  fontSize: 16),
            ),
            TextSpan(
                text: "Create Account",
                style: const TextStyle(
                    color: Color(0xff1A1D1E),
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signup()),
                    );
                  }),
          ])),
    );
  }

  Widget _googleSignInButton(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Colors.grey),
        ),
        minimumSize: const Size(double.infinity, 60),
        elevation: 0,
      ),
      icon: Image.asset(
        'assets/images/google_logo.png', // Ensure you have a Google logo in your assets
        height: 24,
        width: 24,
      ),
      label: const Text(
        "Sign In with Google",
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () async {
        await AuthService().signInWithGoogle(context);
      },
    );
  }
}

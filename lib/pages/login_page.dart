import 'package:flutter/material.dart';
import 'package:absensi/constants/style_constant.dart';
import 'package:absensi/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void redirectToHomePage() {
    Navigator.pushReplacementNamed(context, MyRoute.main.name);
  }

  void _login() {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    // Add your authentication logic here
    final Map<String, String> data = {'email': email, 'password': password};

    print(data);
    redirectToHomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome Back",
                style: primaryTextStyle.copyWith(fontSize: 30, fontWeight: bold),
              ),
              SizedBox(height: 11),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                style: secondaryTextStyle.copyWith(fontSize: 12, fontWeight: bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 64),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Email", style: labelTextStyle.copyWith(fontSize: 12, fontWeight: bold)),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(153, 171, 198, 0.18),
                          spreadRadius: 2,
                          blurRadius: 62,
                          offset: Offset(0, 4), // arah bayangan: x, y
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "example@gmail.com",
                        hintStyle: secondaryTextStyle.copyWith(fontSize: 12),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Password", style: labelTextStyle.copyWith(fontSize: 12, fontWeight: bold)),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(153, 171, 198, 0.18),
                          spreadRadius: 2,
                          blurRadius: 62,
                          offset: Offset(0, 4), // arah bayangan: x, y
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText; // toggle status
                            });
                          },
                          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: checkboxInputColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      SizedBox(width: 15),
                      Text("Remember me", style: greyTextStyle.copyWith(fontSize: 12)),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      print("dorgot password");
                    },
                    child: Text(
                      "Forgot password ?",
                      style: primaryTextStyle.copyWith(fontSize: 12, fontWeight: bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: primaryButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6), // Ubah angka ini sesuai keinginan
                    ),
                  ),
                  onPressed: _login,
                  child: Text("LOGIN", style: whiteTextStyle.copyWith(fontWeight: bold)),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 19),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: secondaryButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6), // Ubah angka ini sesuai keinginan
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        "https://img.icons8.com/color/512/google-logo.png",
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(width: 12),
                      Text(
                        "SIGN IN WITH GOOGLE",
                        style: primaryTextStyle.copyWith(fontWeight: bold),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You don't have an account yet?  ",
                    style: secondaryTextStyle.copyWith(fontSize: 12),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Aksi saat link diklik
                      print("Sign up diklik");
                      // Navigator.push(...); // contoh navigasi
                    },
                    child: Text("Sign up", style: linkTextStyle.copyWith(fontSize: 12)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

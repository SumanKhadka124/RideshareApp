import 'package:bhatbhate/firebase/signupf.dart';
import 'package:bhatbhate/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  late Animation<double> _loginButtonAnimation;
  late Animation<double> _signupButtonAnimation;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _loginButtonAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    _signupButtonAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.75, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color.fromARGB(255, 210, 233, 196),
        body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => Transform(
            transform: Matrix4.translationValues(
                _animation.value * MediaQuery.of(context).size.width, 0, 0),
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Column(
                  children: [
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        Text(
                          "Login to your account",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Image.asset('assets/logo.png'),
                        Column(
                          children: [
                            if (!_isLoading)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: _usernameController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 250, 249, 249),
                                    hintText: "Enter your username",
                                    labelText: "Username",
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Column(
                          children: [
                            if (!_isLoading)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 250, 249, 249),
                                    hintText: "Enter password here",
                                    labelText: "Password",
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        AnimatedOpacity(
                          opacity: _loginButtonAnimation.value,
                          duration: Duration(milliseconds: 500),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              if (!_isLoading)
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    onPrimary: Colors.white,
                                    shadowColor: Colors.greenAccent,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                    minimumSize: Size(200, 40),
                                    padding: EdgeInsets.all(10),
                                  ),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                  onPressed: _login,
                                ),
                              if (_isLoading)
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator(),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          child: Text(
                            'Do not have account signup. ',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: _signupButtonAnimation.value,
                          duration: Duration(milliseconds: 500),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 238, 50, 113),
                              onPrimary: Colors.white,
                              shadowColor: Colors.greenAccent,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                              minimumSize: Size(120, 30),
                              padding: EdgeInsets.all(10),
                            ),
                            child: Text(
                              'Signup',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => SignupPage())),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  void _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    // Check if both username and password fields are empty
    if (username.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Center(
            child: Text('Empty Fields'),
          ),
          backgroundColor: Color.fromARGB(255, 210, 233, 196),
          titlePadding: EdgeInsets.all(4),
          content: Text('Username and password fields are empty.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return; // Stop the login process
    }

    // Set loading state to true
    setState(() {
      _isLoading = true;
    });

    try {
      // Use Firebase authentication to sign in with email and password
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username,
        password: password,
      );

      // Check if the authentication was successful
      if (userCredential.user != null) {
        // Credentials are valid, navigate to the homepage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Show a pop-up for incorrect credentials
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Center(
              child: Text('Incorrect credentials'),
            ),
            backgroundColor: Color.fromARGB(255, 210, 233, 196),
            titlePadding: EdgeInsets.all(4),
            content: Text('Please enter correct username and password.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Show a pop-up for any errors that occurred during authentication
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Center(
            child: Text('Authentication Error'),
          ),
          backgroundColor: Color.fromARGB(255, 210, 233, 196),
          titlePadding: EdgeInsets.all(4),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }

    // Set loading state to false
    setState(() {
      _isLoading = false;
    });
  }
}

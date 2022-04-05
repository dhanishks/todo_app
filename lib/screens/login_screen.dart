import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/screens/home_screen.dart';
import 'package:todo_application/screens/registration_screen.dart';
import 'package:todo_application/service/service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  static Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    }on FirebaseAuthException catch(e){
      if(e.code == "user-not-found"){
        print("No user");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    child: Image(image: AssetImage('assets/images/LOgo.png'),),
                  ),
                ),
                Center(
                  child: Text(
                    'Todo App',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Login Into Todo',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 44.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(
                  height: 44.0,
                ),

                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "User Email",
                    prefixIcon: Icon(Icons.email),
                  ),
                ),

                SizedBox(
                  height: 44.0,
                ),

                TextField(
                  controller: _passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),

                SizedBox(
                  height: 88.0,
                ),

                Center(child: MaterialButton(
                  onPressed: () async {
                    User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passController.text, context: context);
                    Email.text = _emailController.text;
                    print(user);
                    _emailController.clear();
                    _passController.clear();
                    if(user != null){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));

                    }
                  },


                  child: Text('Submit'),
                  textColor: Colors.white,
                  color: Colors.deepPurple,
                  hoverColor: Colors.black,
                  minWidth: double.infinity,
                  height: 44.0,
                )),

                SizedBox(
                  height: 44.0,
                ),

                Center(child: Text('For new user ?',style: TextStyle(color: Colors.deepPurple,fontSize: 16.0),)),

                SizedBox(height: 8.0,),

                Center(
                  child: RaisedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Registration()));
                    },
                    child: Text('Sign In'),
                    textColor: Colors.white,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

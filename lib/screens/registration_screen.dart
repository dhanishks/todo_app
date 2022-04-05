import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_application/auth/auth.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool _nameValidate = false;
  bool _emailValidate = false;
  bool _passValidate = false;
  bool _conPassValidate = false;
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _conPass = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void dispose(){
    _name.dispose();
    _email.dispose();
    _pass.dispose();
    _conPass.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
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
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 44.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                SizedBox(height: 44.0,),

                TextField(
                  controller: _name,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    errorText: _nameValidate ? 'Value Can\'t Be Empty' : null,
                    hintText: 'Username',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),

                SizedBox(height: 44.0,),

                TextField(
                  controller: _email,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    errorText: _emailValidate ? 'Value Can\'t Be Empty' : null,
                    hintText: 'User Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),

                SizedBox(height: 44.0,),

                TextField(
                  controller: _pass,
                  obscureText: true,
                  decoration: InputDecoration(
                    errorText: _passValidate ? 'Value Can\'t Be Empty' : null,
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),

                SizedBox(height: 44.0,),

                TextField(
                  controller: _conPass,
                  obscureText: true,
                  decoration: InputDecoration(
                    errorText: _conPassValidate ? 'Value Can\'t Be Empty' : null,
                    hintText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),

                SizedBox(height: 44.0,),

                MaterialButton(
                  onPressed: (){
                    setState(() {
                      _name.text.isEmpty ? _nameValidate = true : _nameValidate = false;
                      _email.text.isEmpty ? _emailValidate = true : _emailValidate = false;
                      _pass.text.isEmpty ? _passValidate = true : _passValidate = false;
                      _conPass.text.isEmpty ? _conPassValidate = true : _conPassValidate = false;
                    });
                    if(_emailValidate && _nameValidate && _passValidate && _conPassValidate) return;
                    if(_pass.text == _conPass.text && _pass.text.isNotEmpty && _email.text.isNotEmpty && _name.text.isNotEmpty) {
                      FireAuth.registerUsingEmailPassword(name: _name.text,
                          email: _email.text,
                          password: _pass.text);
                      Navigator.pop(context);
                      print('created');
                    }
                  },
                  textColor: Colors.white,
                  color: Colors.deepPurple,
                  child: Text('Submit'),
                  minWidth: double.infinity,
                  height: 44.0,
                ),

                SizedBox(height: 44.0,),

                Center(child: Text('Already have account?',style: TextStyle(color: Colors.deepPurple,fontSize: 16.0),)),

                Center(
                  child: MaterialButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    textColor: Colors.white,
                    color: Colors.deepPurple,
                    child: Text('Login'),
                    elevation: 10.0,
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

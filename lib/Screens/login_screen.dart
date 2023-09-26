import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task6/Screens/contacts_screen.dart';
import 'package:task6/services/shared_preferences_service.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  RegExp nameExp = RegExp(r'^[A-Za-z][A-Za-z0-9_]{7,29}$');
  RegExp passExp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[#$@!%&*?])[A-Za-z\d#$@!%&*?]{8,30}$');

  final _key = GlobalKey<FormState>();
  bool visible  = true;

  final PrefService _prefService = PrefService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(20),
              bottomStart: Radius.circular(20))),
          backgroundColor: const Color(0xFFAB72C0),
          title: const Text(
            'Welcome',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'SignIn',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: InkWell(
                        onTap: (){},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color:const Color(0xFFCDF0EA),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Color(0xFFCDF0EA),
                                radius: 20,
                                backgroundImage: AssetImage('assets/icons/7b9cd021df1cad1c974a82f58ff994a9.png'),
                              ),
                              Text(
                                'With Google',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: InkWell(
                        onTap: (){},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFCDF0EA),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Color(0xFFCDF0EA),
                                backgroundImage: AssetImage('assets/icons/2576de3a4df8d3cf899e9a9a74168b44.jpg'),
                              ),
                              Text(
                                'With Facebook',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  child: SizedBox(
                    child: Text(
                      'or',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: usernameController,
                          validator: (value){
                            if(value!.isEmpty || !nameExp.hasMatch(usernameController.text.toString()))
                            {
                              return 'A valid username should be between 8-30 letters, must start with \n an alphabetic character, and not contain any character';
                            }
                            else
                            {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if(value!.isEmpty || !passExp.hasMatch(passwordController.text.toString()))
                            {
                              return 'A valid password should be between 8-30 characters must\n contain at least one lowercase, at least one uppercase, \n at least one number and at least one special character.';
                            }
                            else
                            {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: visible,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  visible = !visible;
                                });
                              },
                              icon: Icon(visible? Icons.visibility :Icons.visibility_off,),
                            ),
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 80,),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(380, 60),
                              backgroundColor: const Color(0xFFAB72C0),
                              shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.0)) ,
                            ),
                            onPressed: () async{
                              _prefService.createCache(passwordController.text).whenComplete((){
                                if(_key.currentState!.validate()) {
                                  Navigator.push(
                                      context, MaterialPageRoute(
                                      builder: (context) =>
                                          const ContactsScreen()));
                                }
                              });

                              final SharedPreferences shared = await SharedPreferences.getInstance();
                              shared.setString('username', usernameController.text);
                              shared.setString('pass', passwordController.text);
                            },
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        TextButton(
                          onPressed: (){},
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
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



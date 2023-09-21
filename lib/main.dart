import 'package:flutter/material.dart';
import 'package:learnify_task/Screens/OtpPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learnify Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(title: 'Log in'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String selectedCountryCode = '+91';
  TextEditingController phoneNumberController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 16,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .40,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage('assets/login/logo.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  height: MediaQuery.of(context).size.height * .08,
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 2, color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(22)),
                  ),
                  child: Row(
                    children: [
                      DropdownButton<String>(
                        underline: Container(),
                        value: selectedCountryCode,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCountryCode = newValue!;
                          });
                        },
                        items: <String>[
                          '+91',
                          '+1',
                          '+44',
                          '+81'
                        ]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      Expanded(
                        child: TextFormField(
                          key: formKey,
                          controller: phoneNumberController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: '    Phone Number',
                            hintStyle: TextStyle(
                                fontSize: MediaQuery.of(context).size.width / 30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 8),
                  child: Text(
                    hasError ? "*Please enter a valid number" : "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: MediaQuery.of(context).size.width / 28,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .8,
                    height: MediaQuery.of(context).size.height *.06,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                              width: 1.0,
                              color: Colors.redAccent
                          ),
                          primary: Colors.redAccent,
                        shape:RoundedRectangleBorder(
                          borderRadius:BorderRadius.circular(22)
                        )
                      ),
                      onPressed: () {
                        String phoneNumber = selectedCountryCode + phoneNumberController.text;
                        formKey.currentState?.validate();
                        if(phoneNumberController.text.length !=10) {
                          setState(() {
                            hasError=true;
                          });
                        } else {
                          setState(() {
                            hasError=false;
                            Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage(data: phoneNumber)));
                          });
                        }
                      },
                      child: Text('Get OTP',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width / 22
                      ),),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: Text(
                    'By signing up you agree with our Terms and conditions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: MediaQuery.of(context).size.width / 26,
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

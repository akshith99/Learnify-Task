import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpPage extends StatefulWidget {

  final String data;

  const OtpPage({Key? key, required this.data}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  StreamController<ErrorAnimationType>? errorController;

  TextEditingController pinController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool hasError = false;
  String currentText = "";

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "OTP Verify",
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 16,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
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
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text("OTP Sent to",style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width /20,
                          fontWeight: FontWeight.w300,
                          color: Colors.black
                      ),),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.data, style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width /22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),),
                      )
                    ],
                  )
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PinCodeTextField(
                      appContext: context,
                      controller: pinController,
                      length: 4, // Set the field length to 4
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      animationType: AnimationType.fade,
                      validator: (v) {

                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(12),
                        borderWidth: 1,
                        disabledColor: Colors.white,
                        activeColor:   const Color.fromRGBO(229, 231, 249, 1.0),
                        inactiveColor: Colors.grey,
                        inactiveFillColor: Colors.white,
                        selectedColor: Colors.blue,
                        selectedFillColor: Colors.white,
                        fieldHeight: MediaQuery.of(context).size.height/14,
                        fieldWidth: MediaQuery.of(context).size.width * .18,

                        activeFillColor:
                        Colors.white,

                      ),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        debugPrint("Completed");
                      },
                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        return true;
                      },
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    hasError ? "*Please enter a valid OTP" : "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: MediaQuery.of(context).size.width / 28,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
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
                        formKey.currentState!.validate();
                        if(currentText.length != 4) {
                          errorController!.add(ErrorAnimationType.shake);
                          setState(() {
                            hasError = true;
                          });
                        } else {
                          setState(() {
                            hasError = false;
                            otpVerified();
                          });
                        }
                      },
                      child: Text('Verify OTP',style: TextStyle(
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
            )
          ],
        ),
      ),
    );
  }

  void otpVerified() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Card(
                color: Colors.white,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: const ScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.clear,
                                color: Color.fromRGBO(38, 70, 83, 1),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Text("OTP Verified", style: TextStyle(
                                color: const Color.fromRGBO(38, 70, 83, 1),
                                fontWeight: FontWeight.w700,
                                fontSize: MediaQuery.of(context).size.width / 26)),
                          ),
                          const Divider(),
                          Container(
                            padding: const EdgeInsets.only(top: 8.0,bottom: 30.0),
                            child: Text("Your details has been submitted", style: TextStyle(
                                color: const Color.fromRGBO(38, 70, 83, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: MediaQuery.of(context).size.width / 28)),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          );
        });
  }
}


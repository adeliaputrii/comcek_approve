import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myactivity_project/keyboard.dart';
import 'package:myactivity_project/ramayana_idcash.dart';
import 'package:myactivity_project/ramayana_idcashbarcode.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class RamayanaPin extends StatefulWidget {
   
  final String? phoneNumber;
  

  const RamayanaPin({
    Key? key,
    this.phoneNumber,
  }) : super(key: key);

  @override
  _RamayanaPin createState() =>
      _RamayanaPin();
}

class _RamayanaPin extends State<RamayanaPin> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";
  String text = '';
   _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
    });
  }
  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

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

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:Colors.white,
      body: 
      Stack(
        fit: StackFit.loose,
        children: [
          GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child:
             Container(
              // height: MediaQuery.of(context).size.height/1.04,
              // color: Colors.green,
               child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                             Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 7,
                    child: ClipRRect(
                      child: Image.asset('assets/rama(C).png'),
                    ),
                  ),
                   SizedBox(
                             height: 50,
                   ),
                  Container(
                    child: Text('Enter PIN', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 30),),
                  ),
                   SizedBox(
                             height: 30,
                   ),
                             
                             Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 50),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      readOnly: true,
                      showCursor: true,
                      obscureText: true,
                      obscuringCharacter: '*',
                      // obscuringWidget: const FlutterLogo(
                      //   size: 24,
                      // ),
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v!.length < 3) {
                          return "Please Enter";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 50,
                        disabledColor: Colors.white,
                        selectedColor: Color.fromARGB(255, 255, 0, 0),
                        selectedFillColor: Color.fromARGB(255, 255, 0, 0),
                        inactiveColor: Color.fromARGB(255, 228, 228, 228),
                        inactiveFillColor:Color.fromARGB(255, 228, 228, 228),
                        activeColor: Colors.white,
                        activeFillColor: Colors.white,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
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
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
                             ),
                ],
                             ),
                NumPad(
                             buttonSize: 75,
                             buttonColor: Color.fromARGB(255, 228, 228, 228),
                             iconColor: Color.fromARGB(255, 255, 17, 17),
                             controller: textEditingController,
                             delete: () {
                textEditingController.clear();
                // textEditingController.text = textEditingController.text
                //     .substring(0, textEditingController.text.length - 1);
                             },
                             // do something with the input numbers
                             onSubmit: () {
               formKey.currentState!.validate();
                        // conditions for validating
                        if (currentText.length != 6 || currentText != "123456") {
                          errorController!.add(ErrorAnimationType
                              .shake); // Triggering error shake animation
                          setState(() => hasError = true);
                        } else {
                          setState(
                            () {
                              hasError = false;
                              snackBar("Success!!!");
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RamayanaBarcode(),), (Route<dynamic> route) => false);
                            },
                          );
                        }
                             },
                  ),
                
                            
                 ],
                             ),
             ),
          ),
        ],
      ),
    );
  }
}


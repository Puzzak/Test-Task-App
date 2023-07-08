import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  Future sendMessage(String name, String email, String message) async {
    final headers = {'Content-Type': 'application/json; charset=utf-8'};
    const endpoint = "api.byteplex.info";
    const method = "api/test/contact/";
    final payload = json.encode({
      "name": name,
      "email": email,
      "message": message,
    });
    final response =
    await http.post(Uri.https(endpoint, method), headers: headers, body: payload);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  bool isSending = false;
  bool isValidated = false;
  String email = "";
  String name = "";
  String message = "";

  @override
  void initState() {
    super.initState();
  }

  bool validateEmail(String input) {
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(input);
  }

  void validateForm() {
    if(validateEmail(email) && message.length > 9 && name.length > 3){
      setState(() {
        isValidated = true;
      });
    }else{
      setState(() {
        isValidated = false;
      });
    }
  }
  void clearForm(){
    setState(() {
      name = "";
      email = "";
      message = "";
      nameController = TextEditingController(text: "");
      emailController = TextEditingController(text: "");
      messageController = TextEditingController(text: "");
      isValidated = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      theme: ThemeData(iconTheme: const IconThemeData(color: Colors.teal)),
      darkTheme: ThemeData.dark(), // standard dark theme
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: (
                          Text(
                            "Contact us",
                            style: TextStyle(
                                fontFamily: 'Roboto',
                              fontSize: 28,
                              height: 1,
                            ),
                          )
                      ),
                    ),
                  ]),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        launchUrl(Uri.parse("https://play.google.com/store/apps/dev?id=8304874346039659820"),
                            mode: LaunchMode.externalApplication);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(15),
                        child: (
                            Icon(
                                Icons.arrow_back_rounded,
                              size: 28,
                            )
                        ),
                      ),
                    )
                  ]),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          child: TextField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              errorText: name.length > 3 ? null : "Enter name",
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2.0,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: name.length > 3 ? Colors.teal : Colors.red, // Set the focused border color
                                  width: 2.0,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: name.length > 3 ? Colors.teal : Colors.red,
                                  width: 2.0,
                                ),
                              ),
                              hintText: 'Name',
                              hintStyle: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            onChanged: (value) async {
                              setState(() {
                                name = value;
                                validateForm();
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ), //Name
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          child: TextField(
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              errorText: validateEmail(email) ? null : "Enter valid email",
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2.0,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: validateEmail(email) ? Colors.teal : Colors.red, // Set the focused border color
                                  width: 2.0,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: validateEmail(email) ? Colors.teal : Colors.red,
                                  width: 2.0,
                                ),
                              ),
                              hintText: 'Email',
                              hintStyle: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            onChanged: (value) async {
                              setState(() {
                                email = value;
                                validateForm();
                              });
                            },
                            onTapOutside: (PointerDownEvent e) {
                              setState(() {
                                validateEmail(email);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ), //Email
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          child: TextField(
                            controller: messageController,
                            textInputAction: TextInputAction.newline,
                            minLines: 4,
                            maxLines: 10,
                            style: const TextStyle(
                              height: 1
                            ),
                            decoration: InputDecoration(
                              errorText: message.length > 9 ? null : "Enter message",
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2.0,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: message.length > 9 ? Colors.teal : Colors.red, // Set the focused border color
                                  width: 2.0,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: message.length > 9 ? Colors.teal : Colors.red,
                                  width: 2.0,
                                ),
                              ),
                              hintText: 'Message',
                              hintStyle: const TextStyle(
                                fontSize: 16,
                                height: 1
                              ),
                            ),
                            onChanged: (value) async {
                              setState(() {
                                message = value;
                                validateForm();
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ), // Message
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isValidated ? Colors.teal : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(
                              color: isValidated ? Colors.teal : Colors.red.withAlpha(128),
                              width: 2
                          ),
                        ),
                      ),
                        onPressed: isValidated ? () async {
                          setState(() {
                            isSending = true;
                            sendMessage(name, email, message).then((value){
                              Fluttertoast.showToast(
                                msg: value ? 'Message sent!' : 'Error while sending message!',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                              );
                              setState(() {
                                if(value){
                                clearForm();
                              }
                                isSending = false;
                              });
                            });
                          });
                        } : null,
                      child: isSending ? Column(
                        children: const [Text(
                          "Sending...",
                        ),
                          LinearProgressIndicator(
                            color: Colors.white,
                            backgroundColor: Colors.transparent,
                          ),
                        ],
                      ) : Text(
                          "Send",
                          style: TextStyle(
                            color: isValidated ? Colors.white : Colors.grey,
                          ),
                      ),
                    ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

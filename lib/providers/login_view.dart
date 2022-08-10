// import 'package:flutter/material.dart';
// import 'package:flutter_web/controllers/login_controller.dart';
// import 'package:flutter_web/locator.dart';
// import 'package:flutter_web/routing/route_names.dart';
// import 'package:flutter_web/services/navigation_service.dart';
// import 'package:get/get.dart' hide Response;
//
// class LoginView extends StatelessWidget {
//   String? returnPage;
//
//   LoginView({Key? key, this.returnPage=HomeRoute}) : super(key: key);
//
//   // LoginController controller = Get.find();
//   final controller = Get.put(LoginController());
//   // final LoginController controller = Get.arguments;
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: controller.loginFormKey,
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 20),
//             SizedBox(
//               width: 400,
//               child: buildEmail(),
//             ),
//             SizedBox(height: 20),
//             SizedBox(
//               width: 400,
//               child: buildPassword(),
//             ),
//             SizedBox(height: 20),
//             SizedBox(
//               width: 400,
//               child: buildLoginBtn(),
//             ),
//             SizedBox(height: 20),
//             SizedBox(
//               width: 400,
//               child: buildForgotPassBtn(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildEmail(){
//     return Container(
//       child: Column(
//         children: [
//           TextFormField(
//             controller: controller.loginEmailController,
//             // initialValue: 'aaa@a.com',
//             decoration: const InputDecoration(
//               prefixIcon: Icon(Icons.email),
//               // suffixIcon: Icon(Icons.star),
//               hintText: 'aaa@a.com',
//               border: InputBorder.none,
//               // labelText: 'Label Text',
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(0.5)),
//                 borderSide: BorderSide( color: Colors.blue, ),
//               ),
//               filled: true,
//               fillColor: Colors.black12,
//             ),
//             autovalidateMode: AutovalidateMode.always,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please insert your Email.';
//               } else {
//                 String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                 RegExp regExp = new RegExp(pattern);
//                 if(!regExp.hasMatch(value)){
//                   return 'Invalid email format!';
//                 }else{
//                   return null;
//                 }
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildPassword(){
//     return Container(
//       child: Column(
//         children: [
//           TextFormField(
//             controller: controller.loginPasswordController,
//             decoration: const InputDecoration(
//               prefixIcon: Icon(Icons.lock),
//               // suffixIcon: Icon(Icons.star),
//               hintText: 'Insert new password',
//               border: InputBorder.none,
//               // labelText: 'Label Text',
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(0.5)),
//                 borderSide: BorderSide( width:2,color: Colors.blue),
//               ),
//               filled: true,
//               fillColor: Colors.black12,
//             ),
//             keyboardType: TextInputType.text,
//             obscureText: true,
//             autovalidateMode: AutovalidateMode.always,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please insert your password.';
//               } else {
//                 return null;
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildLoginBtn(){
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 2),
//       width: double.infinity,   //width full size
//       height: 50,
//       child: ElevatedButton.icon(
//           onPressed: () async{
//             controller.login(returnPage!);
//           },
//           icon: Icon(Icons.login),
//           label: Text("Login")
//       ),
//     );
//   }
//
//   Widget buildForgotPassBtn(){
//     return Stack(
//         children: [
//           Container(
//             alignment: Alignment.centerLeft,
//             child: TextButton(
//               onPressed: () => {
//                 locator<NavigationService>().navigateTo(RegisterRoute)
//               },
//               child: Text(
//                 "Register?",
//                 style: TextStyle(
//                     color: Colors.black26,
//                     fontWeight: FontWeight.bold
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             alignment: Alignment.centerRight,
//             child: TextButton(
//               onPressed: () => {
//                 locator<NavigationService>().navigateTo(ForgetRoute)
//               },
//               child: Text(
//                 "Forget Password?",
//                 style: TextStyle(
//                     color: Colors.black26,
//                     fontWeight: FontWeight.bold
//                 ),
//               ),
//             ),
//           ),
//         ]
//     );
//   }
// }

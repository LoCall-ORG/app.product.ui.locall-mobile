import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:locall/utils/localisation/app_locale.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset("assets/images/open-shop.jpg"),
              Column(
                children: [
                  const SizedBox(
                    height: 220,
                  ),
                  Container(
                    width: double.infinity,
                    height: size.height - 220,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 140,
                        ),
                        const Text(
                          "LoCall",
                          style: TextStyle(
                            fontFamily: "Horizon",
                            fontSize: 40,
                            color: Colors.black,
                            letterSpacing: 4,
                          ),
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                        Text(
                          AppLocale.letsConnectWithUs.getString(context),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: _mobileController,
                            decoration: InputDecoration(
                              labelText: AppLocale.enterMobileNumber
                                  .getString(context),
                              labelStyle: const TextStyle(color: Colors.grey),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80),
                              color: const Color(
                                0xffc2e969,
                              ),
                            ),
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: Center(
                              child: Text(
                                AppLocale.login.getString(context),
                                style: const TextStyle(
                                    color: Color(0xff2F6A49),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:el_nono/admin/ui/layout/layout.dart';
import 'package:el_nono/admin/ui/reset/pass.dart';
import 'package:el_nono/shared/components/components.dart';
import 'package:el_nono/shared/components/constants.dart';
import 'package:el_nono/shared/ui/layout/layout.dart';
import 'package:flutter/material.dart';
import 'package:el_nono/l10n/app_localizations.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  var ctrlUsername = TextEditingController();
  var ctrlPass = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool isCheck = true;
  bool pass = true;
  IconData passIc = Icons.visibility_off_outlined;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;

    return Scaffold(
      body: Form(
        key: formkey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 69),
                  Container(
                    height: MediaQuery.sizeOf(context).height / 3,
                    padding: const EdgeInsets.all(18.6),
                    child: txt(
                      context: context,
                      txt: local.nono,
                      isBold: true,
                      size: 79,
                      isClr: true,
                      clr: bg.withValues(alpha: 0.7),
                      isItalic: true,
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 2,
                    child: Column(
                      children: [
                        txt(
                          context: context,
                          txt: "${local.hey} $nameData ^_^",
                          isClr: true,
                          clr: bg,
                          isBold: true,
                          size: 23,
                        ),
                        const SizedBox(height: 7),
                        tff(
                            text: local.username,
                            icon: Icons.mail_outline,
                            ctrl: ctrlUsername,
                            type: TextInputType.emailAddress,
                            vld: (val) {
                              if (val!.isEmpty) {
                                return local.enter_username;
                              }
                              return null;
                            },
                            smt: (val) {
                              if (formkey.currentState!.validate()) {
                                if (usernameData == ctrlUsername.text) {
                                  if (passData == ctrlPass.text) {
                                    pgx(
                                        context: context,
                                        nextPage: const AdminLayout());
                                  } else {
                                    setState(() {
                                      isCheck = false;
                                    });
                                  }
                                } else {
                                  setState(() {
                                    isCheck = false;
                                  });
                                }
                              }
                            }),
                        const SizedBox(height: 18),
                        tff(
                            text: local.password,
                            icon: Icons.password_outlined,
                            ctrl: ctrlPass,
                            type: TextInputType.visiblePassword,
                            pss: pass,
                            sfx: () {
                              setState(() {
                                pass = !pass;
                                if (pass) {
                                  passIc = Icons.visibility_off_outlined;
                                } else {
                                  passIc = Icons.visibility_outlined;
                                }
                              });
                            },
                            icSfx: passIc,
                            vld: (val) {
                              if (val!.isEmpty) {
                                return local.enter_password;
                              }
                              return null;
                            },
                            smt: (val) {
                              if (formkey.currentState!.validate()) {
                                if (usernameData == ctrlUsername.text) {
                                  if (passData == ctrlPass.text) {
                                    pgx(
                                        context: context,
                                        nextPage: const AdminLayout());
                                  } else {
                                    setState(() {
                                      isCheck = false;
                                    });
                                  }
                                } else {
                                  setState(() {
                                    isCheck = false;
                                  });
                                }
                              }
                            }),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {
                              pgn(
                                  context: context,
                                  nextPage: const AdminResetPassword());
                            },
                            child: txt(
                              context: context,
                              txt: local.reset_password,
                              isClr: true,
                              clr: bg,
                            ),
                          ),
                        ),
                        const SizedBox(height: 29),
                        !isCheck
                            ? txt(
                                context: context,
                                txt: local.check_both,
                                isClr: true,
                                clr: Colors.red,
                              )
                            : const SizedBox(),
                        const SizedBox(height: 69),
                        btn(
                          fun: () {
                            if (formkey.currentState!.validate()) {
                              if (usernameData == ctrlUsername.text) {
                                if (passData == ctrlPass.text) {
                                  pgx(
                                      context: context,
                                      nextPage: const AdminLayout());
                                } else {
                                  setState(() {
                                    isCheck = false;
                                  });
                                }
                              } else {
                                setState(() {
                                  isCheck = false;
                                });
                              }
                            }
                          },
                          isTxt: true,
                          text: local.login,
                          clr: bg,
                          rd: 69,
                          sz: 23,
                          ht: 55,
                          up: false,
                        ),
                        const SizedBox(height: 18),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 7,
                            horizontal: 69,
                          ),
                          child: btn(
                            fun: () {
                              pgx(
                                  context: context,
                                  nextPage: const LayoutGeneral());
                            },
                            isTxt: true,
                            text: local.back,
                            clr: bg.withValues(alpha: 0.6),
                            rd: 69,
                            sz: 23,
                            ht: 55,
                            up: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 13),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

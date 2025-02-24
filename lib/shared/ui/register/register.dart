import 'package:el_nono/main.dart';
import 'package:el_nono/shared/components/components.dart';
import 'package:el_nono/shared/components/constants.dart';
import 'package:el_nono/shared/cubit/app_cubit.dart';
import 'package:el_nono/shared/cubit/app_states.dart';
import 'package:el_nono/shared/ui/layout/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_nono/l10n/app_localizations.dart';

class AdminRegister extends StatelessWidget {
  const AdminRegister({super.key});

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var ctrlName = TextEditingController();
    var ctrlNID = TextEditingController();
    var ctrlUsername = TextEditingController();
    var ctrlPass = TextEditingController();
    var ctrlRePass = TextEditingController();
    var ctrlUserUsername = TextEditingController();
    var ctrlUserPass = TextEditingController();
    var ctrlUserRePass = TextEditingController();
    var local = AppLocalizations.of(context)!;

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppInsertDataAdminSuccState) {
          pgx(context: context, nextPage: const LayoutGeneral());
          AppCubit.get(context).chgSure();
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);

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
                        height: MediaQuery.sizeOf(context).height / 7,
                        padding: const EdgeInsets.all(18.6),
                        child: txt(
                          context: context,
                          txt: local.nono,
                          isBold: true,
                          size: 39,
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
                            //Admin
                            txt(
                              context: context,
                              txt: local.admin,
                              isClr: true,
                              clr: bg,
                              isBold: true,
                              size: 23,
                            ),
                            const SizedBox(height: 7),
                            tff(
                              text: local.name,
                              icon: Icons.person_3_outlined,
                              ctrl: ctrlName,
                              type: TextInputType.name,
                              vld: (val) {
                                if (val!.isEmpty) {
                                  return local.enter_name;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 18),
                            tff(
                              text: local.national,
                              icon: Icons.card_membership_outlined,
                              ctrl: ctrlNID,
                              isNum: true,
                              mx: 14,
                              vld: (val) {
                                if (val!.isEmpty) {
                                  return local.enter_national;
                                }
                                if (val.length != 14) {
                                  return local.enter_national;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 18),
                            tff(
                              text: local.username,
                              icon: Icons.mail_outline,
                              ctrl: ctrlUsername,
                              type: TextInputType.name,
                              vld: (val) {
                                if (val!.isEmpty) {
                                  return local.enter_username;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 18),
                            tff(
                              text: local.password,
                              icon: Icons.lock_outline,
                              ctrl: ctrlPass,
                              type: TextInputType.visiblePassword,
                              pss: cubit.pass,
                              sfx: () => cubit.chgPass(),
                              icSfx: cubit.passIc,
                              vld: (val) {
                                if (val!.isEmpty) {
                                  return local.enter_password;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 18),
                            tff(
                              text: local.confirm_password,
                              icon: Icons.lock_outline,
                              ctrl: ctrlRePass,
                              type: TextInputType.visiblePassword,
                              pss: cubit.rePass,
                              sfx: () => cubit.chgRePass(),
                              icSfx: cubit.rePassIc,
                              vld: (val) {
                                if (val!.isEmpty) {
                                  return local.enter_confirm_password;
                                }
                                if (val != ctrlPass.text) {
                                  return local.repeat_password;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 39),
                            //User
                            txt(
                              context: context,
                              txt: local.user,
                              isClr: true,
                              clr: bg,
                              isBold: true,
                              size: 23,
                            ),
                            const SizedBox(height: 7),
                            tff(
                              text: local.username,
                              icon: Icons.mail_outline,
                              ctrl: ctrlUserUsername,
                              type: TextInputType.name,
                              vld: (val) {
                                if (val!.isEmpty) {
                                  return local.enter_username;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 18),
                            tff(
                              text: local.password,
                              icon: Icons.lock_outline,
                              ctrl: ctrlUserPass,
                              type: TextInputType.visiblePassword,
                              pss: cubit.userPass,
                              sfx: () => cubit.chgUserPass(),
                              icSfx: cubit.userPassIc,
                              vld: (val) {
                                if (val!.isEmpty) {
                                  return local.enter_password;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 18),
                            tff(
                              text: local.confirm_password,
                              icon: Icons.lock_outline,
                              ctrl: ctrlUserRePass,
                              type: TextInputType.visiblePassword,
                              pss: cubit.userRePass,
                              sfx: () => cubit.chgUserRePass(),
                              icSfx: cubit.userRePassIc,
                              vld: (val) {
                                if (val!.isEmpty) {
                                  return local.enter_confirm_password;
                                }
                                if (val != ctrlUserPass.text) {
                                  return local.repeat_password;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 69),
                            cubit.isSure
                                ? Column(
                                    children: [
                                      txt(
                                        context: context,
                                        isStart: false,
                                        txt: local.warning,
                                        size: 23,
                                        isClr: true,
                                        clr: Colors.red,
                                        isBold: true,
                                        isItalic: true,
                                      ),
                                      txt(
                                        context: context,
                                        isStart: false,
                                        txt: local.sure_register,
                                        isClr: true,
                                        clr: Colors.red,
                                        isBold: true,
                                      ),
                                      const SizedBox(height: 9),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: btn(
                                              fun: () {
                                                if (formkey.currentState!
                                                    .validate()) {
                                                  ctrlName.clear();
                                                  ctrlNID.clear();
                                                  ctrlUsername.clear();
                                                  ctrlPass.clear();
                                                  ctrlRePass.clear();
                                                  ctrlUserUsername.clear();
                                                  ctrlUserPass.clear();
                                                  ctrlUserRePass.clear();
                                                  cubit.chgSure();
                                                }
                                              },
                                              isTxt: true,
                                              text: local.reset,
                                              clr: bg.withValues(alpha: 0.6),
                                              rd: 69,
                                              sz: 23,
                                              ht: 55,
                                              up: false,
                                            ),
                                          ),
                                          const SizedBox(width: 9),
                                          Expanded(
                                            child: btn(
                                              fun: () {
                                                if (formkey.currentState!
                                                    .validate()) {
                                                  cubit.insertDataAdmin(
                                                    name: ctrlName.text,
                                                    nID: int.tryParse(
                                                        ctrlNID.text)!,
                                                    username: ctrlUsername.text,
                                                    pass: ctrlPass.text,
                                                    userUsername:
                                                        ctrlUserUsername.text,
                                                    userPass: ctrlUserPass.text,
                                                    isReg: true,
                                                    isActivate: false,
                                                    deviceID: deviceID!,
                                                    activateKey: cubit.encryption(deviceID!.substring(0,13)),
                                                  );
                                                }
                                              },
                                              isTxt: true,
                                              text: local.sure,
                                              clr: bg,
                                              rd: 69,
                                              sz: 23,
                                              ht: 55,
                                              up: false,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : btn(
                                    fun: () {
                                      if (formkey.currentState!.validate()) {
                                        cubit.chgSure();
                                      }
                                    },
                                    isTxt: true,
                                    text: local.register,
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
                                      nextPage: const MyApp());
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
      },
    );
  }
}

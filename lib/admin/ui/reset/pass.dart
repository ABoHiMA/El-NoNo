import 'package:el_nono/admin/ui/login/login.dart';
import 'package:el_nono/admin/ui/reset/username.dart';
import 'package:el_nono/shared/components/components.dart';
import 'package:el_nono/shared/components/constants.dart';
import 'package:el_nono/shared/cubit/app_cubit.dart';
import 'package:el_nono/shared/cubit/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_nono/l10n/app_localizations.dart';

class AdminResetPassword extends StatelessWidget {
  const AdminResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    var ctrlNID = TextEditingController();
    var ctrlPass = TextEditingController();
    var ctrlRePass = TextEditingController();
    var formkey = GlobalKey<FormState>();

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppUpdateDataAdminSuccState) {
          pgx(context: context, nextPage: const AdminLogin());
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var local = AppLocalizations.of(context)!;

        return Scaffold(
          body: Form(
            key: formkey,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 186),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      txt(
                        context: context,
                        txt: local.reset_admin_username,
                        isClr: true,
                        clr: bg,
                        isBold: true,
                        size: 23,
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
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      tff(
                        text: local.new_password,
                        icon: Icons.lock_outline,
                        ctrl: ctrlPass,
                        type: TextInputType.visiblePassword,
                        pss: cubit.resetPass,
                        sfx: () {
                          cubit.chgResetPass();
                        },
                        icSfx: cubit.resetPassIc,
                        vld: (val) {
                          if (val!.isEmpty) {
                            return local.enter_new_password;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      tff(
                        text: local.repeat_password,
                        icon: Icons.lock_outline,
                        ctrl: ctrlRePass,
                        type: TextInputType.visiblePassword,
                        pss: cubit.resetRePass,
                        sfx: () {
                          cubit.chgResetRePass();
                        },
                        icSfx: cubit.resetRePassIc,
                        vld: (val) {
                          if (val!.isEmpty) {
                            return local.repeat_password;
                          }
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            pgn(
                                context: context,
                                nextPage: const AdminResetUsername());
                          },
                          child: txt(
                            context: context,
                            txt: local.reset_username,
                            isClr: true,
                            clr: bg,
                          ),
                        ),
                      ),
                      const SizedBox(height: 29),
                      cubit.isCheck
                          ? const SizedBox()
                          : txt(
                              context: context,
                              txt: local.check_admin_id,
                              isClr: true,
                              clr: Colors.red,
                            ),
                      const SizedBox(height: 69),
                      btn(
                        fun: () {
                          if (formkey.currentState!.validate()) {
                            if (int.parse(ctrlNID.text) == nIDData) {
                              cubit.isCheck ? null : cubit.chgCheck();
                              cubit.updateDataAdmin(
                                username: usernameData!,
                                pass: ctrlPass.text,
                              );
                            } else {
                              cubit.chgCheck();
                            }
                          }
                        },
                        isTxt: true,
                        text: local.update_password,
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
                            pgx(context: context, nextPage: const AdminLogin());
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
              ),
            ),
          ),
        );
      },
    );
  }
}

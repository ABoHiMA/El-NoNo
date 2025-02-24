import 'package:el_nono/admin/ui/login/login.dart';
import 'package:el_nono/shared/components/components.dart';
import 'package:el_nono/shared/components/constants.dart';
import 'package:el_nono/shared/cubit/app_cubit.dart';
import 'package:el_nono/shared/cubit/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_nono/l10n/app_localizations.dart';

class AdminResetUsername extends StatelessWidget {
  const AdminResetUsername({super.key});

  @override
  Widget build(BuildContext context) {
    var ctrlNID = TextEditingController();
    var ctrlUsername = TextEditingController();
    var ctrlReUsername = TextEditingController();
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
                        text: local.new_username,
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
                        text: local.repeat_username,
                        icon: Icons.mail_outline,
                        ctrl: ctrlReUsername,
                        type: TextInputType.name,
                        vld: (val) {
                          if (val!.isEmpty) {
                            return local.enter_repeat_username;
                          }
                          return null;
                        },
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
                            cubit.isCheck ? null : cubit.chgCheck();
                            if (int.parse(ctrlNID.text) == nIDData) {
                              cubit.updateDataAdmin(
                                username: ctrlUsername.text,
                                pass: passData!,
                              );
                            } else {
                              cubit.chgCheck();
                            }
                          }
                        },
                        isTxt: true,
                        text: local.update_username,
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

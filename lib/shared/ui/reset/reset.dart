import 'package:el_nono/shared/components/components.dart';
import 'package:el_nono/shared/components/constants.dart';
import 'package:el_nono/shared/cubit/app_cubit.dart';
import 'package:el_nono/shared/cubit/app_states.dart';
import 'package:el_nono/shared/ui/layout/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_nono/l10n/app_localizations.dart';

class ResetApp extends StatelessWidget {
  const ResetApp({super.key});

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var ctrlReset = TextEditingController();
    var local = AppLocalizations.of(context)!;

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppResetDataState) {
          pgx(
            context: context,
            nextPage: const WelcomeNoNo(),
          );
          AppCubit.get(context).chgSure();
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                cubit.isSure ? cubit.chgSure() : null;
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: bg,
              ),
            ),
            title: Container(
              child: txt(
                context: context,
                txt: local.nono,
                isBold: true,
                size: 49,
                isClr: true,
                clr: bg.withValues(alpha: 0.7),
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(186),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: txt(
                        context: context,
                        txt: local.enter_national_reset,
                        isBold: true,
                        size: 39,
                      ),
                    ),
                    const SizedBox(height: 18),
                    tff(
                        text: local.national,
                        icon: Icons.card_membership_outlined,
                        ctrl: ctrlReset,
                        type: TextInputType.number,
                        mx: 14,
                        vld: (val) {
                          if (val!.isEmpty) {
                            return local.enter_national;
                          }
                          if (val.length != 14) {
                            return local.enter_national;
                          }
                          if (ctrlReset.text != nIDData.toString()) {
                            return local.enter_national;
                          }
                          return null;
                        },
                        smt: (val) {
                          if (formkey.currentState!.validate()) {
                            if (ctrlReset.text == nIDData.toString()) {
                              cubit.chgSure();
                            }
                          }
                        }),
                    SizedBox(height: MediaQuery.sizeOf(context).height / 18),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: state is! AppLoadingDataState
                          ? cubit.isSure
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
                                      txt: local.sure_reset,
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
                                              ctrlReset.clear();
                                              cubit.chgSure();
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
                                        const SizedBox(width: 9),
                                        Expanded(
                                          child: btn(
                                            fun: () {
                                              if (formkey.currentState!
                                                  .validate()) {
                                                cubit.dropDataFromTables().then(
                                                      (value) => cubit
                                                          .reset()
                                                          .then((onValue) {
                                                        cubit.createNoNoData();
                                                      }),
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
                                      if (ctrlReset.text ==
                                          nIDData.toString()) {
                                        cubit.chgSure();
                                      }
                                    }
                                  },
                                  isTxt: true,
                                  text: local.reset,
                                  clr: Colors.redAccent,
                                  rd: 69,
                                  sz: 23,
                                  ht: MediaQuery.sizeOf(context).height / 13,
                                  up: false,
                                )
                          : const CircularProgressIndicator(color: bg),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

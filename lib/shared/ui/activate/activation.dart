import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:el_nono/l10n/app_localizations.dart';
import 'package:el_nono/shared/components/components.dart';
import 'package:el_nono/shared/components/constants.dart';
import 'package:el_nono/shared/cubit/app_cubit.dart';
import 'package:el_nono/shared/cubit/app_states.dart';
import 'package:el_nono/shared/ui/layout/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Activation extends StatelessWidget {
  const Activation({super.key});

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var ctrlActiveKey = TextEditingController();
    var local = AppLocalizations.of(context)!;

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                pgx(context: context, nextPage: const LayoutGeneral());
                cubit.isClick ? cubit.chgClick() : null;
                !cubit.isCheck ? cubit.chgCheck() : null;
              },
              icon: Icon(
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
                isItalic: true,
              ),
            ),
            centerTitle: true,
          ),
          body: ConditionalBuilder(
            condition: isActive,
            builder: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.done_outline_outlined,
                    size: 186,
                    color: bg,
                  ),
                  FittedBox(
                    child: txt(
                      context: context,
                      txt: local.activation_successfully,
                      isBold: true,
                      size: 39,
                      clr: bg,
                      isClr: true,
                      isStart: false,
                    ),
                  ),
                  const SizedBox(height: 69),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: btn(
                      fun: () {
                        pgx(context: context, nextPage: const LayoutGeneral());
                      },
                      isTxt: true,
                      text: local.home,
                      clr: bg,
                      rd: 69,
                      sz: 23,
                      ht: MediaQuery.sizeOf(context).height / 13,
                      wd: MediaQuery.sizeOf(context).width / 6,
                      up: false,
                    ),
                  ),
                ],
              ),
            ),
            fallback: (context) => SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(186),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              cubit.chgClick();
                            },
                            child: FittedBox(
                              child: txt(
                                context: context,
                                txt:
                                    local.activation_key_full,
                                isBold: true,
                                size: 29,
                              ),
                            ),
                          ),
                        ],
                      ),
                      cubit.isClick
                          ? txt(context: context, txt: deviceID!)
                          : const SizedBox(),
                      const SizedBox(height: 23),
                      tff(
                        text: local.activation_key,
                        ctrl: ctrlActiveKey,
                        type: TextInputType.text,
                        isPfx: true,
                        icon: Icons.key,
                        mx: 13,
                        vld: (val) {
                          if (val!.isEmpty) {
                            return local.enter_activation;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height / 18),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: btn(
                          fun: () {
                            if (formkey.currentState!.validate()) {
                                if (ctrlActiveKey.text ==
                                    activateKey!.substring(0, 13)) {
                                  cubit.activation();
                                  !cubit.isCheck ? cubit.chgCheck() : null;
                                } else {
                                  cubit.isCheck ? cubit.chgCheck() : null;
                                }
                            }
                          },
                          isTxt: true,
                          text: local.active,
                          clr: bg,
                          rd: 69,
                          sz: 23,
                          ht: MediaQuery.sizeOf(context).height / 13,
                          up: false,
                        ),
                      ),
                      cubit.isCheck
                          ? const SizedBox()
                          : txt(
                              context: context,
                              txt: local.key_wrong,
                              isClr: true,
                              clr: Colors.red,
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

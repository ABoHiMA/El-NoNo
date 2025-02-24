import 'package:el_nono/shared/components/components.dart';
import 'package:el_nono/shared/components/constants.dart';
import 'package:el_nono/shared/cubit/app_cubit.dart';
import 'package:el_nono/shared/cubit/app_states.dart';
import 'package:el_nono/shared/ui/layout/layout.dart';
import 'package:el_nono/shared/ui/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_nono/l10n/app_localizations.dart';

class WelcomeNoNo extends StatelessWidget {
  const WelcomeNoNo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var local = AppLocalizations.of(context)!;

        return Scaffold(
          appBar: AppBar(
            leading: const SizedBox(),
            actions: [
              state is AppGetAllElNoNoDataSuccState ||
                  state is AppChangeLanguageState
                  ? TextButton(
                      onPressed: () {
                        AppCubit.get(context).changeLanguage(context);
                      },
                      child: txt(
                        context: context,
                        txt: local.language,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(18),
                  child: txt(
                    context: context,
                    txt: local.welcome,
                    isBold: true,
                    size: 79,
                    isClr: true,
                    clr: bg.withValues(alpha: 0.7),
                  ),
                ),
                state is AppGetAllElNoNoDataSuccState ||
                        state is AppChangeLanguageState
                    ? Card(
                        margin: const EdgeInsets.all(18),
                        color: bg.withValues(alpha: 0.7),
                        child: InkWell(
                          onTap: () {
                            if (isUser) {
                              if (deviceID == deviceIdData) {
                                pgn(
                                    context: context,
                                    nextPage: const LayoutGeneral());
                              } else {
                                pgn(
                                    context: context,
                                    nextPage: const AdminRegister());
                              }
                            } else {
                              pgn(
                                  context: context,
                                  nextPage: const AdminRegister());
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.all(18.6),
                            child: txt(
                              context: context,
                              txt: local.start,
                              isBold: true,
                              size: 79,
                              isClr: true,
                              clr: wt,
                              isItalic: false,
                            ),
                          ),
                        ),
                      )
                    : const CircularProgressIndicator(color: bg),
              ],
            ),
          ),
        );
      },
    );
  }
}

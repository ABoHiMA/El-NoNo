import 'package:el_nono/admin/ui/login/login.dart';
import 'package:el_nono/shared/components/components.dart';
import 'package:el_nono/shared/components/constants.dart';
import 'package:el_nono/shared/cubit/app_cubit.dart';
import 'package:el_nono/shared/ui/activate/activation.dart';
import 'package:el_nono/shared/ui/reset/reset.dart';
import 'package:el_nono/shared/ui/support/support.dart';
import 'package:el_nono/user/ui/login/login.dart';
import 'package:flutter/material.dart';
import 'package:el_nono/l10n/app_localizations.dart';

class LayoutGeneral extends StatefulWidget {
  const LayoutGeneral({super.key});

  @override
  State<LayoutGeneral> createState() => _LayoutGeneralState();
}

class _LayoutGeneralState extends State<LayoutGeneral> {
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        actions: [
          TextButton(
            onPressed: () {
              AppCubit.get(context).changeLanguage(context);
            },
            child: txt(
              context: context,
              txt: local.language,
              size: 23,
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(13.7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 18),
              Container(
                child: txt(
                  context: context,
                  txt: local.nono,
                  isBold: true,
                  size: 99,
                  isClr: true,
                  clr: bg.withValues(alpha: 0.7),
                  isItalic: true,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    child: InkWell(
                      onTap: () {
                        pgn(context: context, nextPage: const AdminLogin());
                      },
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height / 3,
                        width: MediaQuery.sizeOf(context).width / 5,
                        child: Column(
                          children: [
                            Image(
                              image: const AssetImage(
                                'assets/images/admin.png',
                              ),
                              height: MediaQuery.sizeOf(context).height / 4,
                              width: MediaQuery.sizeOf(context).width / 6,
                            ),
                            const SizedBox(height: 13),
                            txt(
                              context: context,
                              txt: local.admin,
                              size: 23,
                              isBold: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 13),
                  Card(
                    child: InkWell(
                      onTap: () {
                        pgn(context: context, nextPage: const UserLogin());
                      },
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height / 3,
                        width: MediaQuery.sizeOf(context).width / 5,
                        child: Column(
                          children: [
                            Image(
                              image: const AssetImage(
                                'assets/images/user.png',
                              ),
                              height: MediaQuery.sizeOf(context).height / 4,
                              width: MediaQuery.sizeOf(context).width / 6,
                            ),
                            const SizedBox(height: 13),
                            txt(
                              context: context,
                              txt: local.user,
                              size: 23,
                              isBold: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  btn(
                    fun: () {
                      pgn(context: context, nextPage: const Support());
                    },
                    wd: MediaQuery.sizeOf(context).width / 9,
                    isTxt: true,
                    text: local.support,
                    clr: bg.withValues(alpha: 0.7),
                  ),
                  !isActive
                      ? btn(
                          fun: () {
                            pgn(context: context, nextPage: const Activation());
                          },
                          wd: MediaQuery.sizeOf(context).width / 9,
                          isTxt: true,
                          text: local.active,
                          clr: bg,
                          isEnable: !isActive,
                        )
                      : Row(
                          children: [
                            const Icon(
                              Icons.done_outline_outlined,
                              // size: 186,
                              color: bg,
                            ),
                            const SizedBox(width: 6),
                            txt(
                              context: context,
                              txt: local.activated,
                              isClr: true,
                              clr: bg,
                              isBold: true,
                              size: 23,
                            ),
                          ],
                        ),
                  btn(
                    fun: () {
                      pgn(context: context, nextPage: const ResetApp());
                    },
                    wd: MediaQuery.sizeOf(context).width / 9,
                    isTxt: true,
                    text: local.reset,
                    clr: Colors.redAccent.withValues(alpha: 0.7),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

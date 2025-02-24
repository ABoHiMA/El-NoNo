import 'package:el_nono/shared/components/components.dart';
import 'package:el_nono/shared/components/constants.dart';
import 'package:el_nono/shared/ui/layout/layout.dart';
import 'package:flutter/material.dart';
import 'package:el_nono/l10n/app_localizations.dart';

class Support extends StatelessWidget {
  const Support({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(13.7),
                child: txt(
                  context: context,
                  txt: local.ahmed,
                  size: 59,
                  isBold: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7.13),
                child: txt(
                  context: context,
                  txt: "ahmedebrahim1806@gmail.com",
                  size: 29,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7.13),
                child: txt(
                  context: context,
                  txt: "01008234875",
                  size: 29,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  IconButton(
                    onPressed: () =>
                        url(link: "facebook.com/Ahmed.I.Khalil186"),
                    icon: Image(
                      image: const AssetImage('assets/images/fb.png'),
                      height: MediaQuery.sizeOf(context).height / 9,
                      width: MediaQuery.sizeOf(context).width / 9,
                    ),
                  ),
                  IconButton(
                    onPressed: () => url(link: "wa.me/+201008234875"),
                    icon: Image(
                      image: const AssetImage('assets/images/wa.png'),
                      height: MediaQuery.sizeOf(context).height / 9,
                      width: MediaQuery.sizeOf(context).width / 9,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      urlMail(mail: "ahmedebrahim1806@gmail.com");
                      url(
                          link:
                              "mail.google.com/mail/u/0/?view=cm&to=ahmedebrahim1806@gmail.com");
                    },
                    icon: Image(
                      image: const AssetImage('assets/images/gm.png'),
                      height: MediaQuery.sizeOf(context).height / 9,
                      width: MediaQuery.sizeOf(context).width / 9,
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        url(link: "linkedin.com/in/ahmed-ebrahim-0298a4294"),
                    icon: Image(
                      image: const AssetImage('assets/images/li.png'),
                      height: MediaQuery.sizeOf(context).height / 9,
                      width: MediaQuery.sizeOf(context).width / 9,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Container(
                    child: txt(
                      context: context,
                      txt: local.by,
                      size: 49,
                      isItalic: true,
                    ),
                  ),
                  Container(
                    child: txt(
                      context: context,
                      txt: local.nono,
                      isBold: true,
                      size: 69,
                      isClr: true,
                      clr: bg.withValues(alpha: 0.7),
                      isItalic: true,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(13.7),
                child: txt(
                  context: context,
                  txt: "-AEKh-",
                  size: 29,
                ),
              ),
              const SizedBox(height: 23),
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
      ),
    );
  }
}

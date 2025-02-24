import 'package:el_nono/models/products_user.dart';
import 'package:el_nono/shared/components/components.dart';
import 'package:el_nono/shared/components/constants.dart';
import 'package:el_nono/shared/ui/layout/layout.dart';
import 'package:el_nono/user/cubit/user_cubit.dart';
import 'package:el_nono/user/cubit/user_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_nono/models/products_admin.dart';
import 'package:intl/intl.dart';
import 'package:el_nono/l10n/app_localizations.dart';

class UserLayout extends StatelessWidget {
  const UserLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var ctrlPass = TextEditingController();
    DateTime now = DateTime.now();
    var date = DateFormat('dd/MM/yyyy - hh:mm').format(now);

    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var local = AppLocalizations.of(context)!;
        var cubit = UserCubit.get(context);

        cubit.ctrlQuant.addListener(() {
          int quantity = int.tryParse(cubit.ctrlQuant.text) ?? 1;
          cubit.calculateTotalPrice(quantity);
        });

        return Scaffold(
          body: Column(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 9,
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
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: btn(
                        fun: () {
                          pgx(
                              context: context,
                              nextPage: const LayoutGeneral());
                          cubit.btnNew ? cubit.chgNew() : null;
                        },
                        isTxt: true,
                        text: local.home,
                        wd: 130,
                        clr: Colors.indigo,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 18),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: SingleChildScrollView(
                                child: Form(
                                  key: formkey,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: txt(
                                                context: context,
                                                txt: local.product_name_,
                                                isBold: true,
                                              ),
                                            ),
                                            Expanded(
                                              child: txt(
                                                context: context,
                                                txt: cubit.ctrlName,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: txt(
                                                context: context,
                                                txt: local.quantity,
                                                isBold: true,
                                              ),
                                            ),
                                            Expanded(
                                              child: tff(
                                                ctrl: cubit.ctrlQuant,
                                                type: TextInputType.number,
                                                isPfx: false,
                                                isTxt: false,
                                                isNum: true,
                                                brdr: 7,
                                                isHnt: true,
                                                hint: '1',
                                                nbl: cubit.btnAdd,
                                                vld: (val) {
                                                  if (val!.isEmpty) {
                                                    cubit.ctrlQuant.text = '1';
                                                    return null;
                                                  }
                                                  if (int.parse(val) >
                                                      cubit.selectedRowQuant!) {
                                                    return local.more_quantity;
                                                  }
                                                  if (int.parse(val) < 1) {
                                                    return local.invalid_quantity;
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 16,
                                                right: 8,
                                                top: 8,
                                                bottom: 8,
                                              ),
                                              child: txt(
                                                context: context,
                                                txt: local.total_price_,
                                                isBold: true,
                                              ),
                                            ),
                                            Expanded(
                                              child: txt(
                                                context: context,
                                                txt: cubit.calc != 0.0 ||
                                                        cubit.calc != null
                                                    ? cubit.ctrlTotal
                                                    : "",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: txt(
                                                context: context,
                                                txt: local.note,
                                                isBold: true,
                                              ),
                                            ),
                                            Expanded(
                                              child: tff(
                                                ctrl: cubit.ctrlNote,
                                                type: TextInputType.text,
                                                isPfx: false,
                                                isTxt: false,
                                                ln: null,
                                                nbl: cubit.btnAdd,
                                                brdr: 7,
                                                isHnt: true,
                                                hint: local.no_note,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Divider(),
                            ),
                            Table(
                              border: const TableBorder.symmetric(
                                inside: BorderSide(),
                              ),
                              columnWidths: {
                                0: FixedColumnWidth(
                                    MediaQuery.sizeOf(context).width / 23),
                                1: FixedColumnWidth(
                                    MediaQuery.sizeOf(context).width / 7),
                                2: FixedColumnWidth(
                                    MediaQuery.sizeOf(context).width / 18),
                                3: FixedColumnWidth(
                                    MediaQuery.sizeOf(context).width / 18),
                                4: FixedColumnWidth(
                                    MediaQuery.sizeOf(context).width / 7),
                                5: FixedColumnWidth(
                                    MediaQuery.sizeOf(context).width / 23),
                              },
                              children:  [
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        local.num,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        local.product_name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        local.quantity,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        local.price,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        local.description,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        local.status,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Expanded(
                              flex: 2,
                              child: SingleChildScrollView(
                                child: Table(
                                  border: TableBorder.all(),
                                  columnWidths: {
                                    0: FixedColumnWidth(
                                        MediaQuery.sizeOf(context).width / 23),
                                    1: FixedColumnWidth(
                                        MediaQuery.sizeOf(context).width / 7),
                                    2: FixedColumnWidth(
                                        MediaQuery.sizeOf(context).width / 18),
                                    3: FixedColumnWidth(
                                        MediaQuery.sizeOf(context).width / 18),
                                    4: FixedColumnWidth(
                                        MediaQuery.sizeOf(context).width / 7),
                                    5: FixedColumnWidth(
                                        MediaQuery.sizeOf(context).width / 23),
                                  },
                                  children: [
                                    ...List.generate(
                                      listOfNewProducts.length,
                                      (index) {
                                        AdminProduct model =
                                            listOfNewProducts[index];
                                        bool isSelected =
                                            cubit.selectedRowIndex == index;
                                        return TableRow(
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? Colors.blue.withValues(alpha: 0.3)
                                                : Colors.white,
                                          ),
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                model.quantity > 0
                                                    ? cubit.selectRow(
                                                        index: index,
                                                        id: model.id!,
                                                        name: model.name,
                                                        price: "${model.price}",
                                                        quant: model.quantity,
                                                      )
                                                    : null;
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text("${index + 1}."),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                model.quantity > 0
                                                    ? cubit.selectRow(
                                                        index: index,
                                                        id: model.id!,
                                                        name: model.name,
                                                        price: "${model.price}",
                                                        quant: model.quantity,
                                                      )
                                                    : null;
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(model.name),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                model.quantity > 0
                                                    ? cubit.selectRow(
                                                        index: index,
                                                        id: model.id!,
                                                        name: model.name,
                                                        price: "${model.price}",
                                                        quant: model.quantity,
                                                      )
                                                    : null;
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child:
                                                    Text("${model.quantity}"),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                model.quantity > 0
                                                    ? cubit.selectRow(
                                                        index: index,
                                                        id: model.id!,
                                                        name: model.name,
                                                        price: "${model.price}",
                                                        quant: model.quantity,
                                                      )
                                                    : null;
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text("${model.price}"),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                model.quantity > 0
                                                    ? cubit.selectRow(
                                                        index: index,
                                                        id: model.id!,
                                                        name: model.name,
                                                        price: "${model.price}",
                                                        quant: model.quantity,
                                                      )
                                                    : null;
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(model.desc),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                model.quantity > 0
                                                    ? cubit.selectRow(
                                                        index: index,
                                                        id: model.id!,
                                                        name: model.name,
                                                        price: "${model.price}",
                                                        quant: model.quantity,
                                                      )
                                                    : null;
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      model.quantity == 0
                                                          ? Colors.red
                                                          : model.quantity < 4
                                                              ? Colors.yellow
                                                              : Colors.green,
                                                  radius: 9,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 9.4),
                      child: Column(
                        children: [
                          Table(
                            border: const TableBorder.symmetric(
                              inside: BorderSide(),
                            ),
                            columnWidths: {
                              0: FixedColumnWidth(
                                  MediaQuery.sizeOf(context).width / 23),
                              1: FixedColumnWidth(
                                  MediaQuery.sizeOf(context).width / 7),
                              2: FixedColumnWidth(
                                  MediaQuery.sizeOf(context).width / 18),
                              3: FixedColumnWidth(
                                  MediaQuery.sizeOf(context).width / 18),
                              4: FixedColumnWidth(
                                  MediaQuery.sizeOf(context).width / 9),
                              5: FixedColumnWidth(
                                  MediaQuery.sizeOf(context).width / 13),
                            },
                            children: [
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      local.num,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      local.product_name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      local.quantity,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      local.price,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      local.date,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      local.note,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Table(
                                border: TableBorder.all(),
                                columnWidths: {
                                  0: FixedColumnWidth(
                                      MediaQuery.sizeOf(context).width / 23),
                                  1: FixedColumnWidth(
                                      MediaQuery.sizeOf(context).width / 7),
                                  2: FixedColumnWidth(
                                      MediaQuery.sizeOf(context).width / 18),
                                  3: FixedColumnWidth(
                                      MediaQuery.sizeOf(context).width / 18),
                                  4: FixedColumnWidth(
                                      MediaQuery.sizeOf(context).width / 9),
                                  5: FixedColumnWidth(
                                      MediaQuery.sizeOf(context).width / 13),
                                },
                                children: [
                                  ...List.generate(
                                    cubit.listOfProducts.length,
                                    (index) {
                                      UserProduct model =
                                          cubit.listOfProducts[index];
                                      return TableRow(
                                        decoration: const BoxDecoration(),
                                        children: [
                                          GestureDetector(
                                            onDoubleTap: () {
                                              cubit.chgDel();
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text("${index + 1}."),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(model.name),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("${model.quantity}"),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("${model.total}"),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(model.date),
                                          ),
                                          cubit.btnDel
                                              ? Row(
                                                  children: [
                                                    Expanded(
                                                      child: IconButton(
                                                        onPressed: () {
                                                          cubit
                                                              .deleteProduct(
                                                                  id: model.id!)
                                                              .then((value) =>
                                                                  cubit
                                                                      .chgDel());
                                                        },
                                                        icon: const Icon(
                                                          Icons
                                                              .delete_forever_outlined,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 3),
                                                    Expanded(
                                                      child: IconButton(
                                                        onPressed: () {
                                                          cubit
                                                              .restoreProduct(
                                                                id: model.id!,
                                                                pID: model.pID!,
                                                                quant: model
                                                                    .quantity,
                                                              )
                                                              .then((value) =>
                                                                  cubit
                                                                      .chgDel());
                                                        },
                                                        icon: const Icon(
                                                          Icons
                                                              .restore_outlined,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 3),
                                                    Expanded(
                                                      child: IconButton(
                                                        onPressed: () {
                                                          cubit.chgDel();
                                                        },
                                                        icon: const Icon(
                                                          Icons.cancel_outlined,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(model.note),
                                                ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Table(
                            border: TableBorder.all(),
                            columnWidths: {
                              0: FixedColumnWidth((MediaQuery.sizeOf(context)
                                              .width /
                                          23 +
                                      MediaQuery.sizeOf(context).width / 7 +
                                      MediaQuery.sizeOf(context).width / 18 +
                                      MediaQuery.sizeOf(context).width / 18 +
                                      MediaQuery.sizeOf(context).width / 9 +
                                      MediaQuery.sizeOf(context).width / 13) /
                                  3),
                              1: FixedColumnWidth((MediaQuery.sizeOf(context)
                                              .width /
                                          23 +
                                      MediaQuery.sizeOf(context).width / 7 +
                                      MediaQuery.sizeOf(context).width / 18 +
                                      MediaQuery.sizeOf(context).width / 18 +
                                      MediaQuery.sizeOf(context).width / 9 +
                                      MediaQuery.sizeOf(context).width / 13) *
                                  (2 / 3)),
                            },
                            children: [
                              TableRow(
                                children: [
                                   Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      local.total_price,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      cubit.tp.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          cubit.btnNew
                              ? Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(13),
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: tff(
                                        text: local.admin_password,
                                        icon: Icons.password_outlined,
                                        ctrl: ctrlPass,
                                        pss: true,
                                        type: TextInputType.visiblePassword,
                                        vld: (val) {
                                          if (val!.isEmpty) {
                                            return local.enter_admin_password;
                                          }
                                          return null;
                                        },
                                        smt: (val) {
                                          if (formkey.currentState!
                                              .validate()) {
                                            if (ctrlPass.text == passData) {
                                              cubit
                                                  .dropProducts()
                                                  .then((value) {
                                                cubit.chgNew();
                                                ctrlPass.clear();
                                              });
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        if (formkey.currentState!.validate()) {
                                          if (ctrlPass.text == passData) {
                                            cubit.dropProducts().then((value) {
                                              cubit.chgNew();
                                              ctrlPass.clear();
                                            });
                                          }
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.done_outline,
                                        color: bg,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        cubit.chgNew();
                                      },
                                      icon: const Icon(
                                        Icons.cancel_outlined,
                                        color: bg,
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: btn(
                                        fun: () {
                                          if (formkey.currentState!
                                              .validate()) {
                                            cubit
                                                .insertProducts(
                                              pID: cubit.selectedRowID!,
                                              name: cubit.ctrlName,
                                              quantity: int.parse(
                                                  cubit.ctrlQuant.text),
                                              total:
                                                  double.parse(cubit.ctrlTotal),
                                              note:
                                                  cubit.ctrlNote.text.isEmpty ||
                                                          cubit.ctrlNote.text
                                                              .contains(' ')
                                                      ? local.no_note
                                                      : cubit.ctrlNote.text,
                                              date: date.toString(),
                                            )
                                                .then((value) {
                                              cubit
                                                  .updateNewProduct(
                                                quant: cubit.selectedRowQuant! -
                                                    int.parse(
                                                        cubit.ctrlQuant.text),
                                                id: cubit.selectedRowID!,
                                              )
                                                  .then((value) {
                                                cubit.deSelectRow();
                                              });
                                            });
                                          }
                                        },
                                        isTxt: true,
                                        sz: 20,
                                        text: local.add_product,
                                        clr: bg,
                                        up: false,
                                        ht: MediaQuery.of(context).size.height /
                                            13,
                                        wd: MediaQuery.of(context).size.width /
                                            6.49,
                                        isEnable: isActive
                                            ? cubit.btnAdd
                                            : cubit.listOfProducts.length < 13
                                                ? cubit.btnAdd
                                                : false,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 18,
                                      ),
                                      child: btn(
                                        fun: () {
                                          cubit.deSelectRow();
                                        },
                                        isTxt: true,
                                        text: local.reset,
                                        sz: 20,
                                        clr: bg.withValues(alpha: 0.8),
                                        up: false,
                                        ht: MediaQuery.of(context).size.height /
                                            13,
                                        wd: MediaQuery.of(context).size.width /
                                            6.49,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 18,
                                      ),
                                      child: btn(
                                        fun: () {
                                          cubit.deSelectRow();
                                          cubit.chgNew();
                                        },
                                        isTxt: true,
                                        text: local.new_,
                                        sz: 20,
                                        clr: Colors.red.withValues(alpha: 0.8),
                                        up: false,
                                        ht: MediaQuery.of(context).size.height /
                                            13,
                                        wd: MediaQuery.of(context).size.width /
                                            6.49,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

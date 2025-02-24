import 'package:el_nono/admin/cubit/admin_cubit.dart';
import 'package:el_nono/admin/cubit/admin_states.dart';
import 'package:el_nono/models/products_admin.dart';
import 'package:el_nono/shared/components/components.dart';
import 'package:el_nono/shared/components/constants.dart';
import 'package:el_nono/shared/ui/layout/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:el_nono/l10n/app_localizations.dart';

class AdminLayout extends StatelessWidget {
  const AdminLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    DateTime now = DateTime.now();
    var date = DateFormat('dd/MM/yyyy - hh:mm').format(now);

    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AdminCubit.get(context);
        var local = AppLocalizations.of(context)!;

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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: txt(
                                context: context,
                                txt: local.product_details,
                                isBold: true,
                                isClr: true,
                                clr: bg,
                                size: 23,
                              ),
                            ),
                            Expanded(
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
                                                txt: local.product_name,
                                                isBold: true,
                                              ),
                                            ),
                                            Expanded(
                                              child: tff(
                                                ctrl: cubit.ctrlName,
                                                type: TextInputType.name,
                                                isPfx: false,
                                                isTxt: false,
                                                ln: null,
                                                brdr: 7,
                                                vld: (val) {
                                                  if (val!.isEmpty) {
                                                    return local.enter_product_name;
                                                  }
                                                  return null;
                                                },
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
                                                txt: local.product_quantity,
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
                                                vld: (val) {
                                                  if (val!.isEmpty) {
                                                    return local.enter_product_quantity;
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
                                                txt: local.product_price,
                                                isBold: true,
                                              ),
                                            ),
                                            Expanded(
                                              child: tff(
                                                ctrl: cubit.ctrlPrice,
                                                isPfx: false,
                                                isTxt: false,
                                                isNum: true,
                                                isDouble: true,
                                                brdr: 7,
                                                vld: (val) {
                                                  if (val!.isEmpty) {
                                                    return local.enter_product_price;
                                                  }
                                                  return null;
                                                },
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
                                                txt: local.product_description,
                                                isBold: true,
                                              ),
                                            ),
                                            Expanded(
                                              child: tff(
                                                ctrl: cubit.ctrlDesc,
                                                type: TextInputType.text,
                                                isPfx: false,
                                                isTxt: false,
                                                ln: null,
                                                brdr: 7,
                                                isHnt: true,
                                                hint: local.no_description,
                                                vld: (val) {
                                                  if (val!.isEmpty) {
                                                    cubit.ctrlDesc.text =
                                                        local.no_description;
                                                    return null;
                                                  }
                                                  return null;
                                                },
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
                            // const Spacer(),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: btn(
                                      fun: () {
                                        if (formkey.currentState!.validate()) {
                                          cubit
                                              .insertNewProducts(
                                            name: cubit.ctrlName.text,
                                            quantity: cubit.ctrlQuant.text,
                                            price: cubit.ctrlPrice.text,
                                            desc: cubit.ctrlDesc.text,
                                            date: date,
                                          )
                                              .then((value) {
                                            cubit.ctrlName.clear();
                                            cubit.ctrlQuant.clear();
                                            cubit.ctrlPrice.clear();
                                            cubit.ctrlDesc.clear();
                                          });
                                        }
                                      },
                                      isTxt: true,
                                      sz: 20,
                                      text: local.add_product,
                                      clr: bg,
                                      up: false,
                                      ht: 137,
                                      isEnable: isActive
                                          ? cubit.btnAdd
                                          : listOfNewProducts.length < 7
                                              ? cubit.btnAdd
                                              : false,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 18,
                                    ),
                                    child: btn(
                                      fun: () {
                                        cubit.ctrlName.clear();
                                        cubit.ctrlQuant.clear();
                                        cubit.ctrlPrice.clear();
                                        cubit.ctrlDesc.clear();
                                        cubit.deSelectRow(
                                            null, null, null, null, null, null);
                                      },
                                      isTxt: true,
                                      text: local.reset,
                                      sz: 20,
                                      clr: bg.withValues(alpha: 0.8),
                                      up: false,
                                      ht: 137,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 18,
                                    ),
                                    child: btn(
                                      fun: () {
                                        cubit.uptadeNewProduct(
                                          name: cubit.ctrlName.text,
                                          quant: cubit.ctrlQuant.text,
                                          price: cubit.ctrlPrice.text,
                                          desc: cubit.ctrlDesc.text,
                                          id: cubit.selectedRowID!,
                                          date: date,
                                        );
                                      },
                                      isTxt: true,
                                      text: local.update,
                                      sz: 20,
                                      clr: bg.withValues(alpha: 0.8),
                                      up: false,
                                      ht: 137,
                                      isEnable: cubit.btnEdit,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: btn(
                                      fun: () {
                                        cubit
                                            .deleteNewProduct(
                                                id: cubit.selectedRowID!)
                                            .then((value) => cubit.deSelectRow(
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null));
                                      },
                                      isTxt: true,
                                      text: local.delete_product,
                                      sz: 20,
                                      clr: Colors.redAccent,
                                      up: false,
                                      ht: 137,
                                      isEnable: cubit.btnDel,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                                  MediaQuery.sizeOf(context).width / 10),
                              5: FixedColumnWidth(
                                  MediaQuery.sizeOf(context).width / 9),
                              6: FixedColumnWidth(
                                  MediaQuery.sizeOf(context).width / 24),
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
                                      local.date,
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
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
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
                                        MediaQuery.sizeOf(context).width / 10),
                                    5: FixedColumnWidth(
                                        MediaQuery.sizeOf(context).width / 9),
                                    6: FixedColumnWidth(
                                        MediaQuery.sizeOf(context).width / 24),
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
                                                cubit.selectRow(
                                                  index: index,
                                                  id: model.id!,
                                                  name: model.name,
                                                  quant: "${model.quantity}",
                                                  price: "${model.price}",
                                                  desc: model.desc,
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text("${index + 1}"),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                cubit.selectRow(
                                                  index: index,
                                                  id: model.id!,
                                                  name: model.name,
                                                  quant: "${model.quantity}",
                                                  price: "${model.price}",
                                                  desc: model.desc,
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(model.name),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                cubit.selectRow(
                                                  index: index,
                                                  id: model.id!,
                                                  name: model.name,
                                                  quant: "${model.quantity}",
                                                  price: "${model.price}",
                                                  desc: model.desc,
                                                );
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
                                                cubit.selectRow(
                                                  index: index,
                                                  id: model.id!,
                                                  name: model.name,
                                                  quant: "${model.quantity}",
                                                  price: "${model.price}",
                                                  desc: model.desc,
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text("${model.price}"),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                cubit.selectRow(
                                                  index: index,
                                                  id: model.id!,
                                                  name: model.name,
                                                  quant: "${model.quantity}",
                                                  price: "${model.price}",
                                                  desc: model.desc,
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(model.date),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                cubit.selectRow(
                                                  index: index,
                                                  id: model.id!,
                                                  name: model.name,
                                                  quant: "${model.quantity}",
                                                  price: "${model.price}",
                                                  desc: model.desc,
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(model.desc),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                cubit.selectRow(
                                                  index: index,
                                                  id: model.id!,
                                                  name: model.name,
                                                  quant: "${model.quantity}",
                                                  price: "${model.price}",
                                                  desc: model.desc,
                                                );
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

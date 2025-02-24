// ignore_for_file: avoid_print

import 'package:el_nono/admin/cubit/admin_states.dart';
import 'package:el_nono/shared/components/constants.dart';
import 'package:el_nono/models/products_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminInitState());

  static AdminCubit get(context) => BlocProvider.of(context);

  var ctrlName = TextEditingController();
  var ctrlQuant = TextEditingController();
  var ctrlPrice = TextEditingController();
  var ctrlDesc = TextEditingController();
  int? selectedRowIndex;
  int? selectedRowID;
  bool btnAdd = true;
  bool btnEdit = false;
  bool btnDel = false;

  void deSelectRow(
    int? index,
    String? name,
    String? quant,
    String? price,
    String? desc,
    int? id,
  ) {
    //De
    ctrlName.clear();
    ctrlQuant.clear();
    ctrlPrice.clear();
    ctrlDesc.clear();
    btnAdd = true;
    btnEdit = false;
    btnDel = false;
    selectedRowID = null;
    selectedRowIndex = null;
    emit(AdminRowSelectedState());
  }

  void selectRow({
    required int index,
    required String name,
    required String quant,
    required String price,
    required String desc,
    required int id,
  }) {
    if (selectedRowIndex == index) {
      //De
      deSelectRow(
        index,
        name,
        quant,
        price,
        desc,
        id,
      );
    } else {
      //Se
      btnAdd = false;
      btnEdit = true;
      btnDel = true;
      ctrlName.text = name;
      ctrlQuant.text = quant;
      ctrlPrice.text = price;
      ctrlDesc.text = desc;
      selectedRowID = id;
      selectedRowIndex = index;
    }
    emit(AdminRowSelectedState());
  }

  Future<void> insertNewProducts({
    required String name,
    required String quantity,
    required String price,
    required String date,
    required String desc,
  }) async {
    await db.transaction(
      (txn) async {
        // Insert the product into the table
        int id = await txn.rawInsert(
          'INSERT INTO NoNoAdmin(name, quantity, price, desc, date) VALUES(?, ?, ?, ?, ?)',
          [name, quantity, price, desc, date],
        );

        print("Products Inserted Succ, ID: $id");

        // Optionally: Do something with the ID, like updating a UI state or a state variable
        emit(AdminInsertProductsState(
            id)); // Assuming you modify your state to accept an ID
        getNewProducts(db);
      },
    ).catchError(
      (error) {
        print("Error inserting: ${error.toString()}");
      },
    );
  }

  void getNewProducts(db) {
    listOfNewProducts = [];

    db.rawQuery('SELECT * FROM NoNoAdmin').then((value) {
      emit(AdminLoadingGetProductsState());

      value.forEach((element) {
        listOfNewProducts.add(AdminProduct.fromMap(element));
      });

      print(value);

      emit(AdminGetProductsSuccState());
    }).catchError((error) {
      // In case of any errors, print the error
      print('Error retrieving data from the database: $error');
      emit(AdminGetProductsErrState(error.toString()));
    });
  }

  Future<void> deleteNewProduct({required int id}) async {
    await db.rawDelete(
      'DELETE FROM NoNoAdmin WHERE id = ?',
      [id],
    ).then((value) {
      getNewProducts(db);
      emit(AdminDeleteDBState());
    });
  }

  void uptadeNewProduct({
    required String name,
    required String quant,
    required String price,
    required String date,
    required String desc,
    required int id,
  }) async {
    db.rawUpdate(
        'UPDATE NoNoAdmin SET name = ?, quantity = ?, price = ?, date = ?, desc = ? WHERE id = ?',
        [
          name,
          quant,
          price,
          date,
          desc,
          '$id',
        ]).then((value) {
      emit(AdminUptadeDBState());
      getNewProducts(db);
    });
  }
}

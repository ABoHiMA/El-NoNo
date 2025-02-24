// ignore_for_file: avoid_print

import 'package:el_nono/models/products_admin.dart';
import 'package:el_nono/models/products_user.dart';
import 'package:el_nono/shared/components/constants.dart';
import 'package:el_nono/user/cubit/user_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserInitState());

  static UserCubit get(context) => BlocProvider.of(context);

  var ctrlQuant = TextEditingController();
  var ctrlNote = TextEditingController();
  String ctrlDate = '';
  String ctrlName = '';
  String ctrlTotal = '';
  double tp = 0.0;
  double? pPrice;
  double? calc;
  int? selectedRowIndex;
  int? selectedRowID;
  int? selectedRowQuant;
  bool btnAdd = false;
  bool btnDel = false;
  bool btnNew = false;
  List<UserProduct> listOfProducts = [];

  void chgDel() {
    btnDel = !btnDel;
    emit(UserRowSelectedState());
  }

  void chgNew() {
    btnNew = !btnNew;
    emit(UserRowSelectedState());
  }

  void deSelectRow() {
    //De
    ctrlName = '';
    ctrlTotal = '';
    btnAdd = false;
    btnNew = false;
    btnDel = false;
    pPrice = null;
    selectedRowID = null;
    selectedRowQuant = null;
    selectedRowIndex = null;
    ctrlQuant.clear();
    ctrlNote.clear();
    emit(UserRowSelectedState());
  }

  void selectRow({
    required int index,
    required String name,
    required String price,
    required int id,
    required int quant,
  }) {
    if (selectedRowIndex == index) {
      //De
      deSelectRow();
    } else {
      //Se
      btnAdd = true;
      btnNew = false;
      btnDel = false;
      ctrlQuant.clear();
      ctrlNote.clear();
      ctrlName = name;
      ctrlTotal = price;
      pPrice = double.parse(price);
      selectedRowID = id;
      selectedRowQuant = quant;
      selectedRowIndex = index;
    }
    emit(UserRowSelectedState());
  }

  void calculateTotalPrice(int quantity) {
    if (ctrlQuant.text.isNotEmpty) {
      calc = pPrice != null ? quantity * pPrice! : 0.0;
      ctrlTotal = calc.toString();
    } else {
      ctrlTotal = pPrice == null ? '' : pPrice.toString();
    }

    emit(UserProductStateUpdated());
  }

  Future<void> insertProducts({
    required int pID,
    required String name,
    required int quantity,
    required double total,
    required String note,
    required String date,
  }) async {
    await db.transaction(
      (txn) async {
        int id = await txn.rawInsert(
          'INSERT INTO NoNoUser(pID, name, quantity, total, note, date) VALUES(?, ?, ?, ?, ?, ?)',
          [pID, name, quantity, total, note, date],
        );

        print("Products Inserted Succ, ID: $id");

        emit(UserInsertProductsState(id));
        getProducts(db);
      },
    ).catchError(
      (error) {
        print("Error inserting: ${error.toString()}");
      },
    );
  }

  void getProducts(db) {
    listOfProducts = [];

    db.rawQuery('SELECT * FROM NoNoUser').then((value) {
      emit(UserLoadingGetProductsState());

      value.forEach((element) {
        listOfProducts.add(UserProduct.fromMap(element));
        // ctrlDate = element['date'];
      });

      print(value);

      getTotal();
      print(">>>>>>>>>>>>>>>>> $ctrlDate");

      emit(UserGetProductsSuccState());
    }).catchError((error) {
      print('Error retrieving data from the database NoNoUser: $error');
      emit(UserGetProductsErrState(error.toString()));
    });
  }

  void getNewProducts(db) {
    listOfNewProducts = [];

    db.rawQuery('SELECT * FROM NoNoAdmin').then((value) {
      emit(UserLoadingGetProductsState());

      value.forEach((element) {
        listOfNewProducts.add(AdminProduct.fromMap(element));
      });

      print(value);
      emit(UserGetProductsSuccState());
    }).catchError((error) {
      print('Error retrieving data from the database: $error');
      emit(UserGetProductsErrState(error.toString()));
    });
  }

  Future<void> updateNewProduct({
    required int quant,
    required int id,
  }) async {
    db.rawUpdate('UPDATE NoNoAdmin SET quantity = ? WHERE id = ?', [
      quant,
      '$id',
    ]).then((value) {
      emit(UserUptadeDBState());
      getNewProducts(db);
    });
  }

  void getTotal() async {
    // Query to sum the amount
    var result = await db.rawQuery('SELECT SUM(total) as total FROM NoNoUser');

    // Retrieve the total sum from the query result
    tp = result.first['total'] != null ? result.first['total'] as double : 0.0;

    print("RESULTS $tp");

    emit(UserUptadeDBState());
  }

  Future<void> deleteProduct({required int id}) async {
    await db.rawDelete(
      'DELETE FROM NoNoUser WHERE id = ?',
      [id],
    ).then((value) {
      print("object");
      getProducts(db);
      emit(UserUptadeDBState());
    });
  }

  Future<void> restoreProduct({
    required int id,
    required int pID,
    required int quant,
  }) async {
    await db.rawUpdate(
      'UPDATE NoNoAdmin SET quantity = quantity + ? WHERE id = ?',
      [quant, pID],
    ).then((value) async {
      getNewProducts(db);
      await db.rawDelete(
        'DELETE FROM NoNoUser WHERE id = ?',
        [id],
      ).then((value) {
        print("object");
        getProducts(db);
      });
    });
    emit(UserUptadeDBState());
  }

  Future<void> dropProducts() async {
    // emit(AppLoadingDataState());
    await db.delete('NoNoUser').then((value) => getProducts(db));

    emit(UserUptadeDBState());
  }
}

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/services.dart';
import "package:kitchen_calculator/pages/product.dart" as data;
import 'package:kitchen_calculator/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  static const String route = '/';
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String route = '/';
  List<String> selectProd = data.nameProduct;
  List<String> units = data.units;
  String product = '';
  String unitIn = '';
  String unitOut = '';
  double quantity = 0.0;

  String calculate() {
    if (product == '' ||
        unitIn == '' ||
        unitOut == '' ||
        quantity == 0.0 ||
        quantity == 0) {
      return 'Введено не усі дані';
    } else {
      String nameProduct = product;
      Map<String, dynamic> getProduct = data.products[nameProduct];
      double density = getProduct["density"];

      String nameUnitIn = unitIn;
      Map<String, dynamic> getUnitIn = data.measure[nameUnitIn];
      double factorUnitIn = getUnitIn["factor"];
      bool volUnitIn = getUnitIn["vol"];

      String nameUnitOut = unitOut;
      Map<String, dynamic> getUnitOut = data.measure[nameUnitOut];
      double factorUnitOut = getUnitOut["factor"];
      bool volUnitOut = getUnitOut["vol"];

      String label = getUnitOut["label"];
      String from2to4 = getUnitOut["from2to4"];
      String from5to0 = getUnitOut["from5to0"];
      String fraction = getUnitOut["fraction"];

      double result = 0;
      if (volUnitIn && !volUnitOut) {
        result = quantity * density * (factorUnitIn / factorUnitOut);
      } else if (!volUnitIn && volUnitOut) {
        result = (quantity / density) * (factorUnitIn / factorUnitOut);
      } else {
        result = quantity * (factorUnitIn / factorUnitOut);
      }
      if (result == 1) {
        return '$result $label';
      } else if (result == 2 || result == 3 || result == 4) {
        return '$result $from2to4';
      } else if (result == 5 ||
          result == 6 ||
          result == 7 ||
          result == 8 ||
          result == 9 ||
          result == 10 ||
          result == 11 ||
          result == 12 ||
          result == 13 ||
          result == 14 ||
          result == 15 ||
          result == 16 ||
          result == 17 ||
          result == 18 ||
          result == 19 ||
          result == 20) {
        return '$result $from5to0';
      } else {
        return '${result.toStringAsFixed(1)} $fraction';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("asset/kitchen.jpg"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        drawer: buildDrawer(context, route),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  DropdownSearch<String>(
                      items: selectProd,
                      popupProps: const PopupProps.menu(
                        constraints: BoxConstraints(maxHeight: 450),
                        listViewProps: ListViewProps(
                          itemExtent: 35.0,
                        ),
                        showSearchBox: true,
                        showSelectedItems: true,
                        menuProps: MenuProps(
                          backgroundColor: Color.fromARGB(255, 243, 232, 228),
                          shadowColor: Colors.brown,
                        ),
                        favoriteItemProps: FavoriteItemProps(
                            favoriteItemsAlignment: MainAxisAlignment.center),
                      ),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.brown, width: 2.0)),
                          labelText: 'Оберіть продукт',
                          hintText: 'Виберіть, або почніть вводити...',
                          labelStyle: TextStyle(
                              color: Colors.brown, fontWeight: FontWeight.w500),
                          hintStyle: TextStyle(color: Colors.brown),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      onChanged: (vvv) {
                        setState(() {
                          product = vvv.toString();
                        });
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                      ],
                      initialValue: "",
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.brown, width: 2.0)),
                        labelText: 'Кількість',
                        labelStyle: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.w500,
                        ),
                        contentPadding: EdgeInsets.only(
                            left: 10.0, bottom: 20.0, top: 20.0, right: 10.0),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (rrr) {
                        if (rrr == '') {
                          setState(() {
                            quantity = 0;
                          });
                        } else {
                          setState(() {
                            quantity = double.parse(rrr);
                          });
                        }
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  DropdownSearch<String>(
                      items: units,
                      popupProps: const PopupProps.menu(
                        constraints: BoxConstraints(maxHeight: 450),
                        listViewProps: ListViewProps(
                          itemExtent: 35.0,
                        ),
                        showSearchBox: true,
                        showSelectedItems: true,
                        menuProps: MenuProps(
                          backgroundColor: Color.fromARGB(255, 243, 232, 228),
                          shadowColor: Colors.brown,
                        ),
                        favoriteItemProps: FavoriteItemProps(
                            favoriteItemsAlignment: MainAxisAlignment.center),
                      ),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.brown, width: 2.0)),
                          labelText: 'Одиниці виміру',
                          hintText: 'Виберіть, або почніть вводити...',
                          labelStyle: TextStyle(
                              color: Colors.brown, fontWeight: FontWeight.w500),
                          hintStyle: TextStyle(color: Colors.brown),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      onChanged: (vvv) {
                        setState(() {
                          unitIn = vvv.toString();
                        });
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  DropdownSearch<String>(
                      items: units,
                      popupProps: const PopupProps.menu(
                        constraints: BoxConstraints(maxHeight: 450),
                        listViewProps: ListViewProps(
                          itemExtent: 35.0,
                        ),
                        showSearchBox: true,
                        showSelectedItems: true,
                        menuProps: MenuProps(
                          backgroundColor: Color.fromARGB(255, 243, 232, 228),
                          shadowColor: Colors.brown,
                        ),
                        favoriteItemProps: FavoriteItemProps(
                            favoriteItemsAlignment: MainAxisAlignment.center),
                      ),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.brown, width: 2.0)),
                          labelText: 'До чого привести?',
                          hintText: 'Виберіть, або почніть вводити...',
                          labelStyle: TextStyle(
                              color: Colors.brown, fontWeight: FontWeight.w500),
                          hintStyle: TextStyle(color: Colors.brown),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      onChanged: (vvv) {
                        setState(() {
                          unitOut = vvv.toString();
                        });
                      }),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                      padding: const EdgeInsets.only(
                          left: 10.0, bottom: 20.0, top: 20.0, right: 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.brown,
                            width: 3,
                          )),
                      child: Row(children: [
                        const Icon(
                          Icons.calculate_outlined,
                          color: Colors.brown,
                          size: 30.0,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          calculate(),
                          textScaleFactor: 1.2,
                          style: const TextStyle(
                              color: Colors.brown, fontWeight: FontWeight.w700),
                        ),
                      ])),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(5.0),
          height: 40.0,
          color: Colors.brown,
          child: Column(
            children: const [
              Text(
                'With best wishes, Viktor Krzeminskiy',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Text(
                'krzeminsky@ukr.net',
                style: TextStyle(color: Colors.white, fontSize: 12.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

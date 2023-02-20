import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import "package:kitchen_calculator/pages/strava.dart" as data;
import 'package:kitchen_calculator/widgets/drawer.dart';

class Energy extends StatefulWidget {
  static const String route = 'Energy';
  const Energy({super.key, required this.title});

  final String title;

  @override
  State<Energy> createState() => _EnergyState();
}

class _EnergyState extends State<Energy> {
  List<String> list = [];
  String getStrava = "вода питна";
  String energyOut = '';
  String proteinOut = '';
  String carbohydrateOut = '';
  String fatOut = '';
  String fiberOut = '';

  Map<String, Map<String, String>> getName = data.strava;

  addProducts() {
    getName.forEach((k, v) => list.add(k));
  }

  @override
  void initState() {
    super.initState();
    addProducts();
  }

  String calculate() {
    final valueSrtava = data.strava[getStrava];
    var values = valueSrtava?.values.toList();
    var energy = values?.elementAt(1);
    var protein = values?.elementAt(2);
    var carbohydrate = values?.elementAt(3);
    var fat = values?.elementAt(4);
    var fiber = values?.elementAt(5);

    energyOut = energy.toString();
    proteinOut = protein.toString();
    carbohydrateOut = carbohydrate.toString();
    fatOut = fat.toString();
    fiberOut = fiber.toString();

    return fiber.toString();
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
        drawer: buildDrawer(context, Energy.route),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  DropdownSearch<String>(
                      items: list,
                      popupProps: const PopupProps.menu(
                        constraints: BoxConstraints(maxHeight: 450),
                        // listViewProps: ListViewProps(
                        //   itemExtent: 35.0,
                        // ),
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
                          labelText: 'Оберіть продукт (страву)',
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
                          getStrava = vvv.toString();
                        });
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  Table(
                    columnWidths: const {1: FractionColumnWidth(.25)},
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    // border: TableBorder.all(width: 2.0),
                    children: [
                      TableRow(children: [
                        Container(
                            padding: const EdgeInsets.only(
                                left: 5.0,
                                bottom: 10.0,
                                top: 10.0,
                                right: 10.0),
                            child: const Text("Волокна (г)",
                                textScaleFactor: 0.1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ))),
                        Container(
                            padding: const EdgeInsets.only(
                                left: 0, bottom: 10.0, top: 10.0, right: 10.0),
                            child: Text(
                              calculate(),
                              textScaleFactor: 0.1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            )),
                      ]),
                      TableRow(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 222, 224, 224),
                            border: Border(
                              top: BorderSide(color: Colors.brown),
                              left: BorderSide(color: Colors.brown),
                              right: BorderSide(color: Colors.brown),
                            ),
                          ),
                          children: [
                            Container(
                                padding: const EdgeInsets.only(
                                    left: 15.0,
                                    bottom: 15.0,
                                    top: 15.0,
                                    right: 10.0),
                                child: const Text(
                                  "Енергія (ккал.)",
                                  textScaleFactor: 1.2,
                                  style: TextStyle(
                                    color: Colors.brown,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                            Container(
                                padding: const EdgeInsets.only(
                                    left: 0,
                                    bottom: 10.0,
                                    top: 10.0,
                                    right: 10.0),
                                child: Text(
                                  energyOut,
                                  textScaleFactor: 1.2,
                                  style: const TextStyle(
                                    color: Colors.brown,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ]),
                      TableRow(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 236, 239, 240),
                            border: Border(
                              top: BorderSide(color: Colors.brown),
                              left: BorderSide(color: Colors.brown),
                              right: BorderSide(color: Colors.brown),
                            ),
                          ),
                          children: [
                            Container(
                                padding: const EdgeInsets.only(
                                    left: 15.0,
                                    bottom: 15.0,
                                    top: 15.0,
                                    right: 10.0),
                                child: const Text("Білки (г)",
                                    textScaleFactor: 1.2,
                                    style: TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.w600,
                                    ))),
                            Container(
                                padding: const EdgeInsets.only(
                                    left: 0,
                                    bottom: 10.0,
                                    top: 10.0,
                                    right: 10.0),
                                child: Text(
                                  proteinOut,
                                  textScaleFactor: 1.2,
                                  style: const TextStyle(
                                    color: Colors.brown,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ]),
                      TableRow(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 222, 224, 224),
                            border: Border(
                              top: BorderSide(color: Colors.brown),
                              left: BorderSide(color: Colors.brown),
                              right: BorderSide(color: Colors.brown),
                            ),
                          ),
                          children: [
                            Container(
                                padding: const EdgeInsets.only(
                                    left: 15.0,
                                    bottom: 15.0,
                                    top: 15.0,
                                    right: 10.0),
                                child: const Text("Вуглеводи (г)",
                                    textScaleFactor: 1.2,
                                    style: TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.w600,
                                    ))),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 0,
                                  bottom: 10.0,
                                  top: 10.0,
                                  right: 10.0),
                              child: Text(
                                carbohydrateOut,
                                textScaleFactor: 1.2,
                                style: const TextStyle(
                                  color: Colors.brown,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ]),
                      TableRow(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 236, 239, 240),
                            border: Border(
                              top: BorderSide(color: Colors.brown),
                              left: BorderSide(color: Colors.brown),
                              right: BorderSide(color: Colors.brown),
                            ),
                          ),
                          children: [
                            Container(
                                padding: const EdgeInsets.only(
                                    left: 15.0,
                                    bottom: 15.0,
                                    top: 15.0,
                                    right: 10.0),
                                child: const Text("Жири (г)",
                                    textScaleFactor: 1.2,
                                    style: TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.w600,
                                    ))),
                            Container(
                                padding: const EdgeInsets.only(
                                    left: 0,
                                    bottom: 10.0,
                                    top: 10.0,
                                    right: 10.0),
                                child: Text(
                                  fatOut,
                                  textScaleFactor: 1.2,
                                  style: const TextStyle(
                                    color: Colors.brown,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ]),
                      TableRow(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 222, 224, 224),
                            border: Border.all(width: 1.0, color: Colors.brown),
                          ),
                          children: [
                            Container(
                                padding: const EdgeInsets.only(
                                    left: 15.0,
                                    bottom: 15.0,
                                    top: 15.0,
                                    right: 10.0),
                                child: const Text("Волокна (г)",
                                    textScaleFactor: 1.2,
                                    style: TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.w600,
                                    ))),
                            Container(
                                padding: const EdgeInsets.only(
                                    left: 0,
                                    bottom: 10.0,
                                    top: 10.0,
                                    right: 10.0),
                                child: Text(
                                  fiberOut,
                                  textScaleFactor: 1.2,
                                  style: const TextStyle(
                                    color: Colors.brown,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                          ]),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Icon(
                            Icons.priority_high_rounded,
                            color: Color.fromARGB(255, 134, 10, 2),
                            size: 30.0,
                          ),
                          Flexible(
                            child: Text(
                                textAlign: TextAlign.center,
                                "Значення в таблиці вказані на 100 г продукту",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 134, 10, 2),
                                )),
                          ),
                        ],
                      ),
                    ),
                  )
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

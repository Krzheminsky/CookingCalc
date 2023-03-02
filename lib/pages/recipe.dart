import 'package:flutter/material.dart';
import 'package:kitchen_calculator/widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Recipe extends StatefulWidget {
  static const String route = 'Recipe';
  const Recipe({super.key, required this.title});

  final String title;

  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  String selectedRecipe = '0';
  String getRecipe = 'Страву не вибрано...';
  String getName = '';
  String getComponents = 'Страву не вибрано...';
  String getImage =
      'http://c.files.bbci.co.uk/9017/production/_105278863_gettyimages-855098134.jpg';

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
        drawer: buildDrawer(context, Recipe.route),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('probas').snapshots(),
                builder: ((context, snapshot) {
                  List<String> list = [];

                  if (!snapshot.hasData) {
                    const CircularProgressIndicator();
                  } else {
                    final recipes = snapshot.data?.docs.reversed.toList();

                    for (var recipe in recipes!) {
                      var getName = recipe['name'].toString();

                      list.add(getName);
                    }
                  }
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        DropdownSearch<String>(
                            items: list,
                            popupProps: const PopupProps.menu(
                              constraints: BoxConstraints(maxHeight: 450),
                              showSearchBox: true,
                              showSelectedItems: true,
                              menuProps: MenuProps(
                                backgroundColor:
                                    Color.fromARGB(255, 243, 232, 228),
                                shadowColor: Colors.brown,
                              ),
                              favoriteItemProps: FavoriteItemProps(
                                  favoriteItemsAlignment:
                                      MainAxisAlignment.center),
                            ),
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.brown, width: 2.0)),
                                labelText: 'Оберіть продукт (страву)',
                                hintText: 'Виберіть, або почніть вводити...',
                                labelStyle: TextStyle(
                                    color: Colors.brown,
                                    fontWeight: FontWeight.w500),
                                hintStyle: TextStyle(color: Colors.brown),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                            onChanged: (vvv) async {
                              setState(() {
                                getName = vvv.toString();
                              });

                              await FirebaseFirestore.instance
                                  .collection('probas')
                                  .where("name", isEqualTo: getName)
                                  .get()
                                  .then(
                                    (QuerySnapshot snapshot) => {
                                      // ignore: avoid_function_literals_in_foreach_calls
                                      snapshot.docs.forEach((item) {
                                        setState(() {
                                          selectedRecipe = item.reference.id;
                                        });
                                      }),
                                    },
                                  );
                              var collection = FirebaseFirestore.instance
                                  .collection('probas');
                              var docSnapshot =
                                  await collection.doc(selectedRecipe).get();
                              if (docSnapshot.exists) {
                                Map<String, dynamic>? data = docSnapshot.data();
                                var valueRecipe = data?['recipe'];
                                var valueName = data?['name'];
                                var valueComponents = data?['components'];
                                var valueImage = data?['image'];
                                setState(() {
                                  getRecipe =
                                      valueRecipe.replaceAll("\\n", "\n");
                                  getName = valueName;
                                  getComponents =
                                      valueComponents.replaceAll("\\n", "\n");
                                  getImage = valueImage;
                                });
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        Image.network(
                          getImage,
                          scale: 1.0,
                          height: 140.0,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          getName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1.5
                              ..color = Colors.brown[700]!,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 6,
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 0.0, bottom: 5.0, top: 5.0, right: 0.0),
                            child: ListTile(
                              title: const Text('Інгредієнти:',
                                  style: TextStyle(
                                    color: Colors.brown,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic,
                                  )),
                              subtitle: Text(
                                getComponents,
                                style: const TextStyle(
                                  color: Colors.brown,
                                  fontSize: 12.0,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Card(
                          elevation: 6,
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 0.0, bottom: 5.0, top: 5.0, right: 0.0),
                            child: ListTile(
                              title: const Text('Приготування:',
                                  style: TextStyle(
                                    color: Colors.brown,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  )),
                              subtitle: Text(
                                getRecipe,
                                style: const TextStyle(
                                  color: Colors.brown,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              )
            ],
          ),
        )),
      ),
    );
  }
}

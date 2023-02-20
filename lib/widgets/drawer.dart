import 'package:flutter/material.dart';
import 'package:kitchen_calculator/pages/energy.dart';

Drawer buildDrawer(BuildContext context, String currentRoute) {
  return Drawer(
    backgroundColor: Colors.grey[200],
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(
          height: 80.0,
          // width: 350.0,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.brown,
            ),
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: Center(
              child: Text('Помічник кулінара-аматора',
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Card(
          clipBehavior: Clip.antiAlias,
          elevation: 6,
          child: Container(
            margin: const EdgeInsets.only(
                left: 0.0, bottom: 10.0, top: 10.0, right: 0.0),
            child: ListTile(
              title: const Text('Кухонний калькулятор',
                  style: TextStyle(
                    color: Colors.brown,
                    fontWeight: FontWeight.w500,
                  )),
              subtitle: const Text(
                "Перерахунок мас і об'ємів продуктів",
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 14,
              ),
              dense: true,
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
          ),
        ),
        Card(
          elevation: 6,
          child: Container(
            margin: const EdgeInsets.only(
                left: 0.0, bottom: 10.0, top: 10.0, right: 0.0),
            child: ListTile(
              title: const Text('Таблиця калорійності',
                  style: TextStyle(
                    color: Colors.brown,
                    fontWeight: FontWeight.w500,
                  )),
              subtitle: const Text(
                'Таблиця калорійності продуктів та страв',
                style: TextStyle(fontSize: 10),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 14,
              ),
              dense: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Energy(title: 'Калькулятор калорій');
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

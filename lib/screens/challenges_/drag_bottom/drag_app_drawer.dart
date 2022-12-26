import 'package:flutter/material.dart';

class DragAppDrawer extends StatelessWidget {
  const DragAppDrawer({Key? key, required this.isOpen}) : super(key: key);
  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;
    return Column(
      children: [
        Visibility(
          visible: isOpen,
          child: DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/card_/drawer_back.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            //padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: const [
                  SizedBox(height: 10),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/card_/jb.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Jb Jason',
                    style: TextStyle(
                      fontSize: 15,
                      color: color,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'itisjubayer3point0@gmail.com',
                    style: TextStyle(
                      fontSize: 10,
                      color: color,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // const Divider(thickness: 2, color: Colors.white),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.home, color: color),
                title: const Text('Home', style: TextStyle(color: color)),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.badge, color: color),
                title: const Text('Orders', style: TextStyle(color: color)),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.favorite, color: color),
                title: const Text('Favorites', style: TextStyle(color: color)),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.work_off, color: color),
                title: const Text('WorkOut', style: TextStyle(color: color)),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.update_outlined, color: color),
                title: const Text('Update', style: TextStyle(color: color)),
                onTap: () {},
              ),
              const SizedBox(height: 105),
            ],
          ),
        ),
        const Divider(thickness: 1, color: Colors.white),
        ListTile(
          leading: const Icon(Icons.logout_outlined, color: color),
          title: const Text('Logout', style: TextStyle(color: color)),
          onTap: () => Navigator.pop(context),
        ),
      ],
    );
  }
}

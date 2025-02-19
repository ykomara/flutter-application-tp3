import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RestaurantListScreen extends StatelessWidget {
  const RestaurantListScreen({super.key});

  final List<Map<String, String>> restaurants = const [
    {"name": "Le Petit Bistro", "location": "Paris, France"},
    {"name": "Chez Luigi", "location": "Lyon, France"},
    {"name": "El Toro", "location": "Madrid, Espagne"},
    {"name": "La Pizzeria", "location": "Rome, Italie"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bars & Restaurants'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.go('/'); 
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];

          return Column(
            children: [
              ListTile(
                title: Text(
                  restaurant["name"]!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(restaurant["location"]!),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  final encodedName = Uri.encodeComponent(restaurant["name"]!);
                  final encodedLocation = Uri.encodeComponent(restaurant["location"]!);

                  context.push('/restaurants/details/$encodedName/$encodedLocation');
                },
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}

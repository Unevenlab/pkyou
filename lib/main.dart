import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PKU Food Database',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FoodListScreen(),
    );
  }
}

class FoodListScreen extends StatefulWidget {
  @override
  _FoodListScreenState createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> foodDatabase = [
    {'name': 'Caffè Espresso', 'category': 'Bevande', 'protein': 0.1, 'phe': 0, 'calories': 2},
    {'name': 'Petto di Pollo', 'category': 'Carne', 'protein': 31, 'phe': 1480, 'calories': 165},
    {'name': 'Pasta di Semola', 'category': 'Cereali', 'protein': 12, 'phe': 600, 'calories': 365},
    {'name': 'Spinaci', 'category': 'Verdura', 'protein': 2.9, 'phe': 150, 'calories': 23},
    {'name': 'Riso Bianco', 'category': 'Cereali', 'protein': 7, 'phe': 320, 'calories': 350},
  ];
  List<Map<String, dynamic>> filteredFood = [];

  @override
  void initState() {
    super.initState();
    filteredFood = foodDatabase;
  }

  void filterFood(String query) {
    setState(() {
      filteredFood = foodDatabase
          .where((food) => food['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PKU Food Database'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Cerca alimento',
                border: OutlineInputBorder(),
              ),
              onChanged: filterFood,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredFood.length,
              itemBuilder: (context, index) {
                final food = filteredFood[index];
                return ListTile(
                  title: Text(food['name']),
                  subtitle: Text('Categoria: ${food['category']}'),
                  trailing: Text('${food['phe']} mg PHE'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodDetailScreen(food: food),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FoodDetailScreen extends StatelessWidget {
  final Map<String, dynamic> food;

  FoodDetailScreen({required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(food['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Categoria: ${food['category']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Proteine: ${food['protein']} g', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Fenilalanina: ${food['phe']} mg', style: TextStyle(fontSize: 18, color: Colors.red)),
            SizedBox(height: 10),
            Text('Calorie: ${food['calories']} kcal', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

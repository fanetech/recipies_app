import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipies_app/models/recipie.dart';
import 'package:recipies_app/pages/recipe_page.dart';
import 'package:recipies_app/services/data_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _mealTypeFilter = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RecipBook"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _buildUi(),
      ),
    );
  }

  Widget _buildUi() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          children: [
            _reciepTypeButtons(),
            _recipesList(),
          ],
        ),
      ),
    );
  }

  Widget _reciepTypeButtons() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.05,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  _mealTypeFilter = "snack";
                });
              },
              child: const Text("🥕Snack"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                 setState(() {
                  _mealTypeFilter = "breakfast";
                });
              },
              child: const Text("Breakfast"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                 setState(() {
                  _mealTypeFilter = "lunch";
                });
              },
              child: const Text("Lunch"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                 setState(() {
                  _mealTypeFilter = "dinner";
                });
              },
              child: const Text("Dinner"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _recipesList() {
    return Expanded(
      child: FutureBuilder(
          future: DataService().getRecipies(_mealTypeFilter),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("An error occured"),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  Recipie recipie = snapshot.data![index];
                  return ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return RecipePage(recipe: recipie,);
                      }));
                    },
                    contentPadding: const EdgeInsets.only(top: 20.0),
                    title: Text(recipie.name),
                    subtitle: Text(
                        "${recipie.cuisine}\nDifficulty: ${recipie.difficulty}"),
                    leading: Image.network(recipie.image),
                    trailing: Text(
                      "${recipie.rating.toString()} ⭐️",
                      style: const TextStyle(fontSize: 15),
                    ),
                  );
                });
          }),
    );
  }
}

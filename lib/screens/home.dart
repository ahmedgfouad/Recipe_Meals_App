import 'package:flutter/material.dart';
import 'package:food_recipe/models/recipe_apiResponse.dart';
import 'package:food_recipe/models/results.dart';
import '../api/api.dart';
import 'details.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late RecipeApiResponse response;
  final recipeApi = RecipefoodApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Recipes',
          style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.bold,
              fontSize: 20
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.teal,
                size: 25,
              )),
        ],
      ),
      body: FutureBuilder<RecipeApiResponse>(
          future: recipeApi.getApiData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              response = snapshot.data!;
              // print(snapshot.data!.result.first.title.split(','));
              return GridView.builder(
                physics:  BouncingScrollPhysics(),
                itemCount: response.result.length,
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 20,
                ),
                itemBuilder: (BuildContext context, int index) {
                  Results recipe = response.result[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Details(recipe);
                          },
                        ),
                      );
                    },
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image(
                                  image: NetworkImage(
                                    response.result.elementAt(index).image,
                                  ),
                                )),
                            SizedBox(height: 10,),
                            Text(
                              response.result.elementAt(index).title,
                              style:  TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            if (snapshot.hasError) {
              print(snapshot.error);
              return Container();
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

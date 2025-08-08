import 'package:flutter/material.dart';
import 'package:spacer/Data%20Models/plant_model.dart';
import 'package:spacer/core/UI/Screens/CustomWidget/button_widget.dart';
import 'package:spacer/core/UI/Screens/PlanetScreen/planet_screen.dart';
import 'package:spacer/core/thems/app_colors.dart';
import 'package:spacer/core/thems/app_strings.dart';
import 'package:spacer/core/thems/assets/app_images.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController controller = PageController(initialPage: 0);
  int selectedIndex = 0;


  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      final newIndex = controller.page?.round() ?? 0;
      if (newIndex != selectedIndex) {
        setState(() {
          selectedIndex = newIndex;
        });
      }
    });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        children: [
          Stack(
            children: [
              Image(
                image: AssetImage(AppImages.moonImage),
                width: double.infinity,
                semanticLabel: AppImages.moonImage,
              ),
              Positioned.fill(
                child: Container(
                  decoration:const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, AppColors.black],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       const Text(
                          AppString.exportText,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                             const Text(
                                AppString.homeTextHeadline,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: Planet.planets.length,
              itemBuilder: (context, index) => Image.asset(
                "assets/images/${Planet.planets[index].image}",
                cacheWidth: 700,
                cacheHeight: 700,
                  semanticLabel:"assets/images/${Planet.planets[index].name}",

              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilledButton(
                  onPressed: () {
                    if (selectedIndex >0) {
                      controller.animateToPage(
                        selectedIndex - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: FilledButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: AppColors.red,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.all(18),
                  ),
                  child:const  Icon(Icons.arrow_back),
                ),
                Text(
                  Planet.planets[selectedIndex].name,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                FilledButton(
                  onPressed: () {
                    if(selectedIndex<Planet.planets.length-1){
                    controller.animateToPage(
                      selectedIndex + 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }},
                  style: FilledButton.styleFrom(
                    shape:const  CircleBorder(),
                    backgroundColor: AppColors.red,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.all(18),
                  ),
                  child:const  Icon(Icons.arrow_forward),
                ),

                // ButtonWidget(textOfButton: AppString.exportText, onClick: () {}),
              ],
            ),
          ),
        const SizedBox(height: 50),
          ButtonWidget(
            textOfButton: "Export ${Planet.planets[selectedIndex].name}",
            onClick: () {
              Navigator.pushNamed(
                context,
                PlanetScreen.routeName,
                arguments: Planet.planets[selectedIndex],
              );
            },
          ),
        ],
      ),
    );
  }
}

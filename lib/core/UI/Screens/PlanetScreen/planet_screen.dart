import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:spacer/Data%20Models/plant_model.dart';
import 'package:spacer/core/UI/Screens/CustomWidget/TextWidget.dart';
import 'package:spacer/core/thems/app_colors.dart';
import '../../../thems/assets/app_images.dart';

class PlanetScreen extends StatefulWidget {
  const PlanetScreen({super.key});

  static const String routeName = "PlanetScreen";

  @override
  State<PlanetScreen> createState() => _PlanetScreenState();
}

class _PlanetScreenState extends State<PlanetScreen> {
  late Flutter3DController controller = Flutter3DController();
  bool _isLoadingModel = true;
  bool _isPopping = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2400), () {
      if (mounted) {
        setState(() {
          _isLoadingModel = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dynamic args = ModalRoute
        .of(context)
        ?.settings
        .arguments;
    if (args is! Planet) {
      return const Scaffold(
        backgroundColor: AppColors.black,
        body: Center(
          child: Text(
            "Error Information not exist ",
            style: TextStyle(color: AppColors.white, fontSize: 18),
          ),
        ),
      );
    }
    final Planet planet = args;
    return PopScope(
        canPop: !_isPopping,
        onPopInvoked: (didPop) async {
          if (didPop) {
            return;
          }

          setState(() {
            _isPopping = true;
          });

          await Future.delayed(const Duration(milliseconds: 700));

          if (mounted) {
            Navigator.of(context).pop();
          }
        },

        child: Scaffold(
          backgroundColor: AppColors.black,
          body: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    AppImages.moonImage,
                    width: double.infinity,
                    semanticLabel: AppImages.moonImage,
                  ),
                  Positioned.fill(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
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
                            Text(
                              planet.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      planet.title,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white,
                                      ),
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
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 4,
                      bottom: 0,
                      top: 16,
                      right: 0,
                    ),
                    child: SafeArea(
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: FilledButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: AppColors.red,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.all(16),
                        ),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: Stack(
                        children: [
                          Flutter3DViewer(
                            controller: controller,
                            src: "assets/Models/${planet.model}",
                          ),
                          if (_isLoadingModel)
                            const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.red,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const Text(
                      "About",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      planet.about,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                      ),
                    ),
                    TextWidget(
                      title: "Distance from Sun (km) : ${planet
                          .distanceFromSun}",
                    ),
                    TextWidget(
                      title: "Length of Day (hours)  : ${planet.lengthOfDay}",
                    ),
                    TextWidget(
                      title:
                      "Orbital Period (Earth years) : ${planet.orbitalPeriod}",
                    ),
                    TextWidget(title: "Radius (km) : ${planet.radius}"),
                    TextWidget(title: "Mass (kg) : ${planet.mass}"),
                    TextWidget(title: "Gravity (m/s²) : ${planet.gravity}"),
                    TextWidget(
                        title: "Surface Area (km²) : ${planet.surfaceArea}"),
                  ],
                ),
              ),
            ],
          ),
        ));
    }
}

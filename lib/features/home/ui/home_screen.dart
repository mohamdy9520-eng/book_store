import 'package:book_store/features/home/ui/widgets/home_app_bar.dart';
import 'package:book_store/features/home/ui/widgets/slider.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Column(
          children: [
            HomeAppBar(),
            HomeSlider()
          ],
        
        ),
      ),
    );
  }
}

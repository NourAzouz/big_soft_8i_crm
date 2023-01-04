import 'package:flutter/material.dart';

import '../../core/view_models/intro_view_model.dart';
import '../shared/navigation_router_paths.dart';
import '../shared/size_config.dart';
import '../views/base_view.dart';
import '../widgets/intro_view_single_page.dart';

class IntroViewCarousel extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _IntroViewCarouselState createState() => _IntroViewCarouselState();
}

class _IntroViewCarouselState extends State<IntroViewCarousel> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<IntroViewModel>(
      onModelReady: (viewModel) => viewModel.setIntroViewAlreadySeenToTrue(),
      builder: (context, viewModel, child) => Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 83,
                          child: carouselBuilder(),
                        ),
                        const Expanded(child: SizedBox()),
                        _introViewCarouselFooter(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget carouselBuilder() {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      itemCount: introScreenList.length,
      onPageChanged: _onPageChanged,
      itemBuilder: (context, i) =>
          IntroViewSinglePage(introScreenModel: introScreenList[i]),
    );
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  Widget _introViewCarouselFooter() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        introViewCarouselButton(
          initialText: "PASSER",
          finalText: "",
          onPressAction: () => Navigator.pushReplacementNamed(
            context,
            NavigationRouterPaths.IP_ADDRESS_SETUP,
          ),
        ),
        const Expanded(child: SizedBox()),
        introViewCarouselDots(),
        const Expanded(child: SizedBox()),
        introViewCarouselButton(
          initialText: "SUIVANT",
          finalText: "TERMINER",
          onPressAction: () {
            if (_currentPage + 1 == introScreenList.length) {
              Navigator.pushReplacementNamed(
                context,
                NavigationRouterPaths.IP_ADDRESS_SETUP,
              );
            } else {
              _pageController.animateToPage(
                ++_currentPage,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            }
          },
        ),
      ],
    );
  }

  Widget introViewCarouselButton(
      {String? initialText,
      String? finalText,
      required VoidCallback onPressAction}) {
    return Container(
      height: SizeConfig.heightMultiplier * 7,
      width: SizeConfig.widthMultiplier * 30,
      child: TextButton(
        onPressed: onPressAction,
        child: Center(
          child: Text(
            (_currentPage + 1) != introScreenList.length
                ? initialText!
                : finalText!,
            style: TextStyle(
              color: Colors.purple,
              fontSize: SizeConfig.textMultiplier * 3.3,
            ),
          ),
        ),
      ),
    );
  }

  Widget introViewCarouselDots() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < introScreenList.length; i++)
          i == _currentPage
              ? const IntroScreenDots(true)
              : const IntroScreenDots(false)
      ],
    );
  }
}

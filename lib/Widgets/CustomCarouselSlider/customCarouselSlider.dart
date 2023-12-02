import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatelessWidget {
  final double? height;
  final List<Widget> carouselItems;
  final bool? autoPlay;
  final int? initialPage;
  final double? viewPortFraction;
  final Duration? autoPlayInterval;
  final CarouselController? carouselController;
  final dynamic Function(int, CarouselPageChangedReason)? onPageChanged;
  final bool? enableInfiniteScroll;

  CustomCarousel(
      {this.height,
        required this.carouselItems,
        this.autoPlay,
        this.onPageChanged,
        this.initialPage,
        this.carouselController,
        this.autoPlayInterval,
        this.enableInfiniteScroll,
        this.viewPortFraction});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        carouselController: carouselController,
        options: CarouselOptions(
            height: height ?? 150,
            viewportFraction: viewPortFraction ?? 0.9,
            initialPage: initialPage ?? 0,
            onPageChanged: onPageChanged,
            enableInfiniteScroll: enableInfiniteScroll ?? true,


            autoPlayInterval: autoPlayInterval!,
            padEnds: false,
            autoPlay: autoPlay ?? false),
        items: carouselItems);
  }
}
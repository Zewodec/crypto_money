import 'dart:math';

import 'package:flutter/material.dart';

import '../../data/models/asset_model.dart';

class CoinItem extends StatefulWidget {
  const CoinItem({
    super.key,
    required this.data,
    required this.tickerProvider,
  });

  final AssetModelData data;
  final TickerProvider tickerProvider;

  @override
  State<CoinItem> createState() => _CoinItemState();
}

class _CoinItemState extends State<CoinItem> {
  double _currentUsdPrice = 0;
  double _currentPercentChange = 0;

  late AnimationController _animationControllerUSDT;
  late AnimationController _animationControllerPercentageChange;

  late Animation<double> _animationUSDT;
  late Animation<double> _animationPercentageChange;

  late AnimationController _animationControllerScale;
  late Animation<double> _animationScale;

  @override
  void initState() {
    super.initState();

    Random random = Random();

    _animationControllerUSDT = AnimationController(
      duration: Duration(seconds: random.nextInt(3) + 1),
      vsync: widget.tickerProvider,
    );

    _animationUSDT = Tween<double>(begin: 0, end: widget.data.priceUsd ?? 0)
        .animate(CurvedAnimation(parent: _animationControllerUSDT, curve: Curves.easeInCubic))
      ..addListener(() {
        setState(() {
          _currentUsdPrice = _animationUSDT.value;
        });
      });

    _animationControllerPercentageChange = AnimationController(
      duration: Duration(seconds: random.nextInt(3) + 1),
      vsync: widget.tickerProvider,
    );

    _animationPercentageChange = Tween<double>(begin: 0, end: widget.data.changePercent24Hr ?? 0)
        .animate(CurvedAnimation(
            parent: _animationControllerPercentageChange, curve: Curves.easeInCubic))
      ..addListener(() {
        setState(() {
          _currentPercentChange = _animationPercentageChange.value;
        });
      });

    Future.delayed(Duration(milliseconds: random.nextInt(1000) + 500), () {
      _animationControllerUSDT.forward();
      _animationControllerPercentageChange.forward();
    });

    _animationControllerScale = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: widget.tickerProvider,
    );

    _animationScale = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _animationControllerScale, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: random.nextInt(1000) + 500), () {
      _animationControllerScale.forward();
    });
  }

  @override
  void dispose() {
    _animationControllerUSDT.dispose();
    _animationControllerPercentageChange.dispose();
    _animationControllerScale.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animationScale,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Text(widget.data.rank.toString(), style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.data.id ?? ''),
                Text(widget.data.symbol ?? ''),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${_currentPercentChange.toStringAsFixed(4)}%",
                  style: TextStyle(
                      color: double.parse(widget.data.changePercent24Hr!.toStringAsFixed(4)) >= 0
                          ? Colors.green
                          : Colors.red),
                ),
                Text("${_currentUsdPrice.toStringAsFixed(4)}\$"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

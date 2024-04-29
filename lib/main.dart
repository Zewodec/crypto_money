import 'package:crypto_money/features/assets/presentation/cubit/asset_cubit.dart';
import 'package:crypto_money/features/assets/presentation/widgets/coin_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Moneys',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AssetCubit assetCubit = AssetCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Crypto'),
      ),
      body: SafeArea(
        child: BlocBuilder<AssetCubit, AssetState>(
          bloc: assetCubit,
          builder: (context, state) {
            if (state is AssetInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AssetLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AssetLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24, top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "Updated: ${DateTime.fromMillisecondsSinceEpoch(state.assetsModel.timestamp!)}"),
                          const SizedBox(width: 16),
                          IconButton(
                              onPressed: () {
                                assetCubit.getAssets();
                              },
                              icon: const Icon(Icons.update_outlined)),
                        ],
                      ),
                    ),
                    ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      shrinkWrap: true,
                      itemCount: state.assetsModel.assetData?.length ?? 0,
                      itemBuilder: (context, index) {
                        return CoinItem(
                          data: state.assetsModel.assetData![index],
                          tickerProvider: this,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 16);
                      },
                    ),
                  ],
                ),
              );
            } else if (state is AssetError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

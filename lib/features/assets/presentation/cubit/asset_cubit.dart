import 'package:crypto_money/features/assets/data/models/asset_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'asset_state.dart';

class AssetCubit extends Cubit<AssetState> {
  AssetCubit() : super(AssetInitial()) {
    getAssets();
  }

  Dio dio = Dio();

  final String host = 'https://api.coincap.io';

  void getAssets() async {
    String assetsEndpoint = '$host/v2/assets';
    emit(AssetLoading());
    try {
      final response = await dio.get(assetsEndpoint);
      final assetsModel = AssetModel.fromJson(response.data);
      emit(AssetLoaded(assetsModel));
    } catch (e) {
      emit(AssetError(e.toString()));
    }
  }
}

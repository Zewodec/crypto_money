part of 'asset_cubit.dart';

@immutable
sealed class AssetState {}

final class AssetInitial extends AssetState {}

final class AssetLoading extends AssetState {}

final class AssetLoaded extends AssetState {
  final AssetModel assetsModel;

  AssetLoaded(this.assetsModel);
}

final class AssetError extends AssetState {
  final String message;

  AssetError(this.message);
}

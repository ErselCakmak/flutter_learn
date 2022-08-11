part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class FetchLoading extends HomeState {}

class FetchLoaded extends HomeState {
  final List<DataModel> items;

  const FetchLoaded({
    required this.items,
  });

  @override
  List<Object> get props => [items];

  FetchLoaded copyWith({
    List<DataModel>? items,
  }) {
    return FetchLoaded(
      items: items ?? this.items,
    );
  }
}

class FetchError extends HomeState {
  final Failure failure;

  const FetchError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

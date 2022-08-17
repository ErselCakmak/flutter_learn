part of 'home_cubit.dart';

enum FetchStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final List<DataModel>? data;
  final bool allLoaded;
  final FetchStatus status;
  final bool firstFetched;

  const HomeState({
    this.status = FetchStatus.initial,
    this.data,
    this.allLoaded = false,
    this.firstFetched = false,
  });

  @override
  List<Object?> get props => [data, allLoaded, status];

  HomeState copyWith({
    List<DataModel>? data,
    bool? allLoaded,
    FetchStatus? status,
    bool? firstFetched,
  }) {
    return HomeState(
      data: data ?? this.data,
      allLoaded: allLoaded ?? this.allLoaded,
      status: status ?? this.status,
      firstFetched: firstFetched ?? this.firstFetched,
    );
  }
}

class RefreshData extends HomeState {}

/*
class HomeInitial extends HomeState {}

class FetchLoading extends HomeState {
  final List<DataModel> oldData;
  final bool isFirstFetch;

  const FetchLoading(this.oldData, {this.isFirstFetch = false});
}

class FetchLoaded extends HomeState {
  final List<DataModel> data;
  final bool allLoaded;

  const FetchLoaded({
    required this.data,
    this.allLoaded = false,
  });

  @override
  List<Object> get props => [data, allLoaded];

  FetchLoaded copyWith({
    List<DataModel>? data,
    bool? allLoaded,
  }) {
    return FetchLoaded(
      data: data ?? this.data,
      allLoaded: allLoaded ?? this.allLoaded,
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
*/
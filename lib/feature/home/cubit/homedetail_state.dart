part of 'homedetail_cubit.dart';

abstract class HomedetailState extends Equatable {
  const HomedetailState();

  @override
  List<Object> get props => [];
}

class HomedetailInitial extends HomedetailState {}

class SaveLoading extends HomedetailState {}

class SaveLoaded extends HomedetailState {
  final List<ResponseModel> items;

  const SaveLoaded({
    required this.items,
  });

  @override
  List<Object> get props => [items];

  SaveLoaded copyWith({
    List<ResponseModel>? items,
  }) {
    return SaveLoaded(
      items: items ?? this.items,
    );
  }
}

class SaveError extends HomedetailState {
  final Failure failure;

  const SaveError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

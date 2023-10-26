part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  final String url;

  final bool dataFeatchingSuccess;

  const HomeState({required this.url, required this.dataFeatchingSuccess});
}

// ignore: must_be_immutable
final class HomeInitial extends HomeState {
  const HomeInitial({required super.url, required super.dataFeatchingSuccess});
}
